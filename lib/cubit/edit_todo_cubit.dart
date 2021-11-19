import 'package:bloc/bloc.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:meta/meta.dart';

import 'package:flutter_todo_app/cubit/todo_cubit.dart';

part 'edit_todo_state.dart';

//Cubit này sử dụng cho trang create, edit...TodoPage
class EditTodoCubit extends Cubit<EditTodoState> {
  final TodoCubit _todoCubit;
  /*
  khi khởi tạo EditTodoCubit 
  -> phải gọi constructor của class cha (Cubit) nhận tham số là một state
  State này khong bắt buộc là initial, có thể thay đổi bằng các state xác định ở file kia

  thông thường khi tạo Cubit để dùng, Cubit sẽ có attribute là repository (hoặc là gì đó để có thể tương tác phía data)
  ở đây có TodoCubit(dùng cho trang home/list todo)
  để khi cập nhật ở đây thì gọi các method của TodoCubit để cập nhật lại UI, data liên quan
  */
  EditTodoCubit(this._todoCubit) : super(EditTodoInitial());     

  //khi muốn xóa một item todo thì gọi delete
  deleteTodo(Todo todo) {
    //bool deleted = true;
    // bool deleted = _todos.remove(todo);
    // if (deleted) {
    // }
    /*
    nếu có nguồn data (repository hay...) thì phải xử lý delete trên đó trước
    rồi mới gọi method của TodoCubit để cập nhật ở trang home
    nếu không gọi thì lúc back về UI không cập nhật lên (không thay đổi/xóa được)
    */
    _todoCubit.deleteTodo(todo);
    emit(DeletedTodo());    //phát ra/thay đổi state hiện tại để có thể thay đổi UI..
  }

  //tương tự với các method bên dưới
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
