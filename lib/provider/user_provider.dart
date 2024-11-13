import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/db/database.dart';
import 'package:shop/models/user.dart';
import 'package:sqflite/sqflite.dart';

class UserProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instance;
  User? _currentUser;
  User? get currentUser => _currentUser;

  //update _currentUser if there is successful login

  Future<void> setUser(User user) async {
    _currentUser = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userID', user.id!);
    notifyListeners();
  }

  Future<void> logOut() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userID');
    notifyListeners();
  }

  Future<void> register(String login, String password) async {
    try {
      final newUser = User(login: login, password: password);
      final userId = await _databaseService.addUser(login, password);
      newUser.id = userId;
      await setUser(newUser);
    } catch (e) {
      if (e is DatabaseException &&
          e.toString().contains("UNIQUE constraint failed")) {
        throw 'Login is already existed';
      } else {
        throw e;
      }
    }
  }

  Future<bool> login(String login, String password) async {
    try {
      final newUser = User(login: login, password: password);
      final userId = await _databaseService.loginUser(login, password);
      if (userId != null) {
        newUser.id = userId;
        await setUser(newUser);
        return true;
      }
      return false;
    } catch (e) {
      throw 'Login error, try later';
    }
  }
}
