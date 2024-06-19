import 'package:flutter/material.dart';
import 'package:animated_emoji/animated_emoji.dart';

class DisplayEmoticonPage extends StatelessWidget {
  final AnimatedEmojiData emoticonFace;

  DisplayEmoticonPage({required this.emoticonFace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Emoticon'),
      ),
      body: Center(
        child: AnimatedEmoji(
          emoticonFace,
          size: 60.0,
        ),
      ),
    );
  }
}
