import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/main.dart';

import '../bloc/BlocEvent/LoginEvent.dart';
import '../data/global.dart';
import '../mainBody.dart';
import '../widget/common/ComInputText.dart';

class LoginPageWidget extends StatelessWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.blue[100]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/logo_tpk.png",
                                  ),
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
                              child: ComInputText(
                                keyboardtype: TextInputType.visiblePassword,
                                nLimitedChar: 50,
                                width: 240,
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
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/welcome_1.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
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
      },
      child: Container(
        height: 40,
        width: 240,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "LOGIN",
            style: GoogleFonts.ramabhadra(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class _MainContextState extends State<MainContext> {
  final ValueNotifier<ThemeData> _themeNotifier =
      ValueNotifier<ThemeData>(lightTheme);

  void toggleLightMode() {
    _themeNotifier.value =
        _themeNotifier.value == darkTheme ? lightTheme : darkTheme;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: _themeNotifier,
      builder: (context, currentTheme, child) {
        return MaterialApp(
          title: 'Web Application',
          theme: currentTheme,
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo[50],
              actions: [
                IconButton(
                  icon: Icon(
                    _themeNotifier.value == lightTheme
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                  onPressed: toggleLightMode,
                ),
              ],
            ),
            body: const MainBlocRebuild(),
          ),
        );
      },
    );
  }
}
