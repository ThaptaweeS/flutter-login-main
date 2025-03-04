import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';
import 'package:newmaster/page/page2-data/tank10-input/data107befor.dart';
import 'package:newmaster/page/page2-data/tank13-input/data137befor.dart';
import 'package:newmaster/page/page2-data/tank14-input/data147befor.dart';
import 'package:newmaster/page/page2-data/tank2-input/data27befor.dart';
import 'package:newmaster/page/page2-data/tank5-input/data57befor.dart';
import 'package:newmaster/page/page2-data/tank8-input/data87befor.dart';
import 'package:newmaster/page/page2-data/tank9-input/data97befor.dart';

class DataInput7Before extends StatefulWidget {
  @override
  _DataInput7BeforeState createState() => _DataInput7BeforeState();
}

class _DataInput7BeforeState extends State<DataInput7Before> {
  int selectedPage = 1; // เพิ่มตัวแปรเก็บค่าการเลือกหน้า

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[50],
        title: Center(
          child: Text(
            'Data Input Before value 7:00 AM.',
            style: GoogleFonts.ramabhadra(
              fontSize: 40,
              color: Colors.black,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            CuPage = P1DASHBOARDMAIN();
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.indigo[50],
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
                    _buildTankButton("Tank2", Colors.blue, 1),
                    _buildTankButton("Tank5", Colors.green, 2),
                    _buildTankButton("Tank8", Colors.yellow, 3),
                    _buildTankButton("Tank9", Colors.orange, 4),
                    _buildTankButton("Tank10", Colors.red, 5),
                    _buildTankButton("Tank13", Colors.purple, 6),
                    _buildTankButton("Tank14", Colors.amber, 7),
                  ],
                ),
              ),
            ),
            Expanded(child: _buildSelectedPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildTankButton(String tankName, Color color, int pageIndex) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedPage = pageIndex; // อัปเดตหน้าที่เลือก
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: color,
          minimumSize: Size(50, 60),
        ),
        child: Text(tankName),
      ),
    );
  }

  Widget _buildSelectedPage() {
    switch (selectedPage) {
      case 1:
        return Tank27BeforePage();
      case 2:
        return Tank57BeforePage();
      case 3:
        return Tank87BeforePage();
      case 4:
        return Tank97BeforePage();
      case 5:
        return Tank107BeforePage();
      case 6:
        return Tank137BeforePage();
      case 7:
        return Tank147BeforePage();
      default:
        return Tank27BeforePage();
    }
  }
}
