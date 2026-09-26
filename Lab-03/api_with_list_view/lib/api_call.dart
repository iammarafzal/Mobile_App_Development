import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCall extends StatelessWidget {
  const ApiCall({super.key});

  Future<List<dynamic>> getData () async {
    final response = await http.get(
      Uri.parse("https://microsoftedge.github.io/Demos/json-dummy-data/64KB.json"),
    );
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Data"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(),);
          }

          final items = snapshot.data!;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]['name']),
                subtitle: Text(items[index]['bio']),
              );
            },
          );
        }),
    );
  }
}