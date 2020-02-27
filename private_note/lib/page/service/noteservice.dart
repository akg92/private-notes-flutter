import 'package:private_note/page/config/configdb.dart';
import 'package:private_note/page/model/notemodel.dart';
import 'package:private_note/page/service/dbservice.dart';
import 'package:private_note/page/service/notecategoryservice.dart';

class NoteService {

  DBService _dbService;
  static String _tableName = ConfigDB.noteTable;

  // create db service
  NoteService(){
    _dbService = _dbService;
  }

  // create note
  Future<int> insert(Note note) async{
    int result = await _dbService.insert(_tableName, note.toMap());
    NoteCategoryService noteCat  =  NoteCategoryService();

    List<Future<int>>  futures = [];

    note.category.forEach( (category){
      futures.add(noteCat.create(note, category.category));
    });

    for( Future<int> ft in futures){
      await ft;
    }
    return result;
  }

  // update note
  Future<int> update(Note note) async{
    int result  = await _dbService.insert(_tableName, note.toMap() );
  }

  // load all
  Future<List<Note>> getAll() async{

    List<Map<String, dynamic>> listOfComments = await _dbService.query(_tableName);
    List<Note> notes = [];
    NoteCategoryService noteService = NoteCategoryService();
    // create objects
    for(var map in listOfComments){
      Note note = Note.fromMap(map);
      note.category = await noteService.queryNoteCategroy(note);
      notes.add(note);
    }

    return notes;
  }



}