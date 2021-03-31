import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_notes/models/Note.dart';
import 'package:provider_notes/providers/NoteCollection.dart';

class NoteScreen extends StatefulWidget {
  final Note _note;
  NoteScreen({Key key, note}) : _note = note;

  @override
  State<StatefulWidget> createState() {
    return NoteScreenState(
      note: _note,
    );
  }
}

class NoteScreenState extends State<NoteScreen> {
  final Note _note;
  NoteScreenState({Key key, note}) : _note = note;

  final TextEditingController bodyController = TextEditingController();

  void initState() {
    super.initState();

    bodyController.text = _note.body;

    bodyController.addListener(() {
      Provider.of<NoteCollection>(context).updateNote(
        _note.id,
        _note.body
      )
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_note.body),
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: Container(
                  child: TextField(
                    controller: bodyController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                          hintText: "Start writing your note here",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20)))))
        ]));
  }
}
