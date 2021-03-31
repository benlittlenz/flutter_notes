import 'package:flutter/material.dart';

//import 'package:/flutter/widgets.dart';
//import 'package:flutter/material.dart';
import 'package:provider_notes/providers/NoteCollection.dart';

class HomeScreen extends StatelessWidget
{
  var collection = NoteCollection();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes')
      ),
      body: _buildNotesList()
    );
  }

  Widget _buildNotesList () {
    return ListView.builder(
      itemCount: collection.count,
      itemBuilder: (context, index) {
        var note = collection.allNotes[index];

        return ListTile(
          title: Text(note.body),
        );
      }
    );
  }
}