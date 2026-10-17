import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const ApiExample(),
    );
  }
}

class ApiExample extends StatefulWidget {
  const ApiExample({super.key});

  @override
  State<ApiExample> createState() => _ApiExampleState();
}

class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;

  const User(this.id, this.firstname, this.lastname, this.email);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['name'].split(' ').first,
      json['name'].split(' ').skip(1).join(' '),
      json['email'],
    );
  }
}
class _ApiExampleState extends State<ApiExample> {
  late Future<User> _futureUser;

  Future<User> fetchUser() async {
    final String uri =
        "https://jsonplaceholder.typicode.com/users/1";

    final url = Uri.parse(uri);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
          "Failed to load user: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Failed to load user: $e");
    }
  }
  @override
  void initState() {
    super.initState();
    _futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Calling Project"),
      ),
      body: Center(
        child: FutureBuilder(
          future: _futureUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              final user = snapshot.data!;

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text("ID: ${user.id}"),
                  Text(
                    "Full Name: ${user.firstname} ${user.lastname}",
                  ),
                  Text("Email: ${user.email}"),
                ],
              );
            }

            return const Text("No user found");
          },
        ),
      ),
    );
  }
}