import 'package:flutter/material.dart';
import 'package:provider_notes/models/Note.dart';

class NoteCollection extends ChangeNotifier
{
  final List<Note> _notes = [
    Note(id: '1', body: 'First Note'),
    Note(id: '2', body: 'Second Note'),
  ];

  get count {
    return _notes.length;
  }

  get allNotes => _notes;
}