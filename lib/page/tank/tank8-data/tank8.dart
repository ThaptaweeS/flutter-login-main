import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';
import 'package:newmaster/page/page2-data/autofeed-input.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/page/tank/Tank8-data/layout-chart.dart';
import 'package:newmaster/page/tank/Tank8-data/layout-chart2-2.dart';
import '../Tank8.dart';
import 'layout-chart2.dart';

late BuildContext Tank8Context;
late BuildContext Page02Context;

class Tank8 extends StatelessWidget {
  const Tank8({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tank8Context = context;

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
        body: Tank8Body());
  }
}

class Tank8Body extends StatefulWidget {
  const Tank8Body({super.key});

  @override
  State<Tank8Body> createState() => _P1DASHBOARDMAINState2();
}

class _P1DASHBOARDMAINState2 extends State<Tank8Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                title: Text(
                  'Surface condition (5000L) : Dashboard',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                      Chart13(),
                    ],
                  ),
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  flex: 3,
                  child: Chart133(),
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
                          CuPage = Page02Autobody();
                          MainBodyContext.read<ChangePage_Bloc>()
                              .add(ChangePage_nodrower());
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
                          CuPage = Tank8BodyPage();
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
        title: Text('Detail'),
        content: Text(
            // 'Process : Fine Cleaner \nTank Capacity : 6000 Litters \nChemicals : FC-4360 \n:: Replenishing :: \nFC-4360= 6.6 kgs./1 pt\n FAl increase (1.1 g/l)\nFrequency of Checking : 4 Times/day ',
            '',
            style: TextStyle(fontSize: 13.0)),
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
