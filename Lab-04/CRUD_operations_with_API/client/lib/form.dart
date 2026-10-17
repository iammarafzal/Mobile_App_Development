import 'dart:convert';

import 'package:client/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormPage extends StatefulWidget {
  final User? user;

  const FormPage({super.key, this.user});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool _isEditMode = false;
  bool _isInitialized = false;
  int? _userId;
  String _name = '';
  String _email = '';
  String _age = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInitialized) {
      return;
    }

    final routeUser = widget.user ?? ModalRoute.of(context)?.settings.arguments as User?;
    if (routeUser != null) {
      _isEditMode = true;
      _userId = routeUser.id;
      _name = routeUser.name;
      _email = routeUser.email;
      _age = routeUser.age.toString();
    }

    _isInitialized = true;
  }

  void _clearFields() {
    setState(() {
      _name = '';
      _email = '';
      _age = '';
      _isEditMode = false;
      _userId = null;
    });
  }

  Future<String> _addUser(User user) async {
    final String url = "http://localhost:3000/users";
    final uri = Uri.parse(url);

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return "Added user successfully.";
    }
    return "Failed to add user";
  }

  Future<String> _updateUser(int id, User user) async {
    final String url = "http://localhost:3000/users/$id";
    final uri = Uri.parse(url);

    final response = await http.put(
      uri,
      headers: {
        "Content-Type": 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return "User updated successfully.";
    }
    return "Failed to update user";
  }

  Future<void> _submitForm() async {
    if (!_globalKey.currentState!.validate()) {
      return;
    }

    _globalKey.currentState!.save();

    final user = User(
      id: _userId,
      name: _name,
      email: _email,
      age: int.parse(_age),
    );

    final message = _isEditMode && _userId != null
        ? await _updateUser(_userId!, user)
        : await _addUser(user);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );

    if (message.contains('successfully')) {
      _clearFields();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? "Edit User" : "Add User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: "Your Full Name",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value?.trim() ?? '',
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: "Your Email",
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value.trim())) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) => _email = value?.trim() ?? '',
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _age,
                decoration: const InputDecoration(
                  icon: Icon(Icons.numbers),
                  labelText: "Your Age",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your age';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age <= 0) {
                    return 'Please enter a valid positive number';
                  }
                  return null;
                },
                onSaved: (value) => _age = value?.trim() ?? '',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(_isEditMode ? "Update User" : "Add User"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}