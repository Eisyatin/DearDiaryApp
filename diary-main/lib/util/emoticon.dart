import 'package:flutter/material.dart';
import 'package:animated_emoji/animated_emoji.dart';
import './displayEmoticonPage.dart';

class EmoticonFace extends StatefulWidget {
  final AnimatedEmojiData emoticonFace;
  final Function(AnimatedEmojiData) onTap;
  bool isSelected;

  EmoticonFace({
    Key? key,
    required this.emoticonFace,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<EmoticonFace> createState() => _EmoticonFaceState();
}

class _EmoticonFaceState extends State<EmoticonFace> {
  Color _containerColor = const Color.fromARGB(255, 30, 136, 229);

  void _onContainerTap() {
    setState(() {
      widget.onTap(widget.emoticonFace); // Call the onTap callback with the selected emoticon
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onContainerTap,
      child: Container(
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.white : const Color.fromARGB(255, 30, 136, 229),
          borderRadius: BorderRadiusDirectional.circular(20),
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: AnimatedEmoji(
            widget.emoticonFace,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}

