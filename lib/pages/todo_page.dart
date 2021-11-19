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


  /*
  Như đã nói thì BlocProvider.of<...>(context).method
  giúp truy cập các method đã định nghĩa để sử dụng...

  */
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
      appBar: AppBar(
        elevation: 1.5,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
      ),
      bottomSheet: buildBottom(context),
      body: BlocListener<EditTodoCubit, EditTodoState>(
        /*
        BlocListener ~ lắng nghe các thay đổi trạng thái để có hành động cần thiết (như thông báo hay điều hướng ...)
        vd: như ở đây khi xóa xong mình có có trạng thái DeletedTodo 
        ->lúc này cần có thông báo và quay về trang home

        còn có :
        listenWhen: (previousState, state){},
        */
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
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                          hintText: 'Note',
                          hintStyle: AppStyles.normal.copyWith(
                              color: Color.fromRGBO(217, 217, 217, 1))),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  buildBottom(BuildContext context) {
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
            else {
              return Row(
                children: [
                  buildDeleteBtn(context),
                  VerticalDivider(indent: 10, endIndent: 10, width: 0),
                  state is EditingTodo
                      ? buildSaveBtn(context)
                      : buildEditBtn(context)
                ],
              );
            }
          },
        ),
      ),
    );
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
    if (createTodo) {
      _newTodo(todo, context);
    } else {
      _updateTodo(todo, context);
    }

    this.todo = todo;
  }
}
