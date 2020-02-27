import 'package:private_note/page/config/configdb.dart';
import 'package:private_note/page/model/wheremodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {

  // queries to execute initallu
  static List<String> _createQueries = [
    "create table ${ConfigDB.noteTable}( id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(500),"+
      "text TEXT,"+
      "files TEXT,"+
      "delete_time INTEGER,"+
      "created_time INTEGER DEFAULT CURRENT_TIMESTAMP,"+
      "modified_time INTEGER)"
    ,
    "create table ${ConfigDB.categoryTable}( id INTEGER PRIMARY KEY AUTOINCREMENT,"+
      "title VARCHAR(500),"+
        "group_code  CHAR(3),"+
      "description TEXT,"+
      "modified_time INTEGER,"+
      "created_time INTEGER,"+
      "icon TEXT)"
  ];
  static List<String> _delteQueries = [
    "delete table ${ConfigDB.noteTable}",
    "delte table ${ConfigDB.categoryTable}",
  ];
  static bool _shouldDelete = false;

  Database _database = null;
  // return singleton db
  Future<Database> _getDB() async {

    if(_shouldDelete) {
      await deleteDatabase(join(await getDatabasesPath(), ConfigDB.dbName));
    }
    if (_database != null) {
      return _database;
    }

    _database = await openDatabase(

        join(await getDatabasesPath(), ConfigDB.dbName),
        onCreate: (db, version) async{
//            for( var query in DBService._delteQueries){
//              try {
//                await db.execute(query);
//              }
//              catch(e){
//                // do nothing
//                print(e);
//              }
//            }
            DBService._createQueries.forEach(
                    (query) => db.execute(query)
            );
        },
        version: 1
    );
    return _database;
  }

  // create
  Future<int> insert(String table, Map<String, dynamic> data) async {
    Database db = await _getDB();
    return db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);

  }

  // update
  Future<int> update(String table, Map<String, dynamic> data, WhereClause where) async{
    Database db = await _getDB();
    return db.update(table, data, where: where.whereString , whereArgs: where.values );
  }

  // delete
  Future<int> delete(String table, {int id, WhereClause where}) async{
    Database db = await _getDB();
    // if id not nulls
    if(id != null) {
      where = WhereClause.fromId(id);
    }
    return db.delete(table,where: where.whereString, whereArgs: where.values);
  }

  // get
  Future<List<Map<String, dynamic>>> query(String table, {int id, WhereClause where}) async{

    Database db = await  _getDB();
    if(id != null){
     where = WhereClause.fromId(id);
    }

    // if where is null get all
    if( where == null){
      return db.query(table);
    }


    //db operation
    return  db.query(table, where: where.whereString, whereArgs: where.values);

  }



}