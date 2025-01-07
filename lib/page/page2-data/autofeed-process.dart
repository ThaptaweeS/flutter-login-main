import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/page/page02.dart';
import 'package:newmaster/page/page2-data/text-card.dart';
import 'package:newmaster/page/tank/tank1-data/pump.dart';

import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../mainBody.dart';

late BuildContext AutofeedContext;

class Autofeed extends StatelessWidget {
  const Autofeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AutofeedContext = context;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              CuPage = Page02body();
              MainBodyContext.read<ChangePage_Bloc>()
                  .add(ChangePage_nodrower());
            },
          ),
        ),
        body: AutofeedBody());
  }
}

class AutofeedBody extends StatefulWidget {
  const AutofeedBody({super.key});

  @override
  State<AutofeedBody> createState() => _P1DASHBOARDMAINState2();
}

class _P1DASHBOARDMAINState2 extends State<AutofeedBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                _showTextPopup(context);
              },
              child: ListTile(
                leading: Icon(
                  Icons.heat_pump,
                  size: 36.0,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                title: Text(
                  'Auto Feed Chemical : Dashboard',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 400.0,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Set border color
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  Zinc Phosphate 3650X',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.normal),
                      ),
                      FileInfoCardGridView2(),
                      TextCard2(),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showPopup(
                              context, "หน้าที่ท่านเลือกยังไม่เปิดใช้งาน");
                        },
                        icon: Icon(Icons.motion_photos_on),
                        label: Text('Feed',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.normal)),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 45, 107, 47),
                          minimumSize:
                              Size(30, 40), // Set the size of the button
                        ),
                      ),
                      Text(
                        '──────────────────────',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '  Acid Picking No.1',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.normal),
                      ),
                      FileInfoCardGridView3(),
                      TextCard1(),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showPopup(
                              context, "หน้าที่ท่านเลือกยังไม่เปิดใช้งาน");
                        },
                        icon: Icon(Icons.motion_photos_on),
                        label: Text('Feed'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 45, 107, 47),
                          minimumSize:
                              Size(30, 40), // Set the size of the button
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: defaultPadding),
                Container(
                  width: 400.0,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Set border color
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  Zinc Phosphate 181X',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.normal),
                      ),
                      FileInfoCardGridView4(),
                      TextCard3(),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showPopup(
                              context, "หน้าที่ท่านเลือกยังไม่เปิดใช้งาน");
                        },
                        icon: Icon(Icons.motion_photos_on),
                        label: Text('Feed'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 45, 107, 47),
                          minimumSize:
                              Size(30, 40), // Set the size of the button
                        ),
                      ),
                      Text(
                        '──────────────────────',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '  Lubricant (4618)',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.normal),
                      ),
                      FileInfoCardGridView5(),
                      TextCard4(),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showPopup(
                              context, "หน้าที่ท่านเลือกยังไม่เปิดใช้งาน");
                        },
                        icon: Icon(Icons.motion_photos_on),
                        label: Text('Feed'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 45, 107, 47),
                          minimumSize:
                              Size(30, 40), // Set the size of the button
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: defaultPadding),
                Container(
                  width: 400.0,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Set border color
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  Degreasing',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.normal),
                      ),
                      FileInfoCardGridView6(),
                      TextCard5(),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showPopup(
                              context, "หน้าที่ท่านเลือกยังไม่เปิดใช้งาน");
                        },
                        icon: Icon(Icons.motion_photos_on),
                        label: Text('Feed'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 45, 107, 47),
                          minimumSize:
                              Size(30, 40), // Set the size of the button
                        ),
                      ),
                      Text(
                        '──────────────────────',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '  Lubricant (235)',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.normal),
                      ),
                      FileInfoCardGridView7(),
                      TextCard6(),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showPopup(
                              context, "หน้าที่ท่านเลือกยังไม่เปิดใช้งาน");
                        },
                        icon: Icon(Icons.motion_photos_on),
                        label: Text('Feed'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 45, 107, 47),
                          minimumSize:
                              Size(30, 40), // Set the size of the button
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
    );
  }
}

void _showTextPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Auto Feed Chemical'),
        content: Text('', style: TextStyle(fontSize: 13.0)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK', style: TextStyle(color: Colors.black)),
          ),
        ],
      );
    },
  );
}

void _showPopup(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(" "),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
        ],
      );
    },
  );
}
