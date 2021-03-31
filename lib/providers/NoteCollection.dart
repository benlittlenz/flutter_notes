import 'package:flutter/material.dart';
import 'package:provider_notes/models/Note.dart';

class NoteCollection extends ChangeNotifier
{
  final List<Note> _notes = [];

  get count {
    return _notes.length;
  }

  get allNotes => _notes;

  void addNote (Note note) {
    _notes.add(note);

    notifyListeners();
  }
}