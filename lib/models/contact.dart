class Contact {
  late String name;
  late int id;
  late String phone;

  Contact();

  Contact.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['id'];
    name = rowMap['name'];
    phone = rowMap['phone'];
  }


  Map<String,dynamic> toMap() {
    return {"name": name, "phone": phone};
  }
}
