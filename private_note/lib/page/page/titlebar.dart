import 'package:flutter/material.dart';
import 'package:private_note/page/config/configstyle.dart';

class TitleBar {
  String _title;
  TitleBar({String title}){
    _title = title == null? title : StyleConfig.appName;
  }
  static AppBar build() => AppBar(
//    centerTitle: ,
    leading: Icon( StyleConfig.titleIcon, color: StyleConfig.titleIconColor,
      size: StyleConfig.titleIConSize,
    ),
    title:  Text(
      StyleConfig.appName,
      style:  StyleConfig.headingStyle,
    ),
    backgroundColor: StyleConfig.titleBarBgColor,
  );
}