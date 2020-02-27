import 'package:flutter/material.dart';
import 'package:private_note/page/config/configstyle.dart';
import 'package:private_note/page/model/notemodel.dart';
import 'package:private_note/page/page/navigationbar.dart';
import 'package:private_note/page/page/titlebar.dart';

class NotePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotePage();
  }

}

class _NotePage extends State<NotePage>{

  List<Note> _notes = [];

  void _createNote(context) {

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: StyleConfig.appBgColor,
        appBar:  TitleBar.build(),
      body : Container(

      child: ListView.builder(
        itemBuilder : (context, index){
          final Note note = _notes[index];
          return ListTile(
            title : Text(note.title),
            subtitle: Text(note.text),
            trailing:  IconButton(
              icon:  Icon(Icons.more_vert),
              onPressed: (){
                return PopupMenuButton(

                );
              },
            ),
          );
        },
        itemCount: _notes.length,

      )
    ),
        bottomNavigationBar: NavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.pushNamed(context, '/notecreate')  ,
        child: Icon(Icons.add),
        backgroundColor: StyleConfig.floatingButtonBgColor,
      ),

    );

  }

}