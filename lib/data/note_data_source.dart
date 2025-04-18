import 'package:hive/hive.dart';
import '../model/note.dart';

class NoteDataSource{

  static const String dbName = "notesBox";

  Future<void> addNote(Note note) async{
    var box = await Hive.openBox<Note>(dbName);
    await box.add(note);
  }

  Future<List<Note>> getNotes() async {
    var box = await Hive.openBox<Note>(dbName);
    return box.values.toList();
  }
}