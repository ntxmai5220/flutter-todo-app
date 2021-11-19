import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/cubit/edit_todo_cubit.dart';
import 'package:flutter_todo_app/cubit/todo_cubit.dart';
import 'package:flutter_todo_app/data/todo_data.dart';
import 'package:flutter_todo_app/helper/locator.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:flutter_todo_app/pages/todo_page.dart';
import 'package:flutter_todo_app/values/app_colors.dart';
import 'package:flutter_todo_app/values/app_styles.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoCubit>(context).loadTodo(Data.todos);// => để load data
    return Scaffold(
      appBar: AppBar(
        elevation: 1.2,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        title: Text(
          'Notes',
          style: AppStyles.title,
        ),
        centerTitle: true,
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 100, right: 10),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          elevation: 2,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            newNote(context);
          },
        ),
      ),
      
      body: BlocBuilder<TodoCubit, TodoState>(
        /*
        BlocBuilder -> build UI
        builder trong đó cung cấp param context và state
        state hỗ trợ kiểm tra state để build các UI tương ứng với state mới được cập nhật
        
        còn có :
          builderWhen: (previousState, state){},
        */
        builder: (context, state) {
          if (!(state is TodoLoaded))
            return Center(child: CircularProgressIndicator());
          else {
            final todos = state.todos;
            return Column(
              children: [
                buildSearch(),
                Expanded(
                  child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) => //_tile(index),
                          noteItem(index, todos[index], context)),
                ),
                Material(
                  elevation: 15,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.maxFinite,
                    child: Text(
                      '${todos.length} notes',
                      style: AppStyles.normal,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  buildSearch() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      width: double.maxFinite,
      height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: AppColors.lightGrey)),
      child: TextField(
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.symmetric(vertical: 0),
          hintText: 'Search Your Notes',
          hintStyle: AppStyles.normal.copyWith(color: AppColors.lightGrey),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.darkGrey,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  noteItem(int index, Todo _todo, context) {
    Todo todo = _todo;

    return Container(
      margin: EdgeInsets.fromLTRB(24, 0, 24, 10),
      height: 150,
      decoration: BoxDecoration(
        //color: AppColors.custom[index % 7],
        gradient: gradientBG(index),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(183, 183, 183, 0.15),
            spreadRadius: 4,
            blurRadius: 4,
            offset: Offset(1, 1), // changes position of shadow
          )
        ],
      ),
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () {
          editNote(todo, context);
        },
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${todo.title}',
                style: AppStyles.title.copyWith(fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Expanded(
                  child: Text(
                '${todo.content}',
                style: AppStyles.normal,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
        ),
      ),
    );
  }

  gradientBG(int index) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment(0.75, 0), // 25% of the width, so there are ten blinds.
      colors: <Color>[
        AppColors.custom[index % 7].withOpacity(0.7),
        Colors.white
      ], // red to yellow
      tileMode: TileMode.repeated, // repeats the gradient over the canvas
    );
  }


  /*
  Navigator.push thêm page lên stack các trang
  trang mới chồng lên trang hiện tại và ở đỉnh stack

  Navigator.pop loại bỏ trang hiện tại khỏi stack và trở về trang trước

  Appbar tự hiểu tự có thêm nút back nếu stack có các trang phía dưới trang hiện tại (đang ở đỉnh)

  ...còn các phương thức khác để điều hướng :v
  */
  editNote(Todo todo, context) {
    print(todo.title);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => EditTodoCubit(getIt<TodoCubit>()),
          //child: EditNotePage(todo: todo),
          child: TodoPage(todo: todo),
        ),
      ),
    );
  }

  void newNote(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => EditTodoCubit(getIt<TodoCubit>()),
          //child: EditNotePage(todo: todo),
          child: TodoPage(todo: Todo(), newTodo: true),
        ),
      ),
    );
  }
}
