import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/note_data.dart';
import 'package:flutter_todo_app/pages/pages.dart';
import 'package:flutter_todo_app/providers/providers.dart';
import 'package:provider/provider.dart';

void main() {
  Data.genData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=>NoteProvider()..fetch(),
        ),
        ChangeNotifierProvider(
          create: (_) => EditProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: HomePage(),
      ),
    );
  }
}
