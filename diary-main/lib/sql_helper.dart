import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE diary(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        feeling TEXT,
        description TEXT,
        emoji INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        favorite INTEGER DEFAULT 0
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'diaryawie.db',
      version: 3,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
      onUpgrade: _onUpgrade,
    );
  }

  static Future<int> createDiary(String feeling, String? description, int? emoji) async {
    final db = await SQLHelper.db();

    final data = {'feeling': feeling, 'description': description, 'emoji': emoji};
    final id = await db.insert('diary', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getDiaries() async {
    final db = await SQLHelper.db();
    return db.query('diary', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getDiary(int id) async {
    final db = await SQLHelper.db();
    return db.query('diary', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateDiary(
      int id, String feeling, String? description, int? emoji, int? favorite) async {
    final db = await SQLHelper.db();

    final data = {
      'feeling': feeling,
      'description': description,
      'emoji': emoji,
      'createdAt': DateTime.now().toString(),
      'favorite': favorite
    };

    final result =
        await db.update('diary', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteDiary(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("diary", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting a diary: $err");
    }
  }

  static void _onUpgrade(sql.Database db, int oldVersion, int newVersion) {
    if (oldVersion < 2) {
      db.execute('ALTER TABLE diary ADD COLUMN emoji INTEGER');
      db.execute('ALTER TABLE diary ADD COLUMN favorite INTEGER DEFAULT 0');
    }
    // Add other migration logic for future schema changes if needed.
  }

  static Future<List<Map<String, dynamic>>> getFavoriteDiaries() async {
    final db = await SQLHelper.db();
    return db.query('diary', where: "favorite = 1", orderBy: "id");
  }

  static Future<void> updateDiaryFavorite(int id, int favorite) async {
    final db = await SQLHelper.db();

    final data = {'favorite': favorite};

    await db.update('diary', data, where: "id = ?", whereArgs: [id]);
  }
}
