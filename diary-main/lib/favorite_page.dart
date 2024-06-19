import 'package:flutter/material.dart';
import 'homepage2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sql_helper.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:diaryapp/util/theme_provider.dart';
import 'package:diaryapp/util/change_theme_button.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, dynamic>> _favorites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFavoriteDiaries();
  }

  Future<void> _fetchFavoriteDiaries() async {
    final favoriteDiaries = await SQLHelper.getFavoriteDiaries();
    setState(() {
      _favorites = favoriteDiaries;
      _isLoading = false;
    });
  }

  Future<void> _toggleFavorite(int id, int favorite) async {
    final int updatedFavorite = favorite == 0 ? 1 : 0;
    await SQLHelper.updateDiaryFavorite(id, updatedFavorite);
    _fetchFavoriteDiaries();
  }

  AnimatedEmojiData getAnimatedEmojiFromValue(int? value) {
    switch (value) {
      case 1:
        return AnimatedEmojis.smile;
      case 2:
        return AnimatedEmojis.rage;
      case 3:
        return AnimatedEmojis.rofl;
      case 4:
        return AnimatedEmojis.happyCry;
      case 5:
        return AnimatedEmojis.heartFace;
      case 6:
        return AnimatedEmojis.sleep;
      default:
        return AnimatedEmojis.smile;
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Diaries", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [ChangeThemeButtonWidget()],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 100,
              color: Colors.white,
              child: Text(
                "Welcome!",
                style: TextStyle(fontSize: 20, color: Colors.blue[900]),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: Icon(Icons.home_filled, color: Colors.blue[900]),
                      title: Text("Home"),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.favorite, color: Colors.pink),
                      title: Text("Favorite"),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FavoritePage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.blue[900]),
                      title: Text('Sign Out'),
                      onTap: () => FirebaseAuth.instance.signOut(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final diary = _favorites[index];
                return GestureDetector(
                  child: Card(
                    color: Colors.blue[600],
                    margin: const EdgeInsets.all(20),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: AnimatedEmoji(
                            getAnimatedEmojiFromValue(diary['emoji']),
                            size: 30.0,
                          ),
                          backgroundColor: Colors.blue[600],
                        ),
                        title: Text(
                          diary['feeling'],
                          style: TextStyle(color: Colors.yellow[600], fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          diary['description'] + '\n\n' + diary['createdAt'],
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.favorite, color: (diary['favorite'] ?? 0) == 1 ? Colors.pink : Colors.white),
                                onPressed: () {
                                  _toggleFavorite(diary['id'], diary['favorite'] ?? 0);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
