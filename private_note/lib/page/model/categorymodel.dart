import 'package:private_note/page/model/categoryGroup.dart';
import 'package:private_note/page/model/iconmodel.dart';
import 'package:private_note/page/service/catgorygroupservice.dart';

class Category {
  int _id;
  String _title;
  String _description;
  IconModel _iconModel;
  DateTime _created_time;
  DateTime _modified_time;

  CategoryGroup _group;

  CategoryGroup get group => _group == null ? CategoryGroupService.getDefault() :_group;

  set group(CategoryGroup value) {
    _group = value;
  }

  set title(String value) {
    _title = value;
  }

  int get id => _id;

  String get title => _title;

  String get description => _description;

  IconModel get iconModel => _iconModel;

  DateTime get created_time => _created_time;

  DateTime get modified_time => _modified_time;

  Category();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    if (id != null) {
      map['id'] = _id;
    }

    if (_created_time != null) {
      map['created_time'] = _created_time.millisecondsSinceEpoch;
    }

    map['modified_time'] = DateTime.now().millisecondsSinceEpoch;
    map['title'] = _title;
    map['description'] = _description;
    map['group_code'] = group.code;

    return map;
  }
   DateTime _convertTime(dynamic datetime){
      if (datetime is DateTime){
        return datetime;
      }
      else if(datetime is int){
        return DateTime.fromMicrosecondsSinceEpoch(datetime, isUtc: true);
      }
      return null;
   }
  // from map loaded
  Category.fromMap(Map<String, dynamic> map){
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    _modified_time = _convertTime(map['modified_time']) ;
    _created_time = _convertTime(map['created_time']);
    _group = CategoryGroupService.fromCode( map['group_code'] as String);
  }

  set description(String value) {
    _description = value;
  }

  set iconModel(IconModel value) {
    _iconModel = value;
  }

}
