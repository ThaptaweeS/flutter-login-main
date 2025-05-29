import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/global.dart';
import '../cubit/NotificationEvent.dart';

//-------------------------------------------------

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
late Future<String> tokenSP;

abstract class LoginEvent {}

class LoginPage extends LoginEvent {}

class ReLogin extends LoginEvent {}

class Logout extends LoginEvent {}

class Login_Bloc extends Bloc<LoginEvent, String> {
  Login_Bloc() : super('') {
    on<LoginPage>((event, emit) {
      return _LoginPage_Function(state, emit);
    });
    on<ReLogin>((event, emit) {
      return _ReLogin_Function(state, emit);
    });
    on<Logout>((event, emit) {
      return _Logout_Function(state, emit);
    });
  }

  Future<void> _LoginPage_Function(String toAdd, Emitter<String> emit) async {
    final SharedPreferences prefs = await _prefs;
    final url = Uri.parse('http://172.23.10.51:1111/login');

    try {
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type':
                  'application/json', // Set the appropriate content type
            },
            body: json.encode({
              'username': logindata.userID,
              'password': logindata.userPASS,
            }),
          )
          .timeout(Duration(seconds: 10)); // Specify a timeout of 10 seconds

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String permission = responseData['permission'];
        String name = responseData['name'];

        print("Permission: $permission");
        print("Name API: $name");
        print("-------------------------------------");
        token = permission;
        USERDATA.NAME = name;

        // Store token and name in SharedPreferences
        prefs.setString("tokenSP", token);
        prefs.setString("nameSP", name);

        print('Token2: $token');
        print('Name2: $name');
        print("-------------------------------------");

        // The rest of your logic remains the same
        if (token != '') {
          BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
              "Success", "Login OK", enumNotificationlist.Success);
          if (token == '1') {
            USERDATA.UserLV = 2;
            print(USERDATA.UserLV);
          } else if (token == '9') {
            USERDATA.UserLV = 5;
            print(USERDATA.UserLV);
          } else if (token == '15') {
            USERDATA.UserLV = 9;
            print(USERDATA.UserLV);
          } else {}
        } else {
          BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
              "Error",
              "User or password is incorrect",
              enumNotificationlist.Error);
        }

        emit(token);
      } else {
        // Handle the case when the server returns an error status code
        BlocProvider.of<BlocNotification>(contextGB).UpdateNotification("Error",
            "An error occurred while logging in", enumNotificationlist.Error);
      }
    } catch (e) {
      // Handle timeout or any other exception
      BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
          "Error", "Cannot connect to server", enumNotificationlist.Error);
    }
  }

  Future<void> _ReLogin_Function(String toAdd, Emitter<String> emit) async {
    final SharedPreferences prefs = await _prefs;
    token = prefs.getString('tokenSP') ?? '';
    // USERDATA.UserLV = 2;
    print(USERDATA.UserLV);
    // Retrieve name from SharedPreferences
    USERDATA.NAME = prefs.getString('nameSP') ?? '';
    if (token == '1') {
      USERDATA.UserLV = 2;
      print(USERDATA.UserLV);
    } else if (token == '9') {
      USERDATA.UserLV = 5;
      print(USERDATA.UserLV);
    } else if (token == '15') {
      USERDATA.UserLV = 9;
      print(USERDATA.UserLV);
    } else {}

    emit(token);
  }

  Future<void> _Logout_Function(String toAdd, Emitter<String> emit) async {
    final SharedPreferences prefs = await _prefs;
    token = '';
    USERDATA.UserLV = 0;

    tokenSP = prefs.setString("tokenSP", token).then((bool success) {
      return state;
    });

    if (token == '') {
      BlocProvider.of<BlocNotification>(contextGB)
          .UpdateNotification("", "Logout", enumNotificationlist.Success);
    }

    emit('');
  }
}

class CustomLoginEvent extends LoginEvent {
  final String token;

  CustomLoginEvent(this.token);
}
