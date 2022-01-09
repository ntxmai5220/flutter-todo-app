import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/note_model.dart';
import 'package:flutter_todo_app/pages/pages.dart';
import 'package:flutter_todo_app/providers/providers.dart';
import 'package:flutter_todo_app/values/values.dart';

import 'package:provider/provider.dart';

class NoteItem extends StatelessWidget {
  final int index;
  const NoteItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Note note = context.watch<NoteProvider>().notes[index];
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
          //editNote(index);
          context.read<EditProvider>().setMode(true);
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => EditNotePage(index: index)));
        },
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${note.title}',
                style: AppStyles.title.copyWith(fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Expanded(
                  child: Text(
                '${note.content}',
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
}
