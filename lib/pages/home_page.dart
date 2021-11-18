import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/cubit/edit_todo_cubit.dart';
import 'package:flutter_todo_app/cubit/todo_cubit.dart';
import 'package:flutter_todo_app/data/todo_data.dart';
import 'package:flutter_todo_app/helper/locator.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:flutter_todo_app/pages/edit_note_page.dart';
import 'package:flutter_todo_app/pages/todo_page.dart';
import 'package:flutter_todo_app/values/app_colors.dart';
import 'package:flutter_todo_app/values/app_styles.dart';

class HomePage extends StatelessWidget {
  final List<Todo> list = [];
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoCubit>(context).loadTodo(Data.todos);
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: buildFAB(context),
      bottomNavigationBar: buildBottom(),
      body: buildBody(),
    );
  }

  buildBottom() {
    return Material(
      elevation: 10,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.maxFinite,
        child: Text(
          '${list.length} notes',
          style: AppStyles.normal,
        ),
      ),
    );
  }

  buildFAB(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, right: 10),
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
    );
  }

  buildAppBar() {
    return AppBar(
      elevation: 1.5,
      toolbarHeight: 50,
      backgroundColor: Colors.white,
      title: Text(
        'Notes',
        style: AppStyles.title,
      ),
      centerTitle: true,
    );
  }

  buildBody() {
    return Container(
      //padding: EdgeInsets.only(bottom: 50),
      width: double.maxFinite,
      child: Column(
        children: [
          buildSearch(),
          buildListNote(),
          //ListView.builder(itemBuilder: )
        ],
      ),
    );
  }

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
              borderSide:
                  BorderSide(color: Color.fromRGBO(51, 51, 51, 1), width: 1.0)),
        ),
      ),
    );
  }

  buildListNote() {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        if (!(state is TodoLoad))
          return Center(child: CircularProgressIndicator());

        final todos = state.todos;

        return Expanded(
          child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) => //_tile(index),
                  noteItem(index, todos[index], context)),
        );
      },
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
      end: Alignment(0.75, 0), // 10% of the width, so there are ten blinds.
      colors: <Color>[
        AppColors.custom[index % 7].withOpacity(0.7),
        Colors.white
      ], // red to yellow
      tileMode: TileMode.repeated, // repeats the gradient over the canvas
    );
  }

  editNote(Todo todo, context) {
    print(todo.title);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => EditTodoCubit(Data.todos, getIt<TodoCubit>()),
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
          create: (context) => EditTodoCubit(Data.todos, getIt<TodoCubit>()),
          //child: EditNotePage(todo: todo),
          child: TodoPage(todo: Todo(), createTodo: true),
        ),
      ),
    );
  }
}
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Todo> list = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     //list = genData();
//     //Data.genData();
//     Data.todos.add(Todo(title: 'new todo', content: 'new content'));
//     list = Data.todos;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(),
//       floatingActionButton: buildFAB(newNote),
//       bottomNavigationBar: buildBottom(),
//       body: buildBody(),
//     );
//   }

//   buildBottom() {
//     return Material(
//       elevation: 10,
//       child: Container(
//         alignment: Alignment.center,
//         height: 50,
//         width: double.maxFinite,
//         child: Text(
//           '${list.length} notes',
//           style: AppStyles.normal,
//         ),
//       ),
//     );
//   }

//   buildFAB(VoidCallback action) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20, right: 10),
//       child: FloatingActionButton(
//         backgroundColor: Colors.black,
//         elevation: 2,
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//         onPressed: action,
//       ),
//     );
//   }

//   buildAppBar() {
//     return AppBar(
//       elevation: 1.5,
//       toolbarHeight: 50,
//       backgroundColor: Colors.white,
//       title: Text(
//         'Notes',
//         style: AppStyles.title,
//       ),
//       centerTitle: true,
//     );
//   }

//   buildBody() {
//     return Container(
//       //padding: EdgeInsets.only(bottom: 50),
//       width: double.maxFinite,
//       child: Column(
//         children: [
//           buildSearch(),
//           buildListNote(),
//           //ListView.builder(itemBuilder: )
//         ],
//       ),
//     );
//   }

//   buildSearch() {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
//       width: double.maxFinite,
//       height: 48,
//       child: TextField(
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 0),
//           hintText: 'Search Your Notes',
//           hintStyle: AppStyles.normal
//               .copyWith(color: Color.fromRGBO(217, 217, 217, 1)),
//           prefixIcon: Icon(
//             Icons.search,
//             color: Color.fromRGBO(51, 51, 51, 1),
//           ),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(5)),
//               borderSide:
//                   BorderSide(color: Color.fromRGBO(51, 51, 51, 1), width: 1.0)),
//         ),
//       ),
//     );
//   }

//   buildListNote() {
//     return Expanded(
//       child: ListView.builder(
//           itemCount: list.length,
//           itemBuilder: (context, index) => //_tile(index),
//               noteItem(index)),
//     );
//   }

//   noteItem(int index) {
//     Todo todo = list[index];

//     return Container(
//       margin: EdgeInsets.fromLTRB(24, 0, 24, 10),
//       height: 150,
//       decoration: BoxDecoration(
//         //color: AppColors.custom[index % 7],
//         gradient: gradientBG(index),
//         borderRadius: BorderRadius.all(Radius.circular(5)),
//         boxShadow: [
//           BoxShadow(
//             color: Color.fromRGBO(183, 183, 183, 0.15),
//             spreadRadius: 4,
//             blurRadius: 4,
//             offset: Offset(1, 1), // changes position of shadow
//           )
//         ],
//       ),
//       child: InkWell(
//         splashColor: Colors.black54,
//         onTap: () {
//           editNote(index);
//         },
//         borderRadius: BorderRadius.all(Radius.circular(5)),
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 30, vertical: 19),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '${todo.title}',
//                 style: AppStyles.title.copyWith(fontWeight: FontWeight.w700),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               SizedBox(height: 8),
//               Expanded(
//                   child: Text(
//                 '${todo.content}',
//                 style: AppStyles.normal,
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//               )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   gradientBG(int index) {
//     return LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment(0.75, 0), // 10% of the width, so there are ten blinds.
//       colors: <Color>[
//         AppColors.custom[index % 7].withOpacity(0.7),
//         Colors.white
//       ], // red to yellow
//       tileMode: TileMode.repeated, // repeats the gradient over the canvas
//     );
//   }

//   editNote(int index) {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (_) => EditNotePage(index: index)));
//   }

//   void newNote() {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (_) => EditNotePage(isEdit: false, index: -1)));
//   }
// }
