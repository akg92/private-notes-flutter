
class GetterSetter{
  Function _getter;
  Function _setter;

  Function get getter => _getter;

  GetterSetter(this._getter, this._setter);

  Function get setter => _setter;
}
abstract class Base {
  Map<String, GetterSetter> getterSetterMap();
}