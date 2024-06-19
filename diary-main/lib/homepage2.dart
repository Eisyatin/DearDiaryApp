import 'package:diaryapp/component/model_emoji.dart';
import 'package:diaryapp/create_diary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sql_helper.dart';
import './add_Diary.dart';
import './view_diary.dart';
import 'favorite_page.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:diaryapp/util/theme_provider.dart';
import 'package:diaryapp/util/change_theme_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diaryapp/util/ClickFavorite.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // All diaries
  List<Map<String, dynamic>> _diaries = [];
  // Favorite items
  List<Map<String, dynamic>> _favorites = [];

  bool _isLoading = true;
  int? _selectedEmoticon = 1; // Variable to store the selected emoticon as an integer

  // This function is used to fetch all data from the database
  void _refreshDiaries() async {
    final data = await SQLHelper.getDiaries();
    setState(() {
      _diaries = data;
      _isLoading = false;
    });
  }


  @override
  void initState() {
    super.initState();
    _refreshDiaries(); // Loading the diary when the app starts
  }

  final TextEditingController _feelingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  

  void _showDiary(int? id) async {
  final Map<String, dynamic>? newDiaryData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateDiary(
          onEmoticonSelected: (selectedEmoticon) {
            setState(() {
              // Store the selected emoticon in the diary data
            _selectedEmoticon = selectedEmoticon;

            });
          },
        ),
      ),
    );

    

  if ( newDiaryData != null) {
    
    final String feeling = newDiaryData['feeling'] as String;
    final String description = newDiaryData['description'] as String;
    final int selectedEmoticon = newDiaryData['selectedEmoticon'] as int;


    await _addDiary(feeling, description, selectedEmoticon);

    // ...
  } else {
    _feelingController.text = '';
    _descriptionController.text = '';
  }
}


  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update a diary
  
    void _showForm(int? id,) async {

      if (id != null) {
        // id == null -> create new diary
        // id != null -> update an existing diary
        final existingDiary = _diaries.firstWhere((element) => element['id'] == id);
        _feelingController.text = existingDiary['feeling'];
        _descriptionController.text = existingDiary['description'];
        _selectedEmoticon = existingDiary['emoji'];

      } else {
        _feelingController.text = '';
        _descriptionController.text = '';
        _selectedEmoticon = null;
      }

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiaryInfoPage(
            title: _feelingController.text,
            description: _descriptionController.text,
            //selectedEmoticon: _selectedEmoticon,
            onEmoticonSelected: (selectedEmoticon) {
                setState(() {
                  // Store the selected emoticon in the diary data
                //newDiaryData?['selectedEmoticon'] = selectedEmoticon;
                _selectedEmoticon = selectedEmoticon;

                });
              },
          ),
        ),
      );

      if (result != null) {
    final String newFeeling = result['newFeeling'];
    final String newDescription = result['newDescription'];
    final int selectedEmoticon = result['selectedEmoticon'];

    if (id != null) {
  final existingDiary = _diaries.firstWhere((element) => element['id'] == id);
  //final int currentFavorite = existingDiary['favorite'] as int ?? 0; // Get the current favorite status

  // Update the diary with the opposite favorite status
  _updateDiary(id, newFeeling, newDescription, selectedEmoticon, 0);
} else {
  // Insert a new diary to the database
  _addDiary(newFeeling, newDescription, selectedEmoticon);
}


  }
}


  

// Insert a new diary to the database
  Future<void> _addDiary(String feeling, String description, int emoji) async {
    await SQLHelper.createDiary(feeling, description, emoji);
    _refreshDiaries();
  }

  // Update an existing diary
  Future<void> _updateDiary(int id,String feeling, String description, int emoji, int favorite) async {
    await SQLHelper.updateDiary(
        id, feeling, description, emoji, favorite);
    _refreshDiaries();
  }

  // Delete an item
  Future<void> _deleteDiary(int id) async {
    await SQLHelper.deleteDiary(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a diary!'),
    ));
    _refreshDiaries();
  }

  // Utility function to get AnimatedEmojiData from an integer value
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
    // Add more cases as needed
    default:
      return AnimatedEmojis.smile; // Default to smile if no match
  }
}


// void _toggleFavorite(Map<String, dynamic> diary) async {
//   final int id = diary['id'];
//   final bool isFavorite = diary['_favorite'] == 1;

//   await SQLHelper.updateDiary(
//     id,
//     diary['feeling'],
//     diary['description'],
//     diary['emoji'],
//     isFavorite ? 0 : 1, // Toggle favorite value (0 -> 1, 1 -> 0)
//   );

//   setState(() {
//     diary['_favorite'] = isFavorite ? 0 : 1; // Toggle favorite status
//   });
// }

Future<void> _toggleFavorite(int id, int favorite) async {
  // Toggle the favorite status
  final int updateFavorite = favorite == 0 ? 1 : 0;
print('toggle');
  print(favorite);

  // Update the diary entry with the new favorite status
  await SQLHelper.updateDiaryFavorite(id, updateFavorite);

  // Refresh the list of diaries
  _refreshDiaries();
}


  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dear Diary", style: TextStyle(color: Colors.white),),
        //iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.pink,),
            onPressed: () {
              // Navigate to the FavoritePage when the favorite icon is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritePage(),
                ),
              );
            },
          ),
          ChangeThemeButtonWidget(),

        ],
      ),
      drawer: Drawer(
        child: Column(children: [
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
                  leading: Icon(Icons.home_filled,color: Colors.blue[900],),
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
                    leading: Icon(Icons.favorite,color: Colors.pink,),
                    title: Text("Favorite"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FavoritePage(),
                        ),
                      );
                    }),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.blue[900],),
                  title: Text('Sign Out'),
                  onTap: () => FirebaseAuth.instance.signOut(),
                ),
                          ],
                        ),
              ))
        ]),
      ),
      

      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _diaries.length,
              itemBuilder: (context, index) {
                final diary = _diaries[index];
                return GestureDetector(
                  onTap: () => _showForm(diary['id']),
                  child: Card(
                    color: Colors.blue[600],
                    margin: const EdgeInsets.all(20),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: AnimatedEmoji(
                            getAnimatedEmojiFromValue(diary['emoji']), // Use the selected emoticon data
                            size: 30.0,
                          ),
                          backgroundColor: Colors.blue[600],
                        ),
                        title: Text(diary['feeling'], style: TextStyle(color: Colors.yellow[600], fontWeight: FontWeight.bold),),
                        subtitle: Text(
                            diary['description'] + '\n\n' + diary['createdAt'], 
                            style: TextStyle(color: Colors.white)
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.white,),
                                onPressed: () => _deleteDiary(diary['id']),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: (diary['favorite'] ?? 0) == 1 ? Colors.pink : Colors.white,
                                ),
                                onPressed: () {
                                  print('favorte:');
                                    print(diary['favorite']);
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showDiary(null),
      ),
    );
  }
}