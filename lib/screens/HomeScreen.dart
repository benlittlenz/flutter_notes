import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_notes/models/Note.dart';

import 'package:uuid/uuid.dart';

//import 'package:/flutter/widgets.dart';
//import 'package:flutter/material.dart';
import 'package:provider_notes/providers/NoteCollection.dart';
import 'package:provider_notes/screens/NoteScreen.dart';

class HomeScreen extends StatelessWidget {
  var uuid = Uuid();
  var collection = NoteCollection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<NoteCollection>(
        builder: (context, notes, child) {
          return Text('Notes (${notes.count})');
        },
        )
      ),
      body: _buildNotesList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Note note = Note(
            id: uuid.v4(),
          );

          Provider.of<NoteCollection>(context, listen: false).addNote(note);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteScreen(
                note: note
              )
            )
          );
        },
      ),
    );
  }

  Widget _buildNotesList() {
    return Consumer<NoteCollection>(builder: (context, notes, child) {
      var allNotes = notes.allNotes;

      if (allNotes.length == 0) {
        return Center(
          child: Text('No Notes'),
        );
      }

      return ListView.builder(
          itemCount: notes.count,
          itemBuilder: (context, index) {
            var note = notes.allNotes[index];

            return Dismissible(
              key: Key(note.id),
              background: Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.delete, color: Colors.white),
                      Text("Move to trash", style: TextStyle(color: Colors.white))
                    ],
                  )
                )
              ),
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete Confirmation"),
                      content: const Text("Are you sure you want to delete this note?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Delete")
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Cancel")
                        ),
                      ]
                    );
                  }
                  );
              },
              onDismissed: (direction) {
                Provider.of<NoteCollection>(context).deleteNote(note);
              },
              child: ListTile(
              title: Text(note.body),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NoteScreen(
                      note: note
                    )
                )
                );
                }
              )
            );
          });
    });
  }
}
