import 'package:flutter/foundation.dart';
import 'package:private_note/page/model/categorymodel.dart' as custom;
import 'package:private_note/page/model/file.dart';
import 'package:private_note/page/model/notecategorymodel.dart';

class Note {

  String _title;
  String _text;
  List<FileModel> _files; // list of files. currently only plan to use one file.
  DateTime _deleteTime; // when to delete the note
  DateTime _createdTime; // created time
  DateTime _modifiedTime; // delete time
  List<NoteCategory> category;
  int _id ;

  Note(){
    _files = [];
  }

  int get id => _id;

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  List<FileModel> get files => _files;
  FileModel get file {
    if(!_files.isEmpty){
      return _files[0];
    }
    return null;
  }
  set files(List<FileModel> value) {
    _files = value;
  }

  DateTime get deleteTime => _deleteTime;

  set deleteTime(DateTime value) {
    _deleteTime = value;
  }

  DateTime get createdTime => _createdTime;

  set createdTime(DateTime value) {
    _createdTime = value;
  }

  DateTime get modifiedTime => _modifiedTime;

  set modifiedTime(DateTime value) {
    _modifiedTime = value;
  }


  void addFile(FileModel file){
    _files.add(file);
  }
  // to map
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {};

    if(_id != null){
      map["id"] = _id;
    }

    if(createdTime != null){
      map['created_time'] = createdTime;
    }

    map['modified_time'] = DateTime.now().toUtc();
    map['delete_time'] = _deleteTime;
    map['title'] = _title;
    map['_text']  = _text;
  }
  // get map
  Note.fromMap(Map<String, dynamic> map){

    _id = map['_id'];
    _createdTime = map['created_time'];
    _modifiedTime = map['modified_time'];
    _deleteTime = map['delete_time'];
    _title = map['title'];
    _text = map['text'];
    _modifiedTime = map['modified_time'];
  }

}