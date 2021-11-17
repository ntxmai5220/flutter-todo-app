import 'package:flutter/material.dart';
import 'package:flutter_todo_app/values/app_styles.dart';

class EditNotePage extends StatefulWidget {
  final bool isEdit;
  final int index;
  const EditNotePage({Key? key, this.isEdit = true, required this.index})
      : super(key: key);

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;
  //late FocusNode _focusNode;
  late bool isEditMode;
  bool isEditing = false;
  @override
  void initState() {
    // TODO: implement initState
    _titleController = TextEditingController();
    _noteController = TextEditingController();
    //_focusNode = FocusNode();
    isEditMode = widget.isEdit;
    _noteController.text = widget.isEdit ? 'content ne ${widget.index} ' : '';
    _titleController.text = widget.isEdit ? '${widget.index}' : '';
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(),
      body: buildBody(),
      bottomSheet: buildBottom(),
    );
  }

  buildAppBar() {
    return AppBar(
      elevation: 1.5,
      toolbarHeight: 50,
      backgroundColor: Colors.white,
      // title: Text(
      //   'Notes',
      //   style: AppStyles.title,
      // ),
      // centerTitle: true,
    );
  }

  buildBody() {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 20, 24, 50),
      child: Column(
        children: [
          TextField(
            enabled: isEditing || !isEditMode,
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
              enabled: isEditing || !isEditMode,
              controller: _noteController,
              autofocus: !widget.isEdit,
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
      ),
    );
  }

  buildBottom() {
    return Material(
      elevation: 10,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.maxFinite,
        child: Row(
          children: isEditMode ? buildEditBottom() : [buildSaveBtn(createNode)],
        ),
      ),
    );
  }

  List<Widget> buildEditBottom() {
    return [
      buildDeleteBtn(deleteNote),
      VerticalDivider(
        indent: 10,
        endIndent: 10,
        width: 0,
      ),
      !isEditing
          ? buildEditBtn(editNote)
          : buildSaveBtn(saveNote) // or buildSaveBtn(saveNote)
    ];
  }

  buildDeleteBtn(VoidCallback action) {
    return Expanded(
      child: InkWell(
        onTap: action,
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

  void deleteNote() {}

  buildEditBtn(VoidCallback action) {
    return Expanded(
      child: InkWell(
        onTap: action,
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

  void editNote() {
    setState(() {
      isEditing = true;
    });
  }

  buildSaveBtn(VoidCallback action) {
    return Expanded(
      child: InkWell(
        onTap: action,
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

  void saveNote() {
    setState(() {
      isEditing = false;
    });
  }

  void createNode() {
    setState(() {
      isEditMode = true;
    });
  }
}
