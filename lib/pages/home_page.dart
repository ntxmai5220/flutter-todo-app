import 'package:flutter/material.dart';
import 'package:flutter_todo_app/pages/pages.dart';
import 'package:flutter_todo_app/providers/providers.dart';
import 'package:flutter_todo_app/values/values.dart';

import 'package:provider/provider.dart';
import 'package:flutter_todo_app/widgets/note_item.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildSearch() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        width: double.maxFinite,
        height: 48,
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            hintText: 'Search Your Notes',
            hintStyle: AppStyles.normal
                .copyWith(color: Color.fromRGBO(217, 217, 217, 1)),
            prefixIcon: Icon(
              Icons.search,
              color: Color.fromRGBO(51, 51, 51, 1),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(51, 51, 51, 1), width: 1.0)),
          ),
        ),
      );
    }

    void newNote() {
      context.read<EditProvider>().setMode(false);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => EditNotePage(index: -1)));
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        title: Text('Notes', style: AppStyles.title),
        centerTitle: true,
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 20, right: 10),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          elevation: 2,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: newNote,
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 10,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: double.maxFinite,
          child: Text('${context.watch<NoteProvider>().notes.length} notes',
              style: AppStyles.normal),
        ),
      ),
      body: Container(
        //padding: EdgeInsets.only(bottom: 50),
        width: double.maxFinite,
        child: Column(
          children: [
            buildSearch(),
            Expanded(
              child: ListView.builder(
                  itemCount: context.watch<NoteProvider>().notes.length,
                  itemBuilder: (context, index) => //_tile(index),
                      NoteItem(index: index)),
            ),
            //ListView.builder(itemBuilder: )
          ],
        ),
      ),
    );
  }
}
