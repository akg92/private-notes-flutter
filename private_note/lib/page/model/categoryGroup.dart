// class for the category
// currently it is hardcoded.
// Private, Public, Hidden

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryGroup {
  String _code;
  bool _isPrivate;
  Color _color;
  String _name;
  FaIcon _icon;
  static Color _iconColor = Colors.grey[900];

  static Color get iconColor => _iconColor;

  FaIcon get icon => _icon;

  String get name => _name;

  String get code => _code;

  CategoryGroup(this._code, this._name, {bool isPrivate, Color color, FaIcon icon}) {
    _isPrivate = isPrivate;
    _color = color;
    _icon = icon;
  }
  bool get isPrivate => _isPrivate;

  Color get color => _color;

  bool operator == (op) {
    if( op is CategoryGroup){
      return code == op.code;
    }
    else if(op is DropdownMenuItem<CategoryGroup>){
      return op.value.code == code;
    }
  }
}

// private
class PrivateGroup extends CategoryGroup {
  PrivateGroup()
      : super("prv", "Private", isPrivate: false, color: Colors.deepOrange[400],
    icon: FaIcon(FontAwesomeIcons.eyeSlash, color: CategoryGroup.iconColor)) {}
}

// hidden
class HiddenGroup extends CategoryGroup {
  HiddenGroup() : super("hid", "Hidden", isPrivate: true, color: Colors.red[700],
      icon: FaIcon(FontAwesomeIcons.lowVision, color: CategoryGroup.iconColor )) {}
}

// public
class PublicGroup extends CategoryGroup {
  PublicGroup() : super("pub", "Public",isPrivate: false, color: Colors.green[400],
      icon: FaIcon(FontAwesomeIcons.eye, color: CategoryGroup.iconColor)) {}
}

