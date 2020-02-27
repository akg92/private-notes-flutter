import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:private_note/page/config/configstyle.dart';
import 'package:private_note/page/model/categoryGroup.dart';
import 'package:private_note/page/model/categorymodel.dart';
import 'package:private_note/page/page/pageComponentHelper.dart';
import 'package:private_note/page/page/titlebar.dart';
import 'package:private_note/page/service/categoryservice.dart';
import 'package:private_note/page/service/catgorygroupservice.dart';
import 'package:private_note/page/util/ActionPrivateNote.dart';

class CategoryDetailsPage extends StatefulWidget {
  bool _editable;
  Category _category;

  // consturctor
  CategoryDetailsPage(this._editable, {Category category}) : super() {
    this._category = category == null ? Category() : category;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryDetailsPage(_editable, _category);
  }
}

class _CategoryDetailsPage extends State<CategoryDetailsPage> {
  // readonly flag for display
  bool _readonly;
  Category _category;
  BuildContext _context;

  // text pickers
  Map<String, TextEditingController> _textController;

  // constructor
  _CategoryDetailsPage(bool editable, this._category) : super() {
    _readonly = !editable;
    _textController = {
      'text': TextEditingController(
          text:  _category.description),
      'title': TextEditingController(
          text: _category.title )
    };
  }

  // get text field
  Padding _getTextField(String name, String hintText, int minLine) {
    return
      Padding(
        padding: EdgeInsets.only( bottom: 20, top: 20),
      child: TextField(
        minLines: minLine,
        maxLines: minLine,
        readOnly: _readonly,
        controller: _textController[name],
        decoration: InputDecoration(
          border: OutlineInputBorder( borderRadius: BorderRadius.circular( 40.0) ),
          labelText: _textController[name].text,
          hintText: hintText,
        ))
      );
  }

  // Date time picker message

  // get body form
  Column _getBody(){
    return Column(
      children: <Widget>[

        ListTile(
          leading: IconButton(
              padding: EdgeInsets.all(0.0),
//              color: Colors.black,
              icon: FaIcon(FontAwesomeIcons.heading, color: Colors.black,)
          ),
          title: PageHelper.getTextField("title", "Title", minLine: 1, textController: _textController, readonly: _readonly)
        ),
        ListTile(
          leading: IconButton(
              color: Colors.black,
              padding: EdgeInsets.all(0.0),
              icon: _category.group.icon
          ),
          title: _dropDown(),
        ),
        ListTile(
          leading: IconButton (
//              color: Colors.black,
              icon: FaIcon(FontAwesomeIcons.penNib, color: Colors.black),
              padding: EdgeInsets.all(0.0),
          ),
          title: PageHelper.getTextField("text", "Description", minLine: 5, textController: _textController, readonly: _readonly)
        ),

      ],
    );
  }
  // fill values
  void fillFromInput() {
    _category.title = _textController['title'].value.text;
    _category.description = _textController['text'].value.text;
  }
  // cancel button action
  void _cancel(){
    Navigator.pop(_context);
  }
  // get the private selection
  Widget _dropDown(){
    return  Container(
        height: 60,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        child: IgnorePointer(
          ignoring: _readonly,
        child: DropdownButton(
          isDense: true,
        isExpanded: true,
        value:  DropdownMenuItem(
            child:  SizedBox (
              width: 100,
                child: Text(_category.group.name,
                    style: StyleConfig.commonFontStyle,
                )),
            value: _category.group),
        items: CategoryGroupService.allCategoryGroup().map(
            (CategoryGroup group){
              return  DropdownMenuItem(
                  child:  ListTile (
                  title: Text(group.name,
                    style: StyleConfig.commonFontStyle
                  )),
                  value: group,
              );
            }
        ).toList(),
         onChanged: ( group) => setState( () => _category.group = group)
    )));
  }
  // save category
  void _saveCategory() {
    fillFromInput();
    CategoryService service = CategoryService();
    service.insert(_category).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;
    return Scaffold(
        appBar: TitleBar.build(),
        backgroundColor: StyleConfig.appBgSecondaryColor,
        floatingActionButton: _readonly
            ? null
            : PageHelper.getFloatingActionButtonCancelSave(_cancel, _saveCategory),
        body: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 30),
            color: Colors.white,
            child: _getBody(),
        )
    );
  }
}
