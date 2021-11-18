part of 'edit_todo_cubit.dart';

@immutable
abstract class EditTodoState {}

class EditTodoInitial extends EditTodoState {}

class CreateTodo extends EditTodoState {}

class EditingTodo extends EditTodoState {}

class ViewTodo extends EditTodoState {}

class DeletedTodo extends EditTodoState {}
