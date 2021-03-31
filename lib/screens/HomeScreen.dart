import 'package:flutter/material.dart';
import 'package:provider_notes/models/Note.dart';

import 'package:uuid/uuid.dart';

//import 'package:/flutter/widgets.dart';
//import 'package:flutter/material.dart';
import 'package:provider_notes/providers/NoteCollection.dart';

class HomeScreen extends StatelessWidget
{
  var uuid = Uuid();
  var collection = NoteCollection();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes')
      ),
      body: _buildNotesList(),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Note note = Note(
            id: uuid.v4(),
          );

          debugPrint(note.id.toString());
        },
      ),
    );
  }

  Widget _buildNotesList () {
    var allNotes = collection.allNotes;

    if(allNotes.length == 0) {
      return Center(
        child: Text('No Notes'),
      );
    }

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