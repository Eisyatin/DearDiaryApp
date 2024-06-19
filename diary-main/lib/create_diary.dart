import 'package:diaryapp/util/displayEmoticonPage.dart';
import 'package:diaryapp/util/emoticon.dart';
import 'package:flutter/material.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'favorite_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage2.dart';
import 'package:diaryapp/component/model_emoji.dart'; // Import the emoji model

class CreateDiary extends StatefulWidget {
  final void Function(int?) onEmoticonSelected;

  CreateDiary({required this.onEmoticonSelected, Key? key}) : super(key: key);

  @override
  State<CreateDiary> createState() => _CreateDiaryState();
}

class _CreateDiaryState extends State<CreateDiary> {
  int? _selectedEmoticon; // Variable to store the selected emoticon as an integer

  List<Map<String, dynamic>> _favorites = [];
  List<Map<String, dynamic>> _diaries = [];

  final TextEditingController _feelingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addToFavorites(Map<String, dynamic> item) {
    setState(() {
      _favorites.add(item);
    });
  }

  void _onEmoticonTap(AnimatedEmojiData emoticonFace) {
    setState(() {
      if (_selectedEmoticon == ModelEmoji.getEmojiValue(emoticonFace)) {
        // If the tapped emoticon is already selected, deselect it
        _selectedEmoticon = null;
      } else {
        // Otherwise, select the new emoticon
        _selectedEmoticon = ModelEmoji.getEmojiValue(emoticonFace);

        // Pass the selected emoticon back to the HomePage
        widget.onEmoticonSelected(_selectedEmoticon);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dear Diary,',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        // Date
                        Text(
                          '27 May, 2024',
                          style: TextStyle(color: Colors.blue[200]),
                        ),
                      ],
                    ),
                    // Home button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadiusDirectional.circular(12),
                      ),
                      padding: EdgeInsets.all(4),
                      child: IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.home_filled),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                // Title textfield
                TextField(
                  controller: _feelingController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blue[600],
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Feeling
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'How do you feel?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 25),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Happy
                      Column(
                        children: [
                          EmoticonFace(
                            emoticonFace: AnimatedEmojis.smile,
                            onTap: _onEmoticonTap,
                            isSelected: _selectedEmoticon == ModelEmoji.getEmojiValue(AnimatedEmojis.smile),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Happy',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(width: 5),
                      // Angry
                      Column(
                        children: [
                          EmoticonFace(
                            emoticonFace: AnimatedEmojis.rage,
                            onTap: _onEmoticonTap,
                            isSelected: _selectedEmoticon == ModelEmoji.getEmojiValue(AnimatedEmojis.rage),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Angry',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(width: 5),
                      // Funny
                      Column(
                        children: [
                          EmoticonFace(
                            emoticonFace: AnimatedEmojis.rofl,
                            onTap: _onEmoticonTap,
                            isSelected: _selectedEmoticon == ModelEmoji.getEmojiValue(AnimatedEmojis.rofl),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Funny',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(width: 5),
                      // Bad
                      Column(
                        children: [
                          EmoticonFace(
                            emoticonFace: AnimatedEmojis.happyCry,
                            onTap: _onEmoticonTap,
                            isSelected: _selectedEmoticon == ModelEmoji.getEmojiValue(AnimatedEmojis.happyCry),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Bad',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(width: 5),
                      // Loving
                      Column(
                        children: [
                          EmoticonFace(
                            emoticonFace: AnimatedEmojis.heartFace,
                            onTap: _onEmoticonTap,
                            isSelected: _selectedEmoticon == ModelEmoji.getEmojiValue(AnimatedEmojis.heartFace),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Loving',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(width: 5),
                      // Sleepy
                      Column(
                        children: [
                          EmoticonFace(
                            emoticonFace: AnimatedEmojis.sleep,
                            onTap: _onEmoticonTap,
                            isSelected: _selectedEmoticon == ModelEmoji.getEmojiValue(AnimatedEmojis.sleep),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Sleepy',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                // Description
                TextField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  maxLines: 10,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blue[600],
                    hintText: "Description",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(
                      context,
                      {
                        'feeling': _feelingController.text,
                        'description': _descriptionController.text,
                        'selectedEmoticon': _selectedEmoticon,
                      },
                    );
                  },
                  child: Text('Save Diary'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
