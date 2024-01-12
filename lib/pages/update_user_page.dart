import 'package:flutter/material.dart';
import 'package:crudoperations/db/user_database.dart';
import 'package:crudoperations/model/user_model.dart';

class UpdateUserPage extends StatefulWidget {
  const UpdateUserPage({Key? key}) : super(key: key);

  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPhoneController = TextEditingController();
  final TextEditingController _userAddressController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? _selectedUserId;
  List<int> _userIds = [];

  @override
  void initState() {
    super.initState();
    _fetchUserIds();
  }

  Future<void> _fetchUserIds() async {
    final List<UserModel> users = await UserDatabase.instance.readAllUsers();
    setState(() {
      _userIds = users.map((user) => user.id!).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                DropdownButton<int>(
                  hint: const Text('Select User ID'),
                  value: _selectedUserId,
                  items: _userIds.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      _selectedUserId = newValue;
                      _fetchUserDetails(newValue!);
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _userPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    // You can add additional phone number validation logic here
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _userAddressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _userEmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    // You can add additional email validation logic here
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _userPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    // You can add additional password validation logic here
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && _selectedUserId != null) {
                      await _updateUserDetails();
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchUserDetails(int userId) async {
    final UserModel user = await UserDatabase.instance.readUser(userId);
    setState(() {
      _userNameController.text = user.fullName;
      _userPhoneController.text = user.phone.toString();
      _userAddressController.text = user.address;
      _userEmailController.text = user.email;
      _userPasswordController.text = user.password;
    });
  }

  Future<void> _updateUserDetails() async {
  final UserModel updatedUser = UserModel(
    id: _selectedUserId,
    fullName: _userNameController.text,
    phone: int.parse(_userPhoneController.text),
    address: _userAddressController.text,
    email: _userEmailController.text,
    password: _userPasswordController.text,
    role: 'customer', // Update with the appropriate role
    created_at: DateTime.now(), // Update with the appropriate date
    updated_at: DateTime.now(), // Update with the appropriate date
    active: true, // Update with the appropriate value
  );

  try {
    final int rowsAffected = await UserDatabase.instance.update(updatedUser);
    print("done updated");
    if (rowsAffected > 0) {
      // Update successful
      // Add code for any specific action after successful update
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User updated successfully'),
          ),
        );
    } else {
      // No rows were affected, possibly no user with the provided ID found
    }
  } catch (e) {
    // Handle any potential errors during update
    print('Error updating user: $e');
  }
}

}
