import 'package:bloc/bloc.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  loadTodo(List<Todo> todos) {
    /*
    Load data để hiển thị lên
    nếu load thành công thì đổi state từ TodoInitial (lúc khởi tạo) -> TodoLoaded (đã load được)
    */
    emit(TodoLoaded(todos));
  }

  void updateTodoList() {
    // state là state hiện tại
    final currentState = state;
    //kiểm tra xem đã load được data chưa mới có thể tiến hành update/delte/create
    if (currentState is TodoLoaded) emit(TodoLoaded(currentState.todos));
  }


  addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodoLoaded) {
      currentState.todos.add(todo);
      emit(TodoLoaded(currentState.todos));
    }
  }

  void deleteTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodoLoaded) {
      currentState.todos.remove(todo);
      emit(TodoLoaded(currentState.todos));
    }
  }

  void deleteTodoByIndex(int index) {
    final currentState = state;
    if (currentState is TodoLoaded) {
      currentState.todos.removeAt(index);
      emit(TodoLoaded(currentState.todos));
    }
  }
}
