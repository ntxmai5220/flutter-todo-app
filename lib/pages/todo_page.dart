import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/cubit/edit_todo_cubit.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:flutter_todo_app/values/app_styles.dart';

class TodoPage extends StatelessWidget {
  Todo todo;
  final bool newTodo;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  TodoPage({Key? key, required this.todo, this.newTodo = false})
      : super(key: key);

  void _updateTodo(Todo updateTodo, context) {
    BlocProvider.of<EditTodoCubit>(context).updateTodo(todo, updateTodo);
  }

  void _newTodo(Todo newTodo, context) {
    BlocProvider.of<EditTodoCubit>(context).saveTodo(newTodo);
  }

  void _showSnackBar(String content, context, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: isError ? Colors.redAccent : Colors.blue,
      duration: Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = todo.title ?? '';
    _contentController.text = todo.content ?? '';
    //BlocProvider.of<EditTodoCubit>(context).editTodo();
    if (this.newTodo) BlocProvider.of<EditTodoCubit>(context).createTodo();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(),
      body: buildBody(context),
      bottomSheet: buildBottom(context),
    );
  }

  buildAppBar() {
    return AppBar(
      elevation: 1.5,
      toolbarHeight: 50,
      backgroundColor: Colors.white,
    );
  }

  buildBody(context) {
    return BlocListener<EditTodoCubit, EditTodoState>(
      listener: (context, state) {
        print(state);
        if (state is DeletedTodo) {
          _showSnackBar('Deleted successfully', context);

          Navigator.pop(context);
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(24, 20, 24, 50),
        child: BlocBuilder<EditTodoCubit, EditTodoState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  enabled: state is EditingTodo || state is CreateTodo,
                  controller: _titleController,
                  maxLines: null,
                  style: AppStyles.detailTitle,
                  // cursorHeight: 30,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: AppStyles.detailTitle
                          .copyWith(color: Color.fromRGBO(217, 217, 217, 1))),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: TextField(
                    enabled: state is EditingTodo || state is CreateTodo,
                    controller: _contentController,
                    //autofocus: state is EditingTodo || state is CreateTodo,
                    maxLines: null,
                    style: AppStyles.normal,
                    // cursorHeight: 30,s
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        hintText: 'Note',
                        hintStyle: AppStyles.normal
                            .copyWith(color: Color.fromRGBO(217, 217, 217, 1))),
                  ),
                ),
                SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }

  buildBottom(context) {
    return Material(
      elevation: 10,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.maxFinite,
        child: BlocBuilder<EditTodoCubit, EditTodoState>(
          builder: (context, state) {
            if (state is CreateTodo)
              return Row(children: [buildSaveBtn(context, createTodo: true)]);
            return Row(
              //children: isEditMode ? buildEditBottom() : [buildSaveBtn(createNode)],
              children: buildEditBottom(context),
            );
          },
        ),
      ),
    );
  }

  List<Widget> buildEditBottom(context) {
    return [
      buildDeleteBtn(context),
      VerticalDivider(
        indent: 10,
        endIndent: 10,
        width: 0,
      ),
      BlocBuilder<EditTodoCubit, EditTodoState>(
        builder: (context, state) {
          if (state is EditingTodo) return buildSaveBtn(context);
          return buildEditBtn(context);
        },
      )
      // !isEditing
      //     ? buildEditBtn(editNote)
      //     : buildSaveBtn(saveNote) // or buildSaveBtn(saveNote)
    ];
  }

  buildDeleteBtn(context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          deleteNote(context);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12.5),
          child: Icon(
            Icons.delete_rounded,
            color: Colors.red,
            size: 25,
          ),
        ),
      ),
    );
  }

  void deleteNote(context) {
    BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
  }

  buildEditBtn(context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          editNote(context);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12.5),
          child: Icon(
            Icons.edit,
            size: 25,
          ),
        ),
      ),
    );
  }

  void editNote(context) {
    // setState(() {
    //   isEditing = true;
    // });
    BlocProvider.of<EditTodoCubit>(context).editTodo();
  }

  buildSaveBtn(context, {createTodo = false}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          saveNote(context, createTodo: createTodo);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12.5),
          child: Icon(
            Icons.done,
            color: Colors.green,
            size: 25,
          ),
        ),
      ),
    );
  }

  void saveNote(context, {createTodo = false}) {
    // setState(() {
    //   isEditing = false;
    // });
    Todo todo =
        Todo(title: _titleController.text, content: _contentController.text);
    print(_titleController.text + '___' + _contentController.text);
    if (createTodo) {
      _newTodo(todo, context);
      // this.newTodo = false;
    } else {
      _updateTodo(todo, context);
    }

    this.todo = todo;
  }
}
