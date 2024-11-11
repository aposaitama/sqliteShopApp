import 'package:flutter/material.dart';
import 'package:shop/db/database.dart';
import 'package:shop/models/user.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String? userName;
  final DatabaseService _databaseService = DatabaseService.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: _addUserButton(),
      body: userList(),
    );
  }

  Widget _addUserButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('Enter UserName'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            userName = value;
                          });
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: 'login'),
                      ),
                      MaterialButton(
                          color: Theme.of(context).colorScheme.primary,
                          child: const Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (userName == null && userName == '') return;
                            _databaseService.addUser(userName!);
                            setState(() {
                              userName = null;
                            });
                            Navigator.pop(context);
                          })
                    ],
                  ),
                ));
      },
      child: const Icon(Icons.add),
    );
  }

  Widget userList() {
    return FutureBuilder(
        future: _databaseService.getUsers(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              User user = snapshot.data![index];
              return ListTile(
                title: Text(user.name),
              );
            },
          );
        });
  }
}
