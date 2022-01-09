import 'package:flutter_todo_app/models/note_model.dart';

class Data {
  static List<Note> notes = [];

  static List<Note> genData() {
    int i = 0;
    while (i < 2) {
      notes.add(Note(title: 'title $i', content: 'content ne ${i++}'));
    }
    return notes;
  }
}
