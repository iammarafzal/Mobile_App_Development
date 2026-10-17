import 'package:flutter/material.dart';
import 'package:sqlite_example/database_helper.dart';
import 'package:sqlite_example/first_screen.dart';
import 'package:sqlite_example/form_page.dart';
import 'database_factory_stub.dart'
    if (dart.library.js_interop) 'database_factory_web.dart' as database_factory;
// import 'user.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database_factory.configureDatabaseFactory();
  await DatabaseHelper.instance.db;
  await DatabaseHelper.instance.initializeUsers();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'SQLite Example',
      routes: {
        '/': (context) => const UserList(),
        '/submit':(context) => const FormPage(),
      },
    );
  }
}