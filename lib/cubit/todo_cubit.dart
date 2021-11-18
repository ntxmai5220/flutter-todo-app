import 'package:bloc/bloc.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  loadTodo(List<Todo> todos) {
    emit(TodoLoad(todos));
  }

  void updateTodoList() {
    final currentState = state;
    if (currentState is TodoLoad) emit(TodoLoad(currentState.todos));
  }

  addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodoLoad) {
      currentState.todos.add(todo);
      emit(TodoLoad(currentState.todos));
    }
  }

  void deleteTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodoLoad) {
      currentState.todos.remove(todo);
      emit(TodoLoad(currentState.todos));
    }
  }

  void deleteTodoByIndex(int index) {
    final currentState = state;
    if (currentState is TodoLoad) {
      currentState.todos.removeAt(index);
      emit(TodoLoad(currentState.todos));
    }
  }
}
