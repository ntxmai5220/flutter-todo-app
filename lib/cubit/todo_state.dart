part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoaded extends TodoState {
  //state giữ data => dùng cho hiển thị (sẽ hiển thị lên listview - list todo)
  final List<Todo> todos;

  TodoLoaded(this.todos);
}
