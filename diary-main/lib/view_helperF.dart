import 'package:flutter/material.dart';

class DiaryInfoPage extends StatelessWidget {
  final String feeling;
  final String description;
  final String emoji;

  DiaryInfoPage({required this.feeling, required this.description, required this. emoji});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary Info'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: TextEditingController(text: "$feeling"),
            decoration: InputDecoration(hintText: 'Feeling'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: TextEditingController(text: "$description"),
            decoration: InputDecoration(hintText: 'Description'),
            maxLines: 10,
          ),
        ],
      ),
    );
  }
}