import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/page02.dart';
import 'package:newmaster/page/page2-data/autofeed-input2.dart';

import '../../bloc/BlocEvent/ChangePageEvent.dart';
import 'autofeed-input3.dart';
import 'autofeed-input4.dart';
import 'autofeed-input5.dart';

late BuildContext Page02AutoContext;

class Page02Auto extends StatelessWidget {
  const Page02Auto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Page02AutoContext = context;

    return Page02Autobody();
  }
}

class Page02Autobody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[50],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            CuPage = Page02body();
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
        title: Center(
          child: Stack(
            children: <Widget>[
              // Stroked text as border.
              Text(
                'Select Time',
                style: GoogleFonts.ramabhadra(
                  fontSize: 40,
                  color: Colors.black,
                  // foreground: Paint()
                  //   ..style = PaintingStyle.stroke
                  //   ..strokeWidth = 6
                  //   ..color = Colors.blue[700]!,
                ),
              ),
              // Solid text as fill.
              // Text(
              //   'Select Time',
              //   style: GoogleFonts.ramabhadra(
              //     fontSize: 40,
              //     color: Colors.grey[300],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          color: Colors.indigo[50],
          // begin: Alignment.topCenter,
          // end: Alignment.bottomCenter,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  CuPage = Page022Autobody();
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
                      Icons.access_time,
                      color: Colors.white,
                    ), // Set icon
                    SizedBox(height: 10), // Add space between icon and text
                    Text(
                      "01:00",
                      style: GoogleFonts.ramabhadra(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  CuPage = Page033Autobody();
                  MainBodyContext.read<ChangePage_Bloc>()
                      .add(ChangePage_nodrower());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: Size(200, 100), // Set background color
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer,
                      color: Colors.white,
                    ), // Set icon
                    SizedBox(height: 10), // Add space between icon and text
                    Text(
                      "07:00",
                      style: GoogleFonts.ramabhadra(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  CuPage = Page044Autobody();
                  MainBodyContext.read<ChangePage_Bloc>()
                      .add(ChangePage_nodrower());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  fixedSize: Size(200, 100), // Set background color
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.alarm,
                      color: Colors.white,
                    ), // Set icon
                    SizedBox(height: 10), // Add space between icon and text
                    Text(
                      "13:00",
                      style: GoogleFonts.ramabhadra(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  CuPage = Page055Autobody();
                  MainBodyContext.read<ChangePage_Bloc>()
                      .add(ChangePage_nodrower());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: Size(200, 100), // Set background color
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.schedule,
                      color: Colors.white,
                    ), // Set icon
                    SizedBox(height: 10), // Add space between icon and text
                    Text(
                      "19:00",
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
    );
  }
}
