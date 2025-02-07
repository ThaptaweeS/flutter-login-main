import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';
import 'package:newmaster/page/adduser.dart';
import 'package:newmaster/page/editdata.dart';
import 'package:newmaster/page/settings.dart';

class MainSetting extends StatelessWidget {
  const MainSetting({Key? key}) : super(key: key);

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
        title: Center(
          child: Stack(
            children: <Widget>[
              // Stroked text as border.
              // Text(
              //   'Setting',
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
                'Setting',
                style: GoogleFonts.ramabhadra(
                  fontSize: 40,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.indigo[50],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          color: Colors.indigo[50],
          // begin: Alignment.topCenter,
          // end: Alignment.bottomCenter,
          // ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // เปลี่ยนหน้าไปยัง Add User
                    CuPage = UserManagementPage(); // ตัวอย่างหน้าใหม่
                    MainBodyContext.read<ChangePage_Bloc>()
                        .add(ChangePage_nodrower());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Set background color
                    fixedSize: Size(200, 100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_reaction_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10), // Add space between icon and text
                      Text(
                        "Add User",
                        style: GoogleFonts.ramabhadra(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {
                    // เปลี่ยนหน้าไปยัง Add User
                    CuPage = PasswordSettingPage(); // ตัวอย่างหน้าใหม่
                    MainBodyContext.read<ChangePage_Bloc>()
                        .add(ChangePage_nodrower());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Set background color
                    fixedSize: Size(200, 100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.change_circle_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10), // Add space between icon and text
                      Text(
                        "Change password",
                        style: GoogleFonts.ramabhadra(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {
                    // เปลี่ยนหน้าไปยัง Add User
                    CuPage = Editdata(); // ตัวอย่างหน้าใหม่
                    MainBodyContext.read<ChangePage_Bloc>()
                        .add(ChangePage_nodrower());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Set background color
                    fixedSize: Size(200, 100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10), // Add space between icon and text
                      Text(
                        "Edit Data",
                        style: GoogleFonts.ramabhadra(
                          color: Colors.white,
                        ),
                      ),
                    ],
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
