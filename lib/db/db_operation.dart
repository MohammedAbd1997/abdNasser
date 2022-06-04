import 'package:sqflite/sqflite.dart';
import 'package:untitled1/db/db_abstract_operation.dart';
import 'package:untitled1/db/db_provider.dart';
import 'package:untitled1/models/contact.dart';

class DBOperation implements DBAOperation<Contact> {
  late Database db ;
  // = DBProvider().database;

  DBOperation(){
    db = DBProvider().database;
  }

  @override
  Future<int> create(Contact object) async {
    return await db.insert(DBProvider.TABLE_NAME, object.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    int rowNum = await db
        .delete(DBProvider.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    return rowNum > 0;
  }

  @override
  Future<List<Contact>> read() async {
    List<Map<String, dynamic>> list = await db.query(DBProvider.TABLE_NAME);
    return list.map((e) => Contact.fromMap(e)).toList();
  }

  @override
  Future<Contact?> show(int id) async {
    List<Map<String, dynamic>> rows =
        await db.query(DBProvider.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    return rows.isNotEmpty ? Contact.fromMap(rows.first) : null;
  }

  @override
  Future<bool> update(Contact object) async {
    int rowNum = await db.update(DBProvider.TABLE_NAME, object.toMap(),
        where: 'id = ?', whereArgs: [object.id]);
    return rowNum > 0;
  }

// Future<int> create(Contact object) async {
//   return await db.insert(DBProvider.TABLE_NAME, object.toMap());
// }
//
// Future<List<Contact>> read() async {
//   List<Map<String, dynamic>> list = await db.query(DBProvider.TABLE_NAME);
//   return list.map((e) => Contact.fromMap(e)).toList();
// }
//
// Future<bool> delete(int id) async {
//   int rowNum = await db
//       .delete(DBProvider.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
//   return rowNum > 0;
// }
//
// Future<bool> update(Contact object) async {
//   int rowNum = await db.update(DBProvider.TABLE_NAME, object.toMap(),
//       where: 'id = ?', whereArgs: [object.id]);
//   return rowNum > 0;
// }
}
