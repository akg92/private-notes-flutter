import 'package:private_note/page/model/categorymodel.dart';

class NoteCategory {

   int _id ;
   Category _category ;

   int get id => _id;

   Category get category => _category;

   NoteCategory.fromIdCategory(int id,  Category category){
     _id = id;
     _category = category;
   }

}