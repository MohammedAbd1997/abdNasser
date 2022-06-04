import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final String TABLE_NAME = "contacts";
  late Database _database;
  static final DBProvider _instance =  DBProvider._initDatabase();
  DBProvider._initDatabase();

  factory DBProvider(){
    return _instance;
  }

  get database =>_database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, "app_db.sql");
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE $TABLE_NAME ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT NOT NULL,'
            'phone TEXT NOT NULL'
            ')');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {},
      onDowngrade: (db, oldVersion, newVersion) {},
    );
  }
}