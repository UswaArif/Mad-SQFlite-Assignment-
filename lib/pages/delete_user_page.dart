import 'package:flutter/material.dart';
import 'package:crudoperations/db/user_database.dart';

class DeleteUserPage extends StatefulWidget {
  const DeleteUserPage({Key? key}) : super(key: key);

  @override
  _DeleteUserPageState createState() => _DeleteUserPageState();
}

class _DeleteUserPageState extends State<DeleteUserPage> {
  final TextEditingController _userIdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _userIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'User ID to delete',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a user ID';
                  }
                  // You can add additional validation for the ID
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _deleteUser(context);
                  }
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteUser(BuildContext context) async {
    final int userId = int.parse(_userIdController.text);

    try {
      final int rowsAffected = await UserDatabase.instance.delete(userId);
      if (rowsAffected > 0) {
        // Deletion successful
        // Show a snackbar message for successful deletion
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User deleted successfully'),
          ),
        );
        // Add code for any specific action after successful deletion
      } else {
        // No rows were affected, possibly no user with the provided ID found
      }
    } catch (e) {
      // Handle any potential errors during deletion
      print('Error deleting user: $e');
    }
  }
}
