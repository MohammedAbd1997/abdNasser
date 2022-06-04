import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/db/db_operation.dart';

import '../constant.dart';
import '../models/contact.dart';
import '../provider/contact_provider.dart';
import '../widgets/app_text_field.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key, this.title = 'Create', this.contact})
      : super(key: key);

  final String title;
  final Contact? contact;

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late TextEditingController _nameTextController;
  late TextEditingController _numberTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController =
        TextEditingController(text: widget.contact?.name ?? '');
    _numberTextController = TextEditingController(text: "" ?? '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextController.dispose();
    _numberTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.title),
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          const SizedBox(height: 25),
          const Text(
            'Enter new contact details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 25),
          AppTextField(
            textEditingController: _nameTextController,
            hint: 'Name',
            prefixIcon: Icons.person,
          ),
          const SizedBox(height: 10),
          AppTextField(
            textEditingController: _numberTextController,
            hint: 'Number',
            prefixIcon: Icons.phone_android,
          ),
          const SizedBox(height: 45),
          ElevatedButton(

            onPressed: () async => await performCreate(),
            child: const Text(
              'SAVE',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
            ),
          )
        ],
      ),
    );
  }

  Future<void> performCreate() async {
    if (checkData()) {
    await  create();
      Navigator.pop(context);
    }
  }

  bool checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _numberTextController.text.isNotEmpty) {
      return true;
    }
    //SNACKBAR
    showSnackBar(
        context: context, message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> create() async {
    bool b = await Provider.of<ContactProvider>(context, listen: false)
        .create(contact);
    if (b) {
      showSnackBar(context: context, message: 'success', error: false);
    } else {
      showSnackBar(context: context, message: 'not success', error: true);
    }
  }

  Contact get contact {
    Contact c = widget.contact != null ? widget.contact! : Contact();
    c.name = _nameTextController.text;
    c.phone = _numberTextController.text;
    return c;
  }

  void clear() {
    _nameTextController.text = '';
    _numberTextController.text = '';
  }
}
