import 'package:flutter/cupertino.dart';
import 'package:private_note/page/model/file.dart';
// Store the icons info
class IconModel {
  FileModel _file;
  Color _color;
  // type of icon. either IMAGE or Color.
  // Only supported image for now.
  IconType _type;

  FileModel get file => _file;

  Color get color => _color;

  IconType get type => _type;


}
enum IconType{
   IMAGE,
   COLOR,
}