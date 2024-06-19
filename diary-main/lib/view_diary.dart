import 'package:flutter/material.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'favorite_page.dart';
import 'package:diaryapp/util/emoticon.dart';
import 'package:diaryapp/component/model_emoji.dart'; // Import the emoji model


class DiaryInfoPage extends StatefulWidget {
  final String title;
  final String description;
  final void Function(int?) onEmoticonSelected; // Change to non-nullable type

  DiaryInfoPage({
    Key? key,
    required this.title,
    required this.description,
    required this.onEmoticonSelected, 
  }) : super(key: key);

  @override
  State<DiaryInfoPage> createState() => _DiaryInfoPageState();
}

class _DiaryInfoPageState extends State<DiaryInfoPage> {
  int? _selectedEmoticon;

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
  final TextEditingController _feelingController = TextEditingController(text: widget.title);
  final TextEditingController _descriptionController = TextEditingController(text: widget.description);

    
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
                        Text('Dear Diary,',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        SizedBox(height: 8,),
                        //Date
                        Text(
                      '23 Jan, 2021',
                      style: TextStyle(color: Colors.blue[200]),
                      ),
                      ],
                      
                    ),
                    //Favorite button
                    
                    
      
                     Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadiusDirectional.circular(12),
                        ),
                         padding: EdgeInsets.all(12),
                         child: IconButton(
      
                          icon: Icon(Icons.favorite),
                          onPressed: () => FavoritePage(),
                          
                              /*icon: _favorites.contains(_diaries[index])
                                  ? Icon(Icons.favorite, color: Colors.red)
                                  : Icon(Icons.favorite_border),
                              onPressed: () {
                                
                                // Toggle favorite status when the favorite button is pressed
                                if (_favorites.contains(_diaries[index])) {
                                  _favorites.remove(_diaries[index]);
                                } else {
                                  _addToFavorites(_diaries[index]);
                                }
                              },*/
                            ),
                       ),
                                   
                ],
                  ),
            
                  SizedBox(height: 25,),
            
                  //title textfield
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
                        borderRadius: BorderRadius.circular(12), // Border radius
                      borderSide: BorderSide.none, // No border
                       ),
                        prefixIcon: Icon(
                          Icons.edit_outlined,
                          color: Colors.white,),
                        ),
                      ),
              SizedBox(height: 20,),
            
                      //feeling
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
                            color: Colors.white,)
                        ],
                      ),
            
                      SizedBox(height: 25,),
            
                      
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
                // End of the SingleChildScrollView
                
      
                SizedBox(height: 25,),
      
                //description
      
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
                        borderRadius: BorderRadius.circular(12), // Border radius
                      borderSide: BorderSide.none,
                       // No border
                       ),
                        
                        ),
                      ),  
      
                      ElevatedButton(
                          onPressed: () async {
                  final String newFeeling = _feelingController.text;
                  final String newDescription = _descriptionController.text;
                  

                            Navigator.pop(
                              context,
                              {
                                'newFeeling': newFeeling,
                                'newDescription': newDescription,
                                'selectedEmoticon': _selectedEmoticon,
                              },
                            );
                          },
                          child: Text('Save Diary'),
                        ),
            
                        ],)
                                     
            ),
            ),
      ),
      
    );
  }
}
