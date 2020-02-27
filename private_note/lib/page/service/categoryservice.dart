import 'package:private_note/page/config/configdb.dart';
import 'package:private_note/page/model/categorymodel.dart';
import 'package:private_note/page/service/dbservice.dart';

class CategoryService{

  DBService _dbService;
  static String _tableName = ConfigDB.categoryTable;
  CategoryService(){
    _dbService = DBService();
  }
  // create
  Future<int> insert(Category category){
    return _dbService.insert(_tableName, category.toMap());
  }

  // delete
  Future<int> delete(Category category){
    return _dbService.delete(_tableName, id: category.id);
  }

  // query
  Future<Category> queryId(int id) async{
    List<Map<String, dynamic>> map = await _dbService.query(_tableName, id: id);

    if(map == null || map.length == 0){
      return null;
    }
    return Category.fromMap(map[0]);
  }
  // get all
  Future<List<Category>> getAll() async{
    List<Map<String, dynamic>> listOfMap = await _dbService.query(_tableName);
    List<Category> categories = [];
    // create a
    for (var map in listOfMap){
      categories.add( Category.fromMap(map));
    }
    // get all categories
    return categories;

  }

}