import 'package:flutter/material.dart';
import 'package:sqlite_example/database_helper.dart';
import 'user.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final userMaps = await DatabaseHelper.instance.queryAllUsers();

    if (!mounted) return;

    setState(() {
      _users = userMaps.map((userMap) => 
      User.fromMap(userMap)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GFG User List'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            SizedBox(width: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_users[index].name),
                    subtitle: Text(_users[index].email)
                  );
                }
              ),
            ),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, '/submit'),
            ),
          ],
        ),
      ),
    );
  }
}