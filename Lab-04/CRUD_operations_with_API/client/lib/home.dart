import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class User {
  final int? id;
  final String name;
  final String email;
  final int age;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      name: json['name'] as String,
      email: json['email'] as String,
      age: json['age'] is int
          ? json['age'] as int
          : int.parse(json['age'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'age': age,
    };
  }
}


class _HomePageState extends State<HomePage> {
  late Future<List<User>> _futureUsers;

  Future<List<User>> fetchUsers() async {
    final String url = "http://localhost:3000/users";
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((item) => User.fromJson(item)).toList();
    }
    else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  void _editUser(User user) {
    Navigator.pushNamed(context, '/edit', arguments: user).then((_) {
      setState(() {
        _futureUsers = fetchUsers();
      });
    });
  }

  Future<void> _deleteUser(int id) async {
    final String url = "http://localhost:3000/users/$id";
    final uri = Uri.parse(url);

    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      setState(() {
        _futureUsers = fetchUsers();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User deleted successfully")),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add').then((_) {
                  setState(() {
                    _futureUsers = fetchUsers();
                  });
                });
              },
              child: const Text("Add Users"),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _futureUsers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No users found"));
                }

                final users = snapshot.data!;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index){
                    final user = users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(user.name.isNotEmpty ? user.name[0].toUpperCase() : '?'),
                        ),
                        title: Text(user.name),
                        subtitle: Text('${user.email} - Age: ${user.age}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              tooltip: 'Edit',
                              onPressed: () => _editUser(user),
                            ),
                            IconButton(
                              onPressed: () => _deleteUser(user.id!), 
                              icon: Icon(Icons.delete),
                              tooltip: 'Delete',
                              ),
                          ],),
                      ),
                    );
                  }
                  );
              },
            ),
          )
        ],
      )
    );
  }
}