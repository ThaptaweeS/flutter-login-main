import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';

import '../data/global.dart';

class PasswordSettingPage extends StatefulWidget {
  const PasswordSettingPage({Key? key}) : super(key: key);

  @override
  _PasswordSettingPageState createState() => _PasswordSettingPageState();
}

class _PasswordSettingPageState extends State<PasswordSettingPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();

  void _save() async {
    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;
    String reEnterPassword = reEnterPasswordController.text;

    // Check if passwords match
    if (newPassword != reEnterPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('New password and re-entered password do not match'),
      ));
      return;
    }

    Map<String, dynamic> requestData = {
      'old_password': oldPassword,
      'new_password': newPassword,
      'user_name': USERDATA.NAME,
    };

    try {
      final response = await http.post(
        Uri.parse('http://172.23.10.51:1111/setting'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Password settings saved successfully',
            style: GoogleFonts.ramabhadra(color: Colors.black),
          ),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Failed to save password settings',
            style: GoogleFonts.ramabhadra(color: Colors.black),
          ),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'An error occurred while connecting to the server',
          style: GoogleFonts.ramabhadra(color: Colors.black),
        ),
      ));
    }
  }

  void _clearFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
    reEnterPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            CuPage = P1DASHBOARDMAIN(); // กลับไปยังหน้า Dashboard
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
        title: Text("Change Password",
            style: GoogleFonts.ramabhadra(color: Colors.black)),
        backgroundColor: Colors.indigo[50],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.indigo[50],
        ),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Container(
              width: 300, // Fixed width for the container
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: oldPasswordController,
                    decoration: InputDecoration(labelText: 'Old Password'),
                    obscureText: true,
                    style: GoogleFonts.ramabhadra(
                        fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: newPasswordController,
                    decoration: InputDecoration(labelText: 'New Password'),
                    obscureText: true,
                    style: GoogleFonts.ramabhadra(
                        fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: reEnterPasswordController,
                    decoration: InputDecoration(labelText: 'Re-enter Password'),
                    obscureText: true,
                    style: GoogleFonts.ramabhadra(
                        fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _save,
                          child: Container(
                            height: 40,
                            child: Center(
                              child: Text(
                                'Save',
                                style: GoogleFonts.ramabhadra(fontSize: 16),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _clearFields,
                          child: Container(
                            height: 40,
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.ramabhadra(fontSize: 16),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class User {
  final String username;
  final String name;
  final String role;

  User({required this.username, required this.name, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      name: json['name'],
      role: json['role'],
    );
  }
}

// Future<List<User>> fetchUsers() async {
//   final response =
//       await http.get(Uri.parse('http://172.23.10.51:1111/manual-feed-user'));

//   if (response.statusCode == 200) {
//     // Parse the JSON response
//     List<dynamic> data = json.decode(response.body);
//     return data.map((user) => User.fromJson(user)).toList();
//   } else {
//     throw Exception('Failed to load users');
//   }
// }

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<User>> futureUsers;

  @override
  // void initState() {
  //   super.initState();
  //   futureUsers = fetchUsers(); // Fetch users when the widget is initialized
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<User> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle:
                      Text('Username: ${user.username}\nRole: ${user.role}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
