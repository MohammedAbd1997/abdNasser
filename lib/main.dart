import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/db/db_provider.dart';
import 'package:untitled1/provider/contact_provider.dart';
import 'package:untitled1/screens/contact_screen.dart';
import 'package:untitled1/screens/launch_screen.dart';
import 'package:untitled1/screens/main_screen.dart';
import 'package:untitled1/screens/update_contact_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBProvider().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ContactProvider>(
            create: (context) => ContactProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/launch_screen',
        routes: {
          '/launch_screen': (context) => LaunchScreen(),
          '/main_screen': (context) => MainScreen(),
          '/create_contact_screen': (context) => ContactScreen(),
          '/update_contact_screen': (context) => UpdateContactScreen(),
        },
      ),
    );
  }
}
