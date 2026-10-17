import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'user.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagementScreen> {
  // Access the already opened box
  final Box<User> _userBox = Hive.box<User>('userBox');

  void _showAddUserDialog() {
    final nameController = TextEditingController();
    final ageController = TextEditingController();

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text('Add New User'),
          content: Column(
            mainAxisSize: .min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Name',
                  hintText: 'Enter Your Name',
                ),
              ),
              SizedBox(width: 20),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  hintText: 'Enter user age',
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel')
            ),
            ElevatedButton(
              onPressed: () {
                final String name = nameController.text.trim();
                final int? age = int.tryParse(ageController.text.trim());

                if (name.isNotEmpty && age != null) {
                  _addUser(name, age);
                  Navigator.pop(context);
                }
              }, 
              child: const Text('Add')
            )
          ],
        );

      },

    );
  }

  void _addUser(String name, int age) {
    User newUser = User(name: name, age: age);
    _userBox.add(newUser);
  }

  void _updateUser(int index, User user) {
    user.name = "${user.name} (Updated)";
    user.save();
  }

  void _deleteUser(int index) {
    _userBox.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Example'),
        actions: [
          IconButton(
            onPressed: _showAddUserDialog, 
            icon: Icon(Icons.person_add)
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _userBox.listenable(), 
        builder: (context, Box<User> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No users stored yet. Tap "+" or the top button to add.'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final user = box.getAt(index);

              return ListTile(
                title: Text(user?.name ?? ''),
                subtitle: Text('Age: ${user?.age}'),
                trailing: Row(
                  mainAxisSize: .min,
                  children: [
                    IconButton(
                      onPressed: () => _updateUser(index, user!),
                      icon: Icon(Icons.edit)
                    ),
                    IconButton(
                      onPressed: () => _deleteUser(index), 
                      icon: Icon(Icons.delete)
                    )
                  ],
                ),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddUserDialog,
        icon: Icon(Icons.add),
        label: Text('Add User'),
        ),
    );
  }
}