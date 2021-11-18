import 'package:flutter_todo_app/models/todo_model.dart';

class Data {
  static List<Todo> todos = [];

  static List<Todo> genData() {
    int i = 0;
    while (i < 5) {
      todos.add(Todo(title: 'title $i', content: 'content ne ${i++}'));
    }
    return todos;
  }
}
