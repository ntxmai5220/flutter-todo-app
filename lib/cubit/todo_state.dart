part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoad extends TodoState {
  final List<Todo> todos;

  TodoLoad(this.todos);
}
