import 'package:flutter/material.dart';

class FavoritesManager extends ChangeNotifier {
  List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  void addFavorite(Map<String, dynamic> diary) {
    _favorites.add(diary);
    notifyListeners();
  }

  void removeFavorite(Map<String, dynamic> diary) {
    _favorites.remove(diary);
    notifyListeners();
  }

  bool isFavorite(Map<String, dynamic> diary) {
    return _favorites.contains(diary);
  }
}
