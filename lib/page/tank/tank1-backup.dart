import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/page2-data/autofeed-input.dart';
import 'package:newmaster/page/tank/tank1-data/layout-chart.dart';

import '../P01DASHBOARD/P01DASHBOARD.dart';
import 'tank2.dart';

late BuildContext Tank1Context;
late BuildContext Page02Context;

class Tank1 extends StatelessWidget {
  const Tank1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tank1Context = context;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[50],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            CuPage = P1DASHBOARDMAIN();
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
        title: Center(
          child: Stack(
            children: <Widget>[
              // Stroked text as border.
              // Text(
              //   'Tank 2 Degreasing',
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
                'Tank 2 Degreasing',
                style: GoogleFonts.ramabhadra(
                  fontSize: 40,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Tank1Body(),
    );
  }
}

class Tank1Body extends StatefulWidget {
  const Tank1Body({super.key});

  @override
  State<Tank1Body> createState() => _Tank1BodyState();
}

class _Tank1BodyState extends State<Tank1Body> {
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo[50],
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  _showTextPopup(context);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.storage,
                    size: 24.0,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Degreasing (6000L) : Dashboard',
                    style: GoogleFonts.ramabhadra(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Chart133(),
                      ],
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 3,
                    child: Chart13(),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Chart21(),
                      ],
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 140),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (USERDATA.UserLV >= 3) {
                              CuPage = Page02Autobody();
                              MainBodyContext.read<ChangePage_Bloc>()
                                  .add(ChangePage_nodrower());
                            } else {
                              _showStatusNotification(
                                  context, "Error", "No permission");
                            }
                          },
                          icon: Icon(Icons.add_to_photos_outlined),
                          label: Text('Data Input'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 175, 184, 38),
                            minimumSize: Size(120, 60),
                          ),
                        ),
                        SizedBox(height: 25),
                        ElevatedButton.icon(
                          onPressed: () {
                            CuPage = Tank2BodyPage();
                            MainBodyContext.read<ChangePage_Bloc>()
                                .add(ChangePage_nodrower());
                          },
                          icon: Icon(Icons.fact_check_outlined),
                          label: Text('Data History'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 15, 161, 130),
                            minimumSize: Size(120, 60),
                          ),
                        ),
                      ],
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

  void _showTextPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail',
              style: GoogleFonts.ramabhadra(color: Colors.black)),
          content: Text(
            'Process : Fine Cleaner\nTank Capacity : 6000 Liters\n'
            'Chemicals : FC-4360\n:: Replenishing ::\nFC-4360= 6.6 kgs./1 pt\n'
            'FAl increase (1.1 g/l)\nFrequency of Checking : 4 Times/day',
            style: GoogleFonts.ramabhadra(fontSize: 13.0, color: Colors.black),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.pink[50]),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  void _showStatusNotification(
      BuildContext context, String title, String message) {
    final TextStyle customText = const TextStyle(
      color: Colors.black87,
      fontSize: 12,
      fontFamily: 'Mitr',
    );

    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 235, 238),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: IntrinsicWidth(
              child: Row(
                children: [
                  Icon(Icons.error, color: Colors.red, size: 24),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.ramabhadra(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          )),
                      SizedBox(
                          width: 267, child: Text(message, style: customText)),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay?.insert(_overlayEntry!);

    Future.delayed(Duration(seconds: 3), () {
      _overlayEntry?.remove();
    });
  }
}
