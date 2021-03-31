import 'package:flutter/material.dart';
import 'package:provider_notes/models/Note.dart';

class NoteScreen extends StatefulWidget
{
  final Note _note;
  NoteScreen({ Key key, note}) : _note = note;

  @override
  State<StatefulWidget> createState() {
    return NoteScreenState(
      note: _note,
    );
  }
}

class NoteScreenState extends State<NoteScreen> {
  final Note _note;
  NoteScreenState({ Key key, note}) : _note = note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_note.body),
      ),
    );
  }
}