import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/data/note_data.dart';
import 'package:flutter_todo_app/models/note_model.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  //fetch
  void fetch() {
    _notes = Data.notes;
    notifyListeners();
  }

  //update
  void update(int id, Note note) {
    _notes[id] = note;
    notifyListeners();
  }

  //create
  void add(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  //remove
  void remove(int id) {
    _notes.removeAt(id);
    notifyListeners();
  }
}
