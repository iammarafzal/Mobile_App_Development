import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/user.dart';
import 'package:hive_flutter/adapters.dart';
import 'user_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());

  await Hive.openBox<User>('userBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserManagementScreen(),
    );
  }
}