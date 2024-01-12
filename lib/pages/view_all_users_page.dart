import 'package:crudoperations/db/user_database.dart';
import 'package:crudoperations/model/user_model.dart';
import 'package:flutter/material.dart';

class ViewAllUsersPage extends StatefulWidget {
  const ViewAllUsersPage({Key? key}) : super(key: key);

  @override
  _ViewAllUsersPageState createState() => _ViewAllUsersPageState();
}

class _ViewAllUsersPageState extends State<ViewAllUsersPage> {
  late Future<List<UserModel>> _users;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _users = UserDatabase.instance.readAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                UserModel user = snapshot.data![index];
                return ListTile(
                  title: Text(user.fullName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Id: ${user.id.toString()}'),
                      Text(user.email),
                      Text('Phone: ${user.phone.toString()}'),
                      Text('Address: ${user.address}'),
                      Text('Email: ${user.email}'),
                      Text('Password: ${user.password}'),
                      Text('Role: ${user.role}'),
                      Text('Created Time: ${user.created_at}'),
                      Text('Updated Time: ${user.updated_at}'),
                      Text('Active: ${user.active}'),
                      // Add more user details here if needed
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
