import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/note_model.dart';
import 'package:flutter_todo_app/providers/note_provider.dart';
import 'package:flutter_todo_app/providers/providers.dart';
import 'package:flutter_todo_app/values/app_styles.dart';
import 'package:provider/provider.dart';

class EditNotePage extends StatelessWidget {
  final int index;
  const EditNotePage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isEditing() => !context.watch<EditProvider>().isView;
    bool isUpdate() => context.watch<EditProvider>().isUpdate;
    Note note;
    if (index != -1) {
      note = context.watch<NoteProvider>().notes[index];
    } else {
      if (isUpdate()) {
        int len = context.watch<NoteProvider>().notes.length - 1;
        note = context.watch<NoteProvider>().notes[len];
      } else {
        note = Note(title: '', content: '');
      }
    }
    TextEditingController _titleController =
        TextEditingController(text: note.title);
    TextEditingController _noteController =
        TextEditingController(text: note.content);

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

    void deleteNote() {
      context.read<NoteProvider>().remove(this.index);
      Navigator.pop(context);
    }

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
      debugPrint('edit');
      context.read<EditProvider>().toggleState();
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
      debugPrint('save');
      int id = index == -1
          ? context.watch<NoteProvider>().notes.length - 1
          : this.index;
      context.read<NoteProvider>().update(id,
          Note(title: _titleController.text, content: _noteController.text));
      context.read<EditProvider>().toggleState();
    }

    void createNote() {
      debugPrint('create');
      context.read<NoteProvider>().add(
          Note(title: _titleController.text, content: _noteController.text));
      context.read<EditProvider>().toggleState();
      context.read<EditProvider>().setMode(true);
    }

    List<Widget> buildEditBottom() {
      return [
        buildDeleteBtn(deleteNote),
        VerticalDivider(
          indent: 10,
          endIndent: 10,
          width: 0,
        ),
        context.watch<EditProvider>().isView
            ? buildEditBtn(editNote)
            : buildSaveBtn(saveNote) // or buildSaveBtn(saveNote)
      ];
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 1.5,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(24, 20, 24, 50),
        child: Column(
          children: [
            TextField(
              enabled: isEditing() || !isUpdate(),
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
                enabled: isEditing() || !isUpdate(),
                controller: _noteController,
                // autofocus: !widget.isEdit,
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
      ),
      bottomSheet: Material(
        elevation: 10,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: double.maxFinite,
          child: Row(
            children:
                isUpdate() ? buildEditBottom() : [buildSaveBtn(createNote)],
          ),
        ),
      ),
    );
  }
}
