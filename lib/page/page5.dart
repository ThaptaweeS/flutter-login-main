import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/page2-data/autofeed-input.dart';
import 'package:newmaster/page/tank/tank1-data/layout-chart.dart';
import 'package:newmaster/responsive.dart';

import 'P01DASHBOARD/P01DASHBOARD.dart';
import 'tank/tank5.dart';

late BuildContext Page5Context;

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Page5Context = context;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              CuPage = P1DASHBOARDMAIN();
              MainBodyContext.read<ChangePage_Bloc>()
                  .add(ChangePage_nodrower());

              // Handle back button click
            },
          ),
        ),
        body: Page5Body());
  }
}

class Page5Body extends StatefulWidget {
  const Page5Body({super.key});

  @override
  State<Page5Body> createState() => _P1DASHBOARDMAINState2();
}

class _P1DASHBOARDMAINState2 extends State<Page5Body> {
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
                  Icons.storage,
                  size: 24.0,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                title: Text(
                  'Acid picking No.1 (4000L) : Dashboard',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Chart133(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Chart13(),
                ),
                SizedBox(width: defaultPadding),
              ],
            ),
            // SizedBox(height: defaultPadding), // Add space between the rows
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Chart21(),
                      // SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context))
                        // SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) Chart21(),
                    ],
                  ),
                ),

                // SizedBox(
                //   width: 10,
                // ),
                // Expanded(
                //   flex: 2,
                //   child: Container(
                //     width: 200.0,
                //     height: 300.0,
                //     child:
                //         BarChartSample2(), // Replace YourWidget with the actual widget
                //   ),
                // ),
                // Add more widgets as needed
                //   ],
                // ),
                // // SizedBox(height: 10),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                // Expanded(
                //   flex: 2,
                //   child: Column(
                //     children: [
                //       DataHistory2(),
                //       SizedBox(height: defaultPadding),
                //       if (Responsive.isMobile(context)) DataHistory2(),
                //       // SizedBox(height: defaultPadding),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   width: 10,
                // ),
                Expanded(
                  flex: 2,
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
                            CuPage = Tank5BodyPage();
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
                          )),
                      // First FileInfoCardGridView
                      // FileInfoCardGridView(), // You can adjust the size or style within the FileInfoCardGridView class
                      // SizedBox(height : 10,),
                      // Second FileInfoCardGridView
                      // FileInfoCardGridView2(), // You can adjust the size or style within the FileInfoCardGridView2 class

                      // Additional widgets can be added here

                      // Rest of your Column children
                      // ...
                    ],
                  ),
                ),
                // Add more widgets as needed
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
            'Process : Fine Cleaner \nTank Capacity : 6000 Litters \nChemicals : FC-4360 \n:: Replenishing :: \nFC-4360= 6.6 kgs./1 pt\n FAl increase (1.1 g/l)\nFrequency of Checking : 4 Times/day ',
            style: TextStyle(fontSize: 13.0)),
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
