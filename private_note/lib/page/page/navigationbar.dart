import 'package:flutter/material.dart';
import 'package:private_note/page/config/configstyle.dart';

class NavigationBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NavigationBar();
  }
}

class _NavigationBar extends State<NavigationBar> {
  static int _selectedIndex = 0;

  static _setActive(int index){
    _selectedIndex = index;
  }

  void _pushReplacement(BuildContext context, String path, int index){
    _setActive(index);
    Navigator.pushReplacementNamed(context, path);

  }
//  final Color _bgColor = Colors.blue[400];
//  final Color _textColor = Colors.white;
//  final Color _iconColor = Colors.grey[800];
  @override
  Widget build(context) => BottomNavigationBar(
      iconSize: 10,
      showUnselectedLabels: false,
        showSelectedLabels: false,
        backgroundColor: StyleConfig.optionBarBgColor,
//        onTap: (int index) {
//          setState(() {
//            _selectedIndex = index;
//            print(index);
//          });
//        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              iconSize: 10,
              padding: EdgeInsets.all(0),

              color: _selectedIndex == 0
                  ? StyleConfig.optionIconSelectedColor
                  : StyleConfig.optionIconColor,
              icon: Icon(
                Icons.event_note,
                size: StyleConfig.optionIconSize,
              ),
              onPressed: () => _pushReplacement(context, '/note', 0),
            ),
            title: Text('Note',
                style: TextStyle(color: StyleConfig.optionBarTextColor)),
          ),
          BottomNavigationBarItem(
              icon: IconButton(
                color: _selectedIndex == 1
                    ? StyleConfig.optionIconSelectedColor
                    : StyleConfig.optionIconColor,
                icon: Icon(
                  Icons.group_work,
                  size: StyleConfig.optionIconSize,
                ),
                onPressed: () =>
                    _pushReplacement(context, '/category', 1),
              ),
              title: Text('Category',
                  style: TextStyle(color: StyleConfig.optionBarTextColor))),
          BottomNavigationBarItem(
              icon: IconButton(
                  color: _selectedIndex == 2
                      ? StyleConfig.optionIconSelectedColor
                      : StyleConfig.optionIconColor,
                  icon: Icon(
                    Icons.settings,
                    size: StyleConfig.optionIconSize,
                  )),
              title: Text('Setting',
                  style: TextStyle(color: StyleConfig.optionBarTextColor)))
        ],
      );
}
