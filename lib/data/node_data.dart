import 'package:flutter_todo_app/models/note_model.dart';
class Data {
  static List<Note> todos = [];

  static List<Note> genData() {
    int i = 0;
    while (i < 5) {
      todos.add(Note(title: 'title $i', content: 'content ne ${i++}'));
    }
    return todos;
  }
}
