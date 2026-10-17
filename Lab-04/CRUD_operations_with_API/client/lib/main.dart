import 'package:client/form.dart';
import 'package:client/home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "User Management System",
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/add": (context) => const FormPage(),
        "/edit": (context) => const FormPage(),
      },
    );
  }
}