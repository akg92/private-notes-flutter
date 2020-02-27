import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ActionPrivateNote{
  CREATE,
  DELETE,
  UPDATE,
  VIEW,
  SAVE,
  EDIT,
  CANCEL,
}

class HelperPrivateNotes {
  static IconData getIconForAction(ActionPrivateNote action){

    switch(action){
      case  ActionPrivateNote.CREATE:
        return Icons.create;
      case ActionPrivateNote.DELETE:
        return Icons.delete;
      case ActionPrivateNote.UPDATE:
        return Icons.update;
      case ActionPrivateNote.VIEW:
        return Icons.view_agenda;
      case ActionPrivateNote.SAVE:
        return Icons.save;
      case ActionPrivateNote.EDIT:
        return Icons.edit;
      case ActionPrivateNote.CANCEL:
        return Icons.cancel;
    }
  }


}