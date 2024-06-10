import 'package:flutter/material.dart';
import 'package:reqres_in_app/models/user_model.dart';
import 'package:reqres_in_app/services/api_service.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  User? _selectedUser;

  List<User> get users => _users;
  User? get selectedUser => _selectedUser;

  Future<void> loadUsers() async {
    _users = await ApiService().fetchUsers();
    notifyListeners();
  }

  Future<void> loadUserDetail(int id) async {
    _selectedUser = await ApiService().fetchUserDetail(id);
    notifyListeners();
  }

  Future<void> addUser(String name, String job) async {
    await ApiService().createUser(name, job);
    await loadUsers();
  }
}
