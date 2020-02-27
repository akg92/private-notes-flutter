import 'package:flutter/material.dart';
import 'package:private_note/page/config/configstyle.dart';
import 'package:private_note/page/page/navigationbar.dart';
import 'package:private_note/page/page/notedetailspage.dart';
import 'package:private_note/page/page/notepage.dart';
import 'package:private_note/page/page/titlebar.dart';

class MainPage extends StatefulWidget{
  @override
  _MainPage createState() => _MainPage();
}
class _MainPage extends State<MainPage>{
  Widget build(context) => Scaffold(
    backgroundColor: StyleConfig.appBgColor,
    appBar:  TitleBar.build(),
    body: Navigator (
      onGenerateRoute: (RouteSettings settings){
        WidgetBuilder builder;
        switch(settings.name){

          case '/note':
            builder = (BuildContext context) => NotePage();
            break;
          case '/notecreate':
            builder = (BuildContext context) => NoteDetailsPage(true);
            break;
          default:
            builder = (BuildContext context) => NotePage();
        }

        return MaterialPageRoute(
          builder: builder,
          settings: settings
        );
      },

    ),
    bottomNavigationBar: NavigationBar()
  );
}