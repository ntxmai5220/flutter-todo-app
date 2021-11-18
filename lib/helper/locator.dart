
import 'package:flutter_todo_app/cubit/edit_todo_cubit.dart';
import 'package:flutter_todo_app/cubit/todo_cubit.dart';
import 'package:flutter_todo_app/data/todo_data.dart';
import 'package:get_it/get_it.dart';

final getIt=GetIt.instance;
Future<void> setupLocator() async{

  getIt.registerSingleton(TodoCubit());
  getIt.registerSingleton(EditTodoCubit(Data.todos, getIt<TodoCubit>()));
  //getIt.registerSingleton(instance)
}