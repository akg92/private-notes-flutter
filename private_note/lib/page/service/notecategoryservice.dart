import 'package:private_note/page/config/configdb.dart';
import 'package:private_note/page/model/categorymodel.dart';
import 'package:private_note/page/model/notecategorymodel.dart';
import 'package:private_note/page/model/notemodel.dart';
import 'package:private_note/page/model/wheremodel.dart';
import 'package:private_note/page/service/categoryservice.dart';
import 'package:private_note/page/service/dbservice.dart';

class NoteCategoryService{

  DBService _dbService;
  static String _tableName = ConfigDB.noteCategoryTable;

  // constructor
  NoteCategoryService() {
    this._dbService = new DBService();
  }
  // create
  Future<int> create(Note note, Category category){

    Map<String, dynamic> map = {
        'note_id' : note.id,
        'category_id': category.id
    };
    return _dbService.insert(_tableName, map );
  }
  // delete
  Future<int> delete(int id) async{
    return _dbService.delete(_tableName, id:id);
  }

  // get
  Future<List<NoteCategory>> queryNoteCategroy(Note note) async{

    WhereClause where = new WhereClause("category_id=?", [note.id]);
    List<Map<String, dynamic>> categoriyIds = await _dbService.query(_tableName, where:  where);

    List<NoteCategory> noteCats = [];
    CategoryService categoryService = CategoryService();

    // loop and fill categories.
    for(var map in categoriyIds){
      int id = map['id'];
      int categoryId = map['category_id'];
      Category category = await categoryService.queryId(categoryId);
      noteCats.add( new NoteCategory.fromIdCategory(id, category));
    }

    return noteCats;
  }



}