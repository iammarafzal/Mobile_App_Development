import 'package:flutter/material.dart';
import 'list_view_widget.dart';
import 'grid_view_widget.dart';

void main() => runApp(const MultiScreenApp());

class MultiScreenApp extends StatelessWidget {
  const MultiScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Multi Screen App",
      initialRoute: "/",
      routes: {
        '/': (context) => const ListViewWidget(),
        '/grid-view': (context) => const GridViewWidget()
      },
    );
  }
}