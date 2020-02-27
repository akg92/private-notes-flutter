
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_note/page/config/configstyle.dart';
import 'package:private_note/page/model/notemodel.dart';
import 'package:private_note/page/page/titlebar.dart';

class NoteDetailsPage extends StatefulWidget{
  bool _editable;
  Note _note;

  // consturctor
  NoteDetailsPage(this._editable,{Note note}): super(){
    this._note = note == null ? Note() : note;
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoteDetailsPage(_editable, _note);
  }
}

class _NoteDetailsPage extends State<NoteDetailsPage> {
  bool _readonly ;
  Note _note;

  // text pickers
  Map<String,TextEditingController> textController ;

  // constructor
  _NoteDetailsPage(bool editable, this._note):super(){
    print(editable);
    _readonly = !editable;
    textController = {
      'text' : TextEditingController(text: _note.text == null ? 'Description' : _note.text),
      'title' : TextEditingController(text: _note.title == null ? 'Title' : _note.title)
    };
  }

  TextField _getTextField(String name, String hintText){
    return       TextField(
        readOnly: _readonly,
        controller: textController[name],
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: textController[name].text,
            hintText: hintText,
        )
    );
  }
  // Date time picker message
  Future<DateTime> pickDateAndTime(BuildContext context, {DateTime current}) async{
    bool isCurrentNull = current == null;
    if(isCurrentNull){
      current = DateTime.now();
    }
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: isCurrentNull ? current.add(Duration(days: 1)) : current,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add( Duration(days: 365) ));
    final TimeOfDay time = await showTimePicker(context: context,
        initialTime: TimeOfDay(hour: current.hour, minute: current.minute)
    );
    return new DateTime(date.year, date.month, date.day, time.hour, time.minute);

  }
  // get date
  String _getText(DateTime date){
    return date == null ? DateTime.now().toIso8601String() : date.toIso8601String();
  }
  // Date time buttone
  Widget _datePicker(BuildContext context, DateTime date, Function callback ){

      return  FlatButton(
        child: Text(
          _getText(date)
        ),
        onPressed: () =>{
          pickDateAndTime(context, current: date).then(
                  (newDate) => callback(newDate)
          )
        },
      );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TitleBar.build() ,
      backgroundColor: StyleConfig.appBgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _getTextField('title', "Enter Title Here"),
          _getTextField('text', "Enter Description Here"),
          _datePicker(context, _note.deleteTime, (newDate) =>setState( () =>
            _note.deleteTime = newDate
          )
          ),
        ],
      ),
    );

  }
}