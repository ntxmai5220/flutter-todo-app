import 'package:bloc/bloc.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:meta/meta.dart';

import 'package:flutter_todo_app/cubit/todo_cubit.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final TodoCubit _todoCubit;
  EditTodoCubit(this._todoCubit) : super(EditTodoInitial());

  deleteTodo(Todo todo) {
    //bool deleted = true;
    // bool deleted = _todos.remove(todo);
    // if (deleted) {

    // }
    _todoCubit.deleteTodo(todo);
    emit(DeletedTodo());
  }

  editTodo() {
    emit(EditingTodo());
  }

  updateTodo(Todo todo, Todo update) {
    //emit(EditingTodo());
    
    todo.title = update.title;
    todo.content = update.content;
    _todoCubit.updateTodoList();
    emit(ViewTodo());
  }

  createTodo() {
    emit(CreateTodo());
  }

  saveTodo(Todo todo) {
    //emit(CreateTodo());
    //_todos.add(todo);
    _todoCubit.addTodo(todo);
    emit(ViewTodo());
  }
}
