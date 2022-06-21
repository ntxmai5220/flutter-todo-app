import 'package:flutter/material.dart';
import 'package:flutter_todo_app/pages/home_page.dart';

import 'data/node_data.dart';

void main() {
  Data.genData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomePage(),
    );
  }
}
