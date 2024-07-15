import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.blue[100]!],
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
            child: ListView(
              shrinkWrap: true,
              children: [
                if (P3TANKMASTERvar.SelectPage == 0) Tank2BodyPage(),
                if (P3TANKMASTERvar.SelectPage == 1) Tank2BodyPage(),
                if (P3TANKMASTERvar.SelectPage == 2) Tank3body(),
                if (P3TANKMASTERvar.SelectPage == 3) Tank4body(),
                if (P3TANKMASTERvar.SelectPage == 4) Tank5BodyPage(),
                if (P3TANKMASTERvar.SelectPage == 5) Tank6body(),
                if (P3TANKMASTERvar.SelectPage == 6) Tank7body(),
                if (P3TANKMASTERvar.SelectPage == 7) Tank8BodyPage(),
                if (P3TANKMASTERvar.SelectPage == 8) Tank9BodyPage(),
                if (P3TANKMASTERvar.SelectPage == 9) Tank10BodyPage(),
                if (P3TANKMASTERvar.SelectPage == 10) Tank11body(),
                if (P3TANKMASTERvar.SelectPage == 11) Tank12body(),
                if (P3TANKMASTERvar.SelectPage == 12) Tank13BodyPage(),
                if (P3TANKMASTERvar.SelectPage == 13) Tank14BodyPage(),
                if (P3TANKMASTERvar.SelectPage == null) Tank2BodyPage(),
              ],
            ),
          ),
        ],
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
            P3TANKMASTERvar.SelectPage = pageIndex;
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
}
