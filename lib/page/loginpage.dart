import 'package:flutter/material.dart';
//--------------------------------------------- Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/BlocEvent/LoginEvent.dart';
import '../bloc/cubit/Rebuild.dart';
import '../mainBody.dart';
import '../widget/common/ComInputText.dart';
import '../data/global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPageWidget extends StatelessWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 400,
          width: 350,
          child: SingleChildScrollView(
              child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 50, end: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 100,
                    // width: 300,
                    decoration: const BoxDecoration(
                      // color: Colors.red,
                      image: DecorationImage(
                        image: AssetImage("assets/images/logo_tpk.png"),
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    child: ComInputText(
                      height: 40,
                      width: 240,
                      sPlaceholder: "Username",
                      isContr: logindata.isControl,
                      fnContr: (input) {
                        logindata.isControl = input;
                      },
                      sValue: logindata.userID,
                      returnfunc: (String s) {
                        logindata.userID = s;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    // child: ComInputText(
                    //   height: 40,
                    //   width: 240,
                    //   isPassword: true,
                    //   isContr: logindata.isControl,
                    //   fnContr: (input) {
                    //     logindata.isControl = input;
                    //   },
                    //   sValue: logindata.userPASS,
                    //   returnfunc: (String s) {
                    //     logindata.userPASS = s;
                    //   },
                    // ),
                    child: ComInputText(
                      keyboardtype: TextInputType.visiblePassword,
                      nLimitedChar: 50,
                      width: 500,
                      sPlaceholder: "Password",
                      height: 40,
                      isContr: logindata.isControl,
                      fnContr: (input) {
                        logindata.isControl = input;
                      },
                      sValue: logindata.userPASS,
                      returnfunc: (String s) {
                        logindata.userPASS = s;
                      },
                      isEnabled: true,
                      isPassword: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const _LoginSignin(),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class _LoginSignin extends StatelessWidget {
  const _LoginSignin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          String username = logindata.userID;
          String password = logindata.userPASS;
          LoginContext.read<Login_Bloc>().add(LoginPage());
          // sendLoginRequest(username, password);
          // BlocProvider.of<SwPageCubit>(context).togglePage("Page1");
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              "LOGIN",
              style: TextStyle(
                fontFamily: 'Mitr',
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              ),
            ),
          ),
        ));
  }
}

// Future<void> sendLoginRequest(String username, String password) async {
//   final url = Uri.parse(
//       'http://172.23.10.51:1111/login'); // Replace with your API endpoint

//   try {
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json', // Set the appropriate content type
//       },
//       body: json.encode({
//         'username': username,
//         'password': password,
//       }),
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       String permission = responseData['permission'];
//       String name = responseData['name'];

//       print("Permission: $permission" );
//       print("Name API: $name" );
//       print("-------------------------------------");
//       token = permission;
//       name = name;
//       print('Token2: $token');
//       print('Name2: $name');
//       print("-------------------------------------");

//       LoginContext.read<Login_Bloc>().add(LoginPage());
//     } else {
//       token = "";
//       LoginContext.read<Login_Bloc>().add(LoginPage());
//     }
//   } catch (error) {
//     // Handle any network-related errors here
//     print('Error: $error');
//     LoginContext.read<Login_Bloc>().add(LoginPage());
//   }

  
// }
