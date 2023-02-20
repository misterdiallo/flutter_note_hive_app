import 'package:hive_flutter/hive_flutter.dart';

import 'note.dart';

class NotesRepository {
  static const String _notesBoxName = 'notes';

  late final Box<Note> _notesBox;

  NotesRepository(this._notesBox);

  Future<List<Note>> getNotes() async {
    return _notesBox.values.toList();
  }

  Future<Note?> getNoteById(int id) async {
    return _notesBox.get(id);
  }

  Future<void> addNote(Note note) async {
    await _notesBox.add(note);
  }

  Future<void> updateNoteById(int id, Note note) async {
    await _notesBox.put(id, note);
  }

  Future<void> deleteNoteById(int id) async {
    await _notesBox.delete(id);
  }
}
