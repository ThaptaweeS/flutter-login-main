import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/page2-data/autofeed-input.dart';

import '../../bloc/BlocEvent/ChangePageEvent.dart';
import 'tank10-input/data1019after.dart';
import 'tank10-input/data1019befor.dart';
import 'tank13-input/data1319after.dart';
import 'tank13-input/data1319befor.dart';
import 'tank14-input/data1419after.dart';
import 'tank14-input/data1419befor.dart';
import 'tank2-input/data219after.dart';
import 'tank2-input/data219befor.dart';
import 'tank5-input/data519after.dart';
import 'tank5-input/data519befor.dart';
import 'tank8-input/data819after.dart';
import 'tank8-input/data819befor.dart';
import 'tank9-input/data919after.dart';
import 'tank9-input/data919befor.dart';

late BuildContext Page055AutoContext;

class Page055Autobody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            CuPage = Page02Autobody();
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
        title: Text("Select Tank | 19:00", style: GoogleFonts.ramabhadra()),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.indigo[50],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FixedColumnWidth(400.0),
                      1: FixedColumnWidth(220.0),
                      2: FixedColumnWidth(220.0),
                    },
                    children: [
                      buildTableRow(
                        "Tank2 (3-2) : Degreasing (FC-4360)",
                        Icons.add_chart_outlined,
                        Icons.add_box_outlined,
                        Colors.blue,
                        Tank219BeforePage(),
                        Tank219AfterPage(),
                        context,
                        "http://127.0.0.1:1882/tank2before19",
                        "http://127.0.0.1:1882/tank2after19",
                      ),
                      buildTableRow(
                        "Tank5 (3-5) : Acid picking No.1 (HCI)",
                        Icons.add_chart_outlined,
                        Icons.add_box_outlined,
                        Colors.green,
                        Tank519BeforePage(),
                        Tank519AfterPage(),
                        context,
                        "http://127.0.0.1:1882/tank5before19",
                        "http://127.0.0.1:1882/tank5after19",
                      ),
                      buildTableRow(
                        "Tank8 (3-8) : Surface condition (PL-ZN)",
                        Icons.add_chart_outlined,
                        Icons.add_box_outlined,
                        Colors.blue,
                        Tank819BeforePage(),
                        Tank819AfterPage(),
                        context,
                        "http://127.0.0.1:1882/tank8before19",
                        "http://127.0.0.1:1882/tank8after19",
                      ),
                      buildTableRow(
                        "Tank9 (3-9) : Phosphate (PB-3650X)",
                        Icons.add_chart_outlined,
                        Icons.add_box_outlined,
                        Colors.orange,
                        Tank919BeforePage(),
                        Tank919AfterPage(),
                        context,
                        "http://127.0.0.1:1882/tank9before19",
                        "http://127.0.0.1:1882/tank9after19",
                      ),
                      buildTableRow(
                        "Tank10 (3-10) : Phosphate (PB-181X) ",
                        Icons.add_chart_outlined,
                        Icons.add_box_outlined,
                        Colors.grey,
                        Tank1019BeforePage(),
                        Tank1019AfterPage(),
                        context,
                        "http://127.0.0.1:1882/tank10before19",
                        "http://127.0.0.1:1882/tank10after19",
                      ),
                      buildTableRow(
                        "Tank13 (3-13) : Lubricant (Lub-4618) ",
                        Icons.add_chart_outlined,
                        Icons.add_box_outlined,
                        Colors.green,
                        Tank1319BeforePage(),
                        Tank1319AfterPage(),
                        context,
                        "http://127.0.0.1:1882/tank13before19",
                        "http://127.0.0.1:1882/tank13after19",
                      ),
                      buildTableRow(
                        "Tank14 (3-14) : Lubricant (Lub-235T) ",
                        Icons.add_chart_outlined,
                        Icons.add_box_outlined,
                        Colors.blue,
                        Tank1419BeforePage(),
                        Tank1419AfterPage(),
                        context,
                        "http://127.0.0.1:1882/tank14before19",
                        "http://127.0.0.1:1882/tank14after19",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 168),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow buildTableRow(
    String text,
    IconData beforeIcon,
    IconData afterIcon,
    Color color,
    Widget beforePage,
    Widget afterPage,
    BuildContext context,
    String beforeApiUrl,
    String afterApiUrl,
  ) {
    return TableRow(
      children: [
        buildTableCell(buildTextWithIcon(text, beforeIcon)),
        buildTableCell(
            buildElevatedButton(beforeIcon, color, "Before", () async {
          await _callApi(context, beforeApiUrl, beforePage);
        })),
        buildTableCell(buildElevatedButton(afterIcon, color, "After", () async {
          await _callApi(context, afterApiUrl, afterPage);
        })),
      ],
    );
  }

  Future<void> _callApi(
      BuildContext context, String apiUrl, Widget nextPage) async {
    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final message = jsonResponse['message'];

      if (message == 'success') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Data Input',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
              content: Container(
                width: 800,
                height: 800, // ปรับขนาด popup ตามต้องการ
                child: nextPage, // แสดง Widget แทนหน้าถัดไป
              ),
              actions: <Widget>[
                TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close',
                      style: GoogleFonts.ramabhadra(color: Colors.black)),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
              content: Text(message),
              actions: <Widget>[
                TextButton(
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error',
                style: GoogleFonts.ramabhadra(color: Colors.black)),
            content: Text('Failed to call API',
                style: GoogleFonts.ramabhadra(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
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
  }

  Widget buildTableCell(Widget child) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }

  Widget buildElevatedButton(
      IconData icon, Color color, String buttonText, VoidCallback onPressed) {
    return SizedBox(
      width: 100.0,
      height: 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Set background color
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon), // Set icon
            SizedBox(height: 5), // Add space between icon and text
            Text(
              buttonText,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextWithIcon(String text, IconData icon) {
    return Row(
      children: [
        Text(
          text,
          style: GoogleFonts.ramabhadra(
              color: Colors.black), // Set text color to black
        ),
        SizedBox(width: 5), // Add space between text and icon
      ],
    );
  }
}

class Tank3BeforePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tank3 Before Page'),
      ),
      body: Center(
        child: Text('This is Tank3 Before Page'),
      ),
    );
  }
}

class Tank3AfterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tank3 After Page'),
      ),
      body: Center(
        child: Text('This is Tank3 After Page'),
      ),
    );
  }
}

class BlankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('System Error'),
      ),
      body: Center(
        child: Text('หน้านี้ยังไม่เปิดใช้งาน'),
      ),
    );
  }
}
