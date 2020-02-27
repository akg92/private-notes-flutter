import 'package:flutter/material.dart';
import 'package:private_note/page/config/configstyle.dart';
import 'package:private_note/page/util/ActionPrivateNote.dart';

class PageHelper{


  // new text field with styling change
  static Widget getTextField(String name, String hintText, {int minLine, Map<String, TextEditingController>
    textController, bool readonly}) {
    return
      TextField(

          minLines: minLine,
          maxLines: minLine,
          readOnly: readonly,
          controller: textController[name],
          decoration: InputDecoration(
            labelText: hintText,

          ));
  }


  static Future<DateTime> pickDateAndTime(BuildContext context,
      {DateTime current}) async {
    bool isCurrentNull = current == null;
    if (isCurrentNull) {
      current = DateTime.now();
    }
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: isCurrentNull ? current.add(Duration(days: 1)) : current,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    final TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: current.hour, minute: current.minute));
    return new DateTime(
        date.year, date.month, date.day, time.hour, time.minute);
  }

  // get date
  static String _getText(DateTime date) {
    return date == null
        ? DateTime.now().toIso8601String()
        : date.toIso8601String();
  }

  // Date time buttone
  static Widget _datePicker(BuildContext context, DateTime date, Function callback) {
    return FlatButton(
      child: Text(_getText(date)),
      onPressed: () => {
        pickDateAndTime(context, current: date)
            .then((newDate) => callback(newDate))
      },
    );
  }

  // Get floating button aligned to right
  static Container getFloatingActionButtonCancelSave( Function cancel, Function save){

    return Container(

        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[

              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: FloatingActionButton.extended(
                    label: Text("Cancel"),
                    heroTag: "cancel",
                    backgroundColor: StyleConfig.floatingButtonBgColor,
                    icon: Icon(HelperPrivateNotes.getIconForAction(
                        ActionPrivateNote.CANCEL)),
                    onPressed:  () => cancel(),
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: FloatingActionButton.extended(
                    heroTag: "save",
                    label: Text("Save"),
                    backgroundColor: StyleConfig.floatingButtonBgColor,
                    icon: Icon(HelperPrivateNotes.getIconForAction(
                        ActionPrivateNote.SAVE)),
                    onPressed: save,
                  ))]
        )
    );
  }
}