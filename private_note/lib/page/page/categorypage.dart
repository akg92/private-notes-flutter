import 'package:flutter/material.dart';
import 'package:private_note/page/config/configstyle.dart';
import 'package:private_note/page/model/categorymodel.dart';
import 'package:private_note/page/page/navigationbar.dart';
import 'package:private_note/page/page/titlebar.dart';
import 'package:private_note/page/service/categoryservice.dart';
import 'package:private_note/page/util/ActionPrivateNote.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryPage();
  }

}

class _CategoryPage extends State<CategoryPage> {

  List<Category> _categories = [];

  void _createNote(context) {

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // assign state
    _updateList();
  }

  void _updateList() {
    CategoryService().getAll().then((categories){
    setState( () => _categories = categories);
    });
  }
  void _detailNavigation(BuildContext context, Category category){
    Navigator.pushNamed(context, '/categorydetail', arguments: category);
  }
  // delete category service.
  void _delete(category){
    CategoryService service = new CategoryService();
    service.delete(category);
    setState(() {
      _categories.remove(category);
    });
  }
  // add navigation
  void _addNavigation(){
    Navigator.pushNamed(context, '/categorycreate');
  }
  // navigate to edit page. reload list after edit
  void _editNavigation(BuildContext context, Category category) async{
    await Navigator.pushNamed(context, '/categoryedit', arguments: category);
    _updateList();
  }
  Widget _getFloatingAction(){
    return FloatingActionButton.extended(
      heroTag: "Create",
      label: Text("Create",
      style:  StyleConfig.iconFontStyle),
      backgroundColor: StyleConfig.floatingButtonBgColor,
      icon: Icon(HelperPrivateNotes.getIconForAction(
          ActionPrivateNote.CREATE)),
      onPressed: () => _addNavigation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _updateList();
    return Scaffold(
      backgroundColor: StyleConfig.appBgColor,
      appBar: TitleBar.build(),
      body: Container(
          padding: EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemBuilder: (context, index) {
              final Category category = _categories[index];
              return Card(
                borderOnForeground: true,
                elevation: 4,
                color: StyleConfig.tileBgColor,
//                semanticContainer: true,
                child : ListTile(
                  leading: Container(
                      child: IconButton(
                        icon: category.group.icon,
                        color: Colors.lightBlueAccent[100],
                      )
                  ),
                  onTap: () => _detailNavigation(context, category),
                title: Text(category.title,
                  style: StyleConfig.commonFontStyle
                ),
                subtitle: Text(category.description, maxLines: 1,
                  style: StyleConfig.hintFontStyle),
                trailing: PopupMenuButton(
//                      padding: EdgeInsets.all(50.0),
                      child: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: ActionPrivateNote.DELETE,
                          child: ListTile(
                              leading: Icon(HelperPrivateNotes.getIconForAction(ActionPrivateNote.DELETE)),
                              title: Text("Delete",
                            style: StyleConfig.commonFontStyle,
                          )),
                        ),
                        PopupMenuItem(
                          value: ActionPrivateNote.EDIT,
                          child: ListTile(
                              leading: Icon(HelperPrivateNotes.getIconForAction(ActionPrivateNote.EDIT)),
                              title: Text("Edit",
                                style: StyleConfig.commonFontStyle,
                              )),
                        )

                      ],
                  onSelected: (ActionPrivateNote value){
                        // call edit
                        if(value == ActionPrivateNote.EDIT){
                          _editNavigation(context, category);
                        }
                        // delete
                        else if(value == ActionPrivateNote.DELETE){
                          _delete(category);
                        }
                  },
                ),
              ));
            },
            itemCount: _categories.length,

          )
      ),
      bottomNavigationBar: SizedBox(  child: NavigationBar()),
      floatingActionButton: _getFloatingAction()
    );
  }

}