import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqres_in_app/providers/user_provider.dart';

class UserDetailPage extends StatelessWidget {
  final int userId;

  UserDetailPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false)
            .loadUserDetail(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final user = Provider.of<UserProvider>(context).selectedUser;
          if (user == null) {
            return Center(child: Text('User not found'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.avatar),
                ),
                SizedBox(height: 16),
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(user.email, style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}
