import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqlite_example/database_helper.dart';
import 'package:sqlite_example/user.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String _name = '';
  String _email = '';



  Future<void> addUser() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

      User user = User(name: _name, email: _email);
      
      final usersCount = await DatabaseHelper.instance.insertUser(user);

      if (!mounted) return;
      
      if (usersCount >= 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User added successfully!'))
        );

        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Page"),
      ),
      body: Form(
        key: _key,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'John Doe',
                labelText: 'Full Name',
              ),
              onSaved: (newValue) => newValue != null ? _name = newValue : null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'Email Address',
                hintText: 'john@gmail.com',
              ),
              onSaved: (newValue) => newValue != null ? _email = newValue : null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: addUser,
              child: Text('Add User'),
            ),

          ],
        ),
      ),
    );
  }
}