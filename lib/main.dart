import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/cubit/todo_cubit.dart';
import 'package:flutter_todo_app/helper/locator.dart';
import 'package:flutter_todo_app/pages/home_page.dart';

import 'data/todo_data.dart';

Future<void> main() async {
  await setupLocator();
  Data.genData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final AppRouter? router;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: BlocProvider(
        create: (context) => getIt<TodoCubit>(),
        child: HomePage(),
      ),
      //onGenerateRoute: router!.,
    );
  }
}
