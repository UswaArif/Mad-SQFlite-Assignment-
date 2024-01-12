import 'package:flutter/material.dart';
import 'package:crudoperations/db/user_database.dart';
import 'package:crudoperations/model/user_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _userIdController = TextEditingController();
  UserModel? _foundUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(
                labelText: 'Enter User ID',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final int userId = int.tryParse(_userIdController.text) ?? 0;
                if (userId > 0) {
                  try {
                    final UserModel user = await UserDatabase.instance.readUser(userId);
                    setState(() {
                      _foundUser = user;
                    });
                  } catch (e) {
                    print('Error fetching user: $e');
                    setState(() {
                      _foundUser = null;
                    });
                  }
                } else {
                  setState(() {
                    _foundUser = null;
                  });
                }
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            if (_foundUser != null) ...[
              ListTile(
                title: Text(_foundUser!.fullName),
                subtitle: Text(_foundUser!.email),
                // Display other user details as needed
              ),
            ] else if (_userIdController.text.isNotEmpty) ...[
              const Text('User not found'),
            ],
          ],
        ),
      ),
    );
  }
}
