import 'package:provider_notes/models/Note.dart';

class NoteCollection
{
  final List<Note> _notes = [
    Note(id: '1', body: 'First Note'),
    Note(id: '2', body: 'Second Note'),
  ];

  get allNotes => _notes;
}