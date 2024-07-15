import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('New password and re-entered password do not match'),
      ));
      return;
    }

    // Prepare the data to send
    Map<String, dynamic> requestData = {
      'old_password': oldPassword,
      'new_password': newPassword,
      'user_name': USERDATA.NAME, // Include USERDATA.UserLV
    };

    // Send the data to the API endpoint
    try {
      final response = await http.post(
        Uri.parse('http://172.23.10.51:1111/setting'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        // Handle success
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password settings saved successfully', style: TextStyle(color: Colors.black)),
        ));
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to save password settings', style: TextStyle(color: Colors.black)),
        ));
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred while connecting to the server', style: TextStyle(color: Colors.black)),
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Password Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: oldPasswordController,
                decoration: InputDecoration(labelText: 'Old Password'),
                obscureText: true,
                style: TextStyle(fontSize: 16), // Set font size of text input
              ),
              SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                style: TextStyle(fontSize: 16),
                // Similar adjustments as above for the height and width
              ),
              SizedBox(height: 16),
              TextField(
                controller: reEnterPasswordController,
                decoration: InputDecoration(labelText: 'Re-enter Password'),
                obscureText: true,
                style: TextStyle(fontSize: 16),
                // Similar adjustments as above for the height and width
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      child: Container(
                        height: 40, // Set the height of the button
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 16),
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
                        height: 40, // Set the height of the button
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontSize: 16),
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
    );
  }
}
