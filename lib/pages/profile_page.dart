import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/db/database.dart';
import 'package:shop/models/user.dart';
import 'package:shop/provider/user_provider.dart';
import 'package:shop/widgets/gesture_detector.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String? userName;
  String? password;

  final DatabaseService _databaseService = DatabaseService.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Users',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Consumer<UserProvider>(builder: (context, userProvider, child) {
          return MyGestureDetector(
              onTap: () async {
                await userProvider.logOut();
                Navigator.pushNamed(context, '/login_page');
              },
              text: 'Logout');
          // return GestureDetector(
          //   onTap: () async {
          //     await userProvider.logOut();
          //     Navigator.pushNamed(context, '/login_page');
          //   },
          //   child: Container(
          //     width: 100,
          //     height: 50,
          //     decoration: const BoxDecoration(color: Colors.green),
          //     child: const Center(child: Text('Logout')),
          //   ),
          // );
        }),
      ),
    );
  }
}
