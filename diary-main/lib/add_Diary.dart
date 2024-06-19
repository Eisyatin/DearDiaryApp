import 'package:flutter/material.dart';

class AddDiaryPage extends StatefulWidget {
  @override
  _AddDiaryPageState createState() => _AddDiaryPageState();
}

class _AddDiaryPageState extends State<AddDiaryPage> {
  final TextEditingController _feelingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Diary'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _feelingController,
            decoration: InputDecoration(
              hintText: 'Feeling',
            ),
          ),
          TextField(
            controller: _descriptionController,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: 'Description',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                {
                  'feeling': _feelingController.text,
                  'description': _descriptionController.text,
                },
              );
            },
            child: Text('Save Diary'),
          ),
        ],
      ),
    );
  }
}