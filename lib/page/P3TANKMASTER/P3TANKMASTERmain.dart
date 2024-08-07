import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';

import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../tank/tank10.dart';
import '../tank/tank11.dart';
import '../tank/tank12.dart';
import '../tank/tank13.dart';
import '../tank/tank14.dart';
import '../tank/tank2.dart';
import '../tank/tank3.dart';
import '../tank/tank4.dart';
import '../tank/tank5.dart';
import '../tank/tank6.dart';
import '../tank/tank7.dart';
import '../tank/tank8.dart';
import '../tank/tank9.dart';
import 'P3TANKMASTERvar.dart';

class P3TANKMASTERMAIN extends StatefulWidget {
  const P3TANKMASTERMAIN({super.key});

  @override
  State<P3TANKMASTERMAIN> createState() => _P3TANKMASTERMAINState();
}

class _P3TANKMASTERMAINState extends State<P3TANKMASTERMAIN> {
  @override
  void initState() {
    super.initState();
    // Ensure P3TANKMASTERvar.SelectPage is initialized
    if (P3TANKMASTERvar.SelectPage == null) {
      P3TANKMASTERvar.SelectPage = 0;
    }
    print('Initial SelectPage: ${P3TANKMASTERvar.SelectPage}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Text('Data History'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            CuPage = P1DASHBOARDMAIN();
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.blue[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTankButton(context, "Tank2", Colors.blue, 1),
                    _buildTankButton(context, "Tank5", Colors.green, 4),
                    _buildTankButton(context, "Tank8", Colors.yellow, 7),
                    _buildTankButton(context, "Tank9", Colors.orange, 8),
                    _buildTankButton(context, "Tank10", Colors.red, 9),
                    _buildTankButton(context, "Tank13", Colors.purple, 12),
                    _buildTankButton(context, "Tank14", Colors.amber, 13),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _buildSelectedPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTankButton(
      BuildContext context, String tankName, Color color, int pageIndex) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            print('Button pressed: $tankName');
            P3TANKMASTERvar.SelectPage = pageIndex;
            print('SelectPage updated to: ${P3TANKMASTERvar.SelectPage}');
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: color, // Button text color
          minimumSize: Size(50, 60), // Button size
        ),
        child: Text(tankName),
      ),
    );
  }

  Widget _buildSelectedPage() {
    switch (P3TANKMASTERvar.SelectPage) {
      case 1:
        return Tank2BodyPage();
      case 2:
        return Tank3body();
      case 3:
        return Tank4body();
      case 4:
        return Tank5BodyPage();
      case 5:
        return Tank6body();
      case 6:
        return Tank7body();
      case 7:
        return Tank8BodyPage();
      case 8:
        return Tank9BodyPage();
      case 9:
        return Tank10BodyPage();
      case 10:
        return Tank11body();
      case 11:
        return Tank12body();
      case 12:
        return Tank13BodyPage();
      case 13:
        return Tank14BodyPage();
      default:
        return Tank2BodyPage();
    }
  }
}
