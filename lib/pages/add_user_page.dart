import 'package:crudoperations/db/user_database.dart';
import 'package:crudoperations/model/user_model.dart';
import 'package:crudoperations/pages/delete_user_page.dart';
import 'package:crudoperations/pages/search_user_page.dart';
import 'package:crudoperations/pages/update_user_page.dart';
import 'package:crudoperations/pages/view_all_users_page.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  final String _role = "customer";
  DateTime _updated_at = DateTime.now(); // Initialize with the current time.


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add User Details"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: OverflowBar(
              overflowSpacing: 20,
              children: [
                TextFormField(
                  controller: _name,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Name is empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                TextFormField(
                  controller: _phone,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Phone Number is empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "Phone Number"),
                ),
                TextFormField(
                  controller: _address,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Address is empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "Address"),
                ),
                TextFormField(
                  controller: _email,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Email is empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                TextFormField(
                  controller: _password,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Password is empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "Password"),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                          // Create a UserModel instance using the data from the form
                        UserModel newUser = UserModel(
                          fullName: _name.text,
                          phone: int.parse(_phone.text),
                          address: _address.text,
                          email: _email.text,
                          password: _password.text,
                          role: _role,
                          created_at: DateTime.now(),
                          updated_at: DateTime.now(),
                          active: true,
                        );

                        setState(() {
                          isLoading = true; // Set loading state
                        });

                        try {
                          // Add user to the database
                          await UserDatabase.instance.create(newUser);

                          // Reset the form after successful user creation
                          _name.clear();
                          _phone.clear();
                          _address.clear();
                          _email.clear();
                          _password.clear();
                          
                          // Navigate to the login page or perform any other actions as needed
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const LoginPage()),
                          // );
                        } catch (e) {
                          // Handle any potential errors during user creation
                          print("Error creating user: $e");
                        } finally {
                          setState(() {
                            isLoading = false; // Reset loading state
                          });
                        }
                      }
                    },
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text("Add User"),
                  ),
                ),
                //View All User Button
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: ()  {
                      Navigator.push(
                             context,
                           MaterialPageRoute(builder: (context) => const ViewAllUsersPage()),
                         );
                    },
                    child: const Text("View All Users"),
                  ),
                ),
                //Search User
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: ()  {
                      Navigator.push(
                             context,
                           MaterialPageRoute(builder: (context) => const SearchPage()),
                         );
                    },
                    child: const Text("Search User"),
                  ),
                ),
                //Update User
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: ()  {
                      Navigator.push(
                             context,
                           MaterialPageRoute(builder: (context) => const UpdateUserPage()),
                         );
                    },
                    child: const Text("Update User"),
                  ),
                ),
                //Delete User
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: ()  {
                      Navigator.push(
                             context,
                           MaterialPageRoute(builder: (context) => const DeleteUserPage()),
                         );
                    },
                    child: const Text("Delete User"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
