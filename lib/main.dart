import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/cubit/todo_cubit.dart';
import 'package:flutter_todo_app/helper/locator.dart';
import 'package:flutter_todo_app/pages/home_page.dart';

import 'data/todo_data.dart';

Future<void> main() async {
  await setupLocator(); // setup, tạo các instance hoàn tất mới tiến hành run app
  Data.genData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final AppRouter? router;        -> sẽ tìm hiểu thêm sau

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: BlocProvider(
        /*
        Giúp tạo Cubit hoặc Bloc
        có thể truy cập vào các thành phần của Cubit/Bloc thông qua BlocProvider.of<...>(context) -> có dùng ở home, và todopage
        có thể dùng BlocBuilder, BlocListener
        hay BlocConsumer = BlocBuilder + BlocListener
        */
        create: (context) => getIt<TodoCubit>(),  //Sử dụng class khi đã đăng ký  với GetIt
        child: HomePage(),
      ),
      //onGenerateRoute: router!.,
    );
  }
}
