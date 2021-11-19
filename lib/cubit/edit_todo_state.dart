part of 'edit_todo_cubit.dart';
/*
Cubit ~ tập con/ thành phần con của Bloc
thay vì Bloc có <event,state> ~ map các event và state với nhau
Cubit<state> dùng các method để thay đổi state (emit các state trong hiện thực method)
*/
@immutable
abstract class EditTodoState {} //xác định các state có thể có
//mỗi state ứng với UI khác nhau 

class EditTodoInitial extends EditTodoState {}

class CreateTodo extends EditTodoState {}

class EditingTodo extends EditTodoState {}

//state ViewTodo có thể thừa -> có thể dùng EditTodoInitial
class ViewTodo extends EditTodoState {}

class DeletedTodo extends EditTodoState {}
