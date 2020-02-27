class ConfigDB {
  static String _dbName = "private_notes_db";
  static String _noteTable = 'notes';
  static String _categoryTable = 'category';
  static String _noteCategoryTable = 'category-note';


  static String get noteCategoryTable => _noteCategoryTable;

  static String get dbName => _dbName;

  static String get noteTable => _noteTable;

  static String get categoryTable => _categoryTable;


}