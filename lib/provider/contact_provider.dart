import 'package:flutter/material.dart';
import 'package:untitled1/db/db_operation.dart';

import '../models/contact.dart';

class ContactProvider extends ChangeNotifier {

  DBOperation _contactDbController = DBOperation();
  List<Contact> contacts= [];


  Future<void> read() async {
    contacts = await _contactDbController.read();
    notifyListeners();
  }

Future<bool> create(Contact contact) async {
  int newRowId = await _contactDbController.create(contact);
  if(newRowId != 0){
    contact.id = newRowId;
    contacts.add(contact);
    notifyListeners();
  }
  return newRowId != 0;
}

Future<bool> update(Contact contact) async {
  bool updated = await _contactDbController.update(contact);
  if(updated){
     int index = contacts.indexWhere((element) => element.id == contact.id);
    if(index != -1) {
      contacts[index] = contact;
      notifyListeners();
    }
  }
  return updated;
}

  Future<bool> delete(int id) async {
    bool deleted = await _contactDbController.delete(id);
    if(deleted){
       int index = contacts.indexWhere((element) => element.id == id);
      if(index != -1){
        contacts.removeAt(index);
        notifyListeners();
      }
    }
    return deleted;
  }



}
