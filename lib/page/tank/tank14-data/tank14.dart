import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';
import 'package:newmaster/page/page2-data/autofeed-input.dart';
import 'package:newmaster/page/tank/Tank14-data/layout-chart.dart';
import 'package:newmaster/page/tank/Tank14-data/layout-chart2-2.dart';

import '../Tank14.dart';
import 'layout-chart2.dart';

late BuildContext Tank14Context;
late BuildContext Page02Context;

class Tank14 extends StatelessWidget {
  const Tank14({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tank14Context = context;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              CuPage = P1DASHBOARDMAIN();
              MainBodyContext.read<ChangePage_Bloc>()
                  .add(ChangePage_nodrower());
            },
          ),
        ),
        body: Tank14Body());
  }
}

class Tank14Body extends StatefulWidget {
  const Tank14Body({super.key});

  @override
  State<Tank14Body> createState() => _P1DASHBOARDMAINState2();
}

class _P1DASHBOARDMAINState2 extends State<Tank14Body> {
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.blue[100]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ), // Set the background color to white
      child: SafeArea(
        child: SingleChildScrollView(
          primary: false,
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
                    'Lubricant (Lub-235 (5000L)) : Dashboard',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                    flex: 3,
                    child: Column(
                      children: [
                        Chart136(),
                      ],
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 140,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (USERDATA.UserLV >= 3) {
                              CuPage = Page02Autobody();
                              MainBodyContext.read<ChangePage_Bloc>()
                                  .add(ChangePage_nodrower());
                            } else {
                              _showStatusNotification(
                                  context, "Error", "No have permission");
                            }
                          },
                          icon: Icon(Icons.add_to_photos_outlined),
                          label: Text('Data Input'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 175, 184, 38),
                            minimumSize:
                                Size(120, 60), // Set the size of the button
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            CuPage = Tank14BodyPage();
                            MainBodyContext.read<ChangePage_Bloc>()
                                .add(ChangePage_nodrower());
                          },
                          icon: Icon(Icons.fact_check_outlined),
                          label: Text('Data History'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 15, 161, 130),
                            minimumSize:
                                Size(120, 60), // Set the size of the button
                          ),
                        ),
                      ],
                    ),
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
                      children: [
                        Chart25(),
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
          title: Text('Detail'),
          content: Text(
              // 'Process : Fine Cleaner \nTank Capacity : 6000 Litters \nChemicals : FC-4360 \n:: Replenishing :: \nFC-4360= 6.6 kgs./1 pt\n FAl increase (1.1 g/l)\nFrequency of Checking : 4 Times/day ',
              '',
              style: TextStyle(fontSize: 13.0, color: Colors.black)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showStatusNotification(
      BuildContext context, String title, String message) {
    final TextStyle costomtext = const TextStyle(
      color: Colors.black87,
      fontSize: 12,
      fontFamily: 'Mitr',
    );

    final Icon _ShowIconStatus = Icon(
      Icons.error,
      color: Colors.red,
      size: 24,
    );

    final Text _ShowMsg_status_notification = Text(title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontFamily: 'Mitr'));

    final SizedBox _ShowMsg_Expand = SizedBox(
      child: SizedBox(
        child: Text(message, style: costomtext),
        width: 267,
      ),
    );

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
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
                  _ShowIconStatus,
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ShowMsg_status_notification,
                      _ShowMsg_Expand,
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

    overlay?.insert(overlayEntry);

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
