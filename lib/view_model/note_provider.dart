import 'package:flutter/material.dart';
import '../data/note_data_source.dart';
import '../model/note.dart';

class NoteProvider with ChangeNotifier {
  final NoteDataSource _dataSource = NoteDataSource();
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  NoteProvider(){
    loadNotes();
  }

  Future<void> loadNotes() async {
    _notes = await _dataSource.getNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _dataSource.addNote(note);
    await loadNotes();
  }
}