import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/components/file_info_card.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/page/P3TANKMASTER/P3TANKMASTERvar.dart';
import 'package:newmaster/page/tank/tank1-backup.dart';
import 'package:newmaster/page/tank/tank10-data/tank10.dart';
import 'package:newmaster/page/tank/tank11.dart';
import 'package:newmaster/page/tank/tank12.dart';
import 'package:newmaster/page/tank/tank13-data/tank13.dart';
import 'package:newmaster/page/tank/tank14-data/tank14.dart';
import 'package:newmaster/page/tank/tank3.dart';
import 'package:newmaster/page/tank/tank4.dart';
import 'package:newmaster/page/tank/tank5-data/tank5.dart';
import 'package:newmaster/page/tank/tank6.dart';
import 'package:newmaster/page/tank/tank7.dart';
import 'package:newmaster/page/tank/tank8-data/tank8.dart';
import 'package:newmaster/page/tank/tank9-data/tank9.dart';

import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../mainBody.dart';
import '../../models/MyFiles.dart';

class P1DASHBOARDMAIN extends StatefulWidget {
  const P1DASHBOARDMAIN({super.key});

  @override
  State<P1DASHBOARDMAIN> createState() => _P1DASHBOARDMAINState();
}

class _P1DASHBOARDMAINState extends State<P1DASHBOARDMAIN> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchStatusAndUpdateColors();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _toggleVisibility(int id) {
    setState(() {
      visibilityStates[id] = !visibilityStates[id]!;
      void _toggleVisibility(int id) {
        setState(() {
          visibilityStates[id] = !visibilityStates[id]!;
        });
      }
    });
  }

  void _navigateToTank(int id) {
    switch (id) {
      case 1:
        CuPage = Tank1();
        P3TANKMASTERvar.SelectPage = 3;
        break;
      case 2:
        CuPage = Tank1();
        P3TANKMASTERvar.SelectPage = 3;
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
        break;
      case 3:
        CuPage = Tank3();
        break;
      case 4:
        CuPage = Tank4();
        break;
      case 5:
        CuPage = Tank5();
        P3TANKMASTERvar.SelectPage = 4;
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
        break;
      case 6:
        CuPage = Tank6();
        break;
      case 7:
        CuPage = Tank7();
        break;
      case 8:
        CuPage = Tank8();
        P3TANKMASTERvar.SelectPage = 7;
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
        break;
      case 9:
        CuPage = Tank9();
        P3TANKMASTERvar.SelectPage = 8;
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
        break;
      case 10:
        CuPage = Tank10();
        P3TANKMASTERvar.SelectPage = 9;
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
        break;
      case 11:
        CuPage = Tank11();
        break;
      case 12:
        CuPage = Tank12();
        break;
      case 13:
        CuPage = Tank13(); // Example page
        P3TANKMASTERvar.SelectPage = 12;
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
        break;
      case 14:
        CuPage = Tank14(); // Example page
        P3TANKMASTERvar.SelectPage = 13;
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
        break;
      default:
        CuPage = P1DASHBOARDMAIN();
    }
    MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
  }

  @override
  Widget build(BuildContext context) {
    fetchStatusAndUpdateColors();

    // Filter out hidden items
    List<int> visibleKeys =
        visibilityStates.keys.where((key) => visibilityStates[key]!).toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Chemical Control Monitoring'),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => _showSettingsDialog(context),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue[100]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = (constraints.maxWidth / 200)
                  .floor(); // Adjust the item width as needed
              return SingleChildScrollView(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    const MyFilesHeader(),
                    const SizedBox(height: defaultPadding),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: visibleKeys.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: defaultPadding,
                        mainAxisSpacing: defaultPadding,
                        childAspectRatio:
                            1, // Adjust the aspect ratio as needed
                      ),
                      itemBuilder: (context, index) {
                        int id = visibleKeys[index];
                        return FileInfoCard(
                          info: demoMyFiles[id - 1],
                          onTap: () => _navigateToTank(id),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void fetchStatusAndUpdateColors() {
    // Dummy implementation
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Toggle Tanks Visibility',
              style: TextStyle(color: Colors.black)),
          content: SingleChildScrollView(
            child: Column(
              children: [
                for (var id in visibilityStates.keys)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tank $id', style: TextStyle(color: Colors.black)),
                      Switch(
                        value: visibilityStates[id]!,
                        onChanged: (bool value) {
                          _toggleVisibility(id);
                          Navigator.of(context).pop();
                          _showSettingsDialog(context); // Refresh dialog
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class MyFilesHeader extends StatelessWidget {
  const MyFilesHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "Select Tank",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(width: 25),
            const CircleAvatar(
              backgroundColor: Colors.green,
              radius: 10,
            ),
            const SizedBox(width: 5),
            const Text(
              "Pass",
              style: TextStyle(
                fontSize: 11,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 15),
            const CircleAvatar(
              backgroundColor: Colors.yellow,
              radius: 10,
            ),
            const SizedBox(width: 5),
            const Text(
              "Waiting Check",
              style: TextStyle(
                fontSize: 11,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 15),
            const CircleAvatar(
              backgroundColor: Colors.red,
              radius: 10,
            ),
            const SizedBox(width: 5),
            const Text(
              "NG Value",
              style: TextStyle(
                fontSize: 11,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
