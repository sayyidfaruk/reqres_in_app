import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reqres_in_app/models/user_model.dart';

class ApiService {
  static const String baseUrl = 'https://reqres.in/api';

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> fetchUserDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load user detail');
    }
  }

  Future<void> createUser(String name, String job) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      body: jsonEncode(<String, String>{
        'name': name,
        'job': job,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create user');
    }
  }
}
