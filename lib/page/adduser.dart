import 'dart:convert'; // สำหรับ JSON

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';

class AddUser extends StatefulWidget {
  final Function(Map<String, String>) onAddUser; // Callback สำหรับส่งข้อมูลกลับ

  const AddUser({required this.onAddUser, super.key});

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedRole;
  String? _selectedPermission;

  final List<String> _roles = [
    'ADMIN',
    'QC Engineer',
    'PD Engineer',
    'QC Staff',
    'PD Staff'
  ];
  final List<String> _permissions = ['9', '1', '15'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[50],
        title: Text('เพิ่มผู้ใช้งาน', style: GoogleFonts.ramabhadra()),
      ),
      backgroundColor: Colors.indigo[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Surname',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              // TextField(
              //   controller: _emailController,
              //   decoration: const InputDecoration(
              //     labelText: 'อีเมล',
              //     border: OutlineInputBorder(),
              //   ),
              //   keyboardType: TextInputType.emailAddress,
              // ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'บทบาท',
                  border: OutlineInputBorder(),
                ),
                value: _selectedRole,
                items: _roles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(
                      role,
                      style: GoogleFonts.ramabhadra(color: Colors.black),
                    ),
                  );
                }).toList(),
                dropdownColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'สิทธิ์',
                  border: OutlineInputBorder(),
                ),
                value: _selectedPermission,
                items: _permissions.map((permission) {
                  return DropdownMenuItem(
                    value: permission,
                    child: Text(
                      permission,
                      style: GoogleFonts.ramabhadra(color: Colors.black),
                    ),
                  );
                }).toList(),
                dropdownColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    _selectedPermission = value;
                  });
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isEmpty ||
                        _usernameController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        // _emailController.text.isEmpty ||
                        _selectedRole == null ||
                        _selectedPermission == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                        ),
                      );
                    } else {
                      widget.onAddUser({
                        "name": _nameController.text,
                        "username": _usernameController.text,
                        "role": _selectedRole!,
                        "lastLogin": "Just now",
                      });
                      Navigator.pop(context); // กลับไปหน้าหลัก
                    }
                  },
                  child: const Text('บันทึก'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  late Future<List<Map<String, dynamic>>> _usersFuture;

  // ฟังก์ชันดึงข้อมูลจาก API
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    const url =
        'http://172.23.10.51:1111/users'; // Replace with Node-RED API URL
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>(); // Convert JSON to List of Maps
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  @override
  void initState() {
    super.initState();
    _usersFuture = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70, // เพิ่มความสูงของ AppBar
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                CuPage = P1DASHBOARDMAIN();
                MainBodyContext.read<ChangePage_Bloc>()
                    .add(ChangePage_nodrower());
              },
            ),
            // const Text('Dashboard'),
          ],
        ),

        title: Center(
          child: Stack(
            children: <Widget>[
              // Stroked text as border.
              // Text(
              //   'User Management',
              //   style: GoogleFonts.ramabhadra(
              //     fontSize: 40,
              //     foreground: Paint()
              //       ..style = PaintingStyle.stroke
              //       ..strokeWidth = 6
              //       ..color = Colors.blue[700]!,
              //   ),
              // ),
              // Solid text as fill.
              Text(
                'User Management',
                style: GoogleFonts.ramabhadra(
                  fontSize: 40,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        // shadowColor: Colors.transparent,
        backgroundColor: Colors.indigo[50],
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () => _navigateToAddUser(context),
                child: const Row(
                  children: [
                    Icon(Icons.add_reaction_rounded),
                    SizedBox(width: 8),
                    Text('Add User'),
                  ],
                ),
              )
            ],
          )
        ],
      ),
      backgroundColor: Colors.indigo[50],
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          final users = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(
                      user["name"][0], // Display the first letter of the name
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(user["name"]),
                  subtitle: Text(
                      'Username: ${user["username"]}\nRole: ${user["role"]}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _editUser(context, user);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _confirmDeleteUser(context, user);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _navigateToAddUser(context),
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  void _navigateToAddUser(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUser(
          onAddUser: (newUser) {
            _addUser(newUser);
          },
        ),
      ),
    );
    setState(() {
      _usersFuture = fetchUsers(); // Reload the user list
    });
  }

  Future<void> _addUser(Map<String, String> newUser) async {
    const url = 'http://172.23.10.51:1111/addUser'; // Node-RED API URL
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newUser),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User added successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add user: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding user: $e')),
      );
    }
  }

  void _confirmDeleteUser(BuildContext context, Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User',
              style: GoogleFonts.ramabhadra(color: Colors.black)),
          content: Text(
            'คุณต้องการลบผู้ใช้ ${user["name"]} หรือไม่?',
            style: GoogleFonts.ramabhadra(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteUser(user["id"]);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

// Function to handle edit action
  void _editUser(BuildContext context, Map<String, dynamic> user) {
    String? _selectedRole;
    final List<String> _roles = [
      'ADMIN',
      'QC Engineer',
      'PD Engineer',
      'QC Staff',
      'PD Staff'
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController =
            TextEditingController(text: user["name"]);
        TextEditingController usernameController =
            TextEditingController(text: user["username"]);
        TextEditingController roleController =
            TextEditingController(text: user["role"]);

        return AlertDialog(
          title: Text('Edit User',
              style: GoogleFonts.ramabhadra(color: Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: GoogleFonts.ramabhadra(
                    color: Colors.black), // Text color black
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: usernameController,
                style: GoogleFonts.ramabhadra(
                    color: Colors.black), // Text color black
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
                value: _selectedRole,
                items: _roles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(
                      role,
                      style: GoogleFonts.ramabhadra(color: Colors.black),
                    ),
                  );
                }).toList(),
                dropdownColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle save action here
                _saveUser(user["id"], nameController.text,
                    usernameController.text, roleController.text);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteUser(int id) async {
    const url = 'http://172.23.10.51:1111/deleteUser'; // Node-RED API URL
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': id}),
      );

      if (response.statusCode == 200) {
        setState(() {
          _usersFuture = fetchUsers(); // Reload users after deletion
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User deleted successfully')),
        );
      } else {
        print('Failed to delete user: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete user: ${response.body}')),
        );
      }
    } catch (e) {
      print('Error deleting user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting user: $e')),
      );
    }
  }

// Function to save edited user data
  void _saveUser(int id, String name, String username, String role) {
    _updateUser(id, name, username, role).then((_) {
      setState(() {
        _usersFuture = fetchUsers(); // รีโหลดข้อมูลผู้ใช้
      });
    }).catchError((error) {
      print('Error while updating user: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user: $error')),
      );
    });
  }

  Future<void> _updateUser(
      int id, String name, String username, String role) async {
    const url = 'http://172.23.10.51:1111/updateUser'; // URL ของ Node-RED API
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': id,
          'name': name,
          'username': username,
          'role': role,
        }),
      );

      if (response.statusCode == 200) {
        print('User updated successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User updated successfully')),
        );
      } else {
        print('Failed to update user: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user: ${response.body}')),
        );
      }
    } catch (e) {
      print('Error updating user: $e');
    }
  }
}
