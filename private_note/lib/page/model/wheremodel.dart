// abstraction for single where clause
// not using as of now for reducing the complexity.
//class _Clause {
//  String name;
//  dynamic value;
//  _Clause(this.name, this.value);
//}

// Class to contain where clause
class WhereClause {
  List<dynamic> _values;
  String _where;

  // constructor
  WhereClause(this._where, this._values);

  // add new cluase
//  void addCondition(String name, dynamic value){
//    _cluases.add(
//      _Clause(name, value);
//    );
//  }

  // get where string
  get whereString => this._where;

  // get values
  get values => this._values;

  // constructor from id
  WhereClause.fromId(int id, {String idName = 'id'}){
    _values  = [id];
    _where = "$idName = ?";
  }
}
