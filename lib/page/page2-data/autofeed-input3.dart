import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/page2-data/autofeed-input.dart';

import '../../bloc/BlocEvent/ChangePageEvent.dart';
import 'tank10-input/data107after.dart';
import 'tank10-input/data107befor.dart';
import 'tank13-input/data137after.dart';
import 'tank13-input/data137befor.dart';
import 'tank14-input/data147after.dart';
import 'tank14-input/data147befor.dart';
import 'tank2-input/data27after.dart';
import 'tank2-input/data27befor.dart';
import 'tank5-input/data57after.dart';
import 'tank5-input/data57befor.dart';
import 'tank8-input/data87after.dart';
import 'tank8-input/data87befor.dart';
import 'tank9-input/data97after.dart';
import 'tank9-input/data97befor.dart';

late BuildContext Page033AutoContext;

class Page033Autobody extends StatelessWidget {
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
        title: Text("Select Tank | 07:00"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
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
                        Tank27BeforePage(),
                        Tank27AfterPage(),
                        context,
                        "http://172.23.10.51:1111/tank2before7",
                        "http://172.23.10.51:1111/tank2after7",
                      ),
                      buildTableRow(
                        "Tank5 (3-5) : Acid picking No.1 (HCI)",
                        Icons.add_chart_outlined,
                        Icons.add_box_outlined,
                        Colors.green,
                        Tank57BeforePage(),
                        Tank57AfterPage(),
                        context,
                        "http://172.23.10.51:1111/tank5before7",
                        "http://172.23.10.51:1111/tank5after7",
                      ),
                      buildTableRow(
                        "Tank8 (3-8) : Surface condition (PL-ZN)",
                        Icons.add_chart_outlined,
                        Icons.add_box_outlined,
                        Colors.blue,
                        Tank87BeforePage(),
                        Tank87AfterPage(),
                        context,
                        "http://172.23.10.51:1111/tank8before7",
                        "http://172.23.10.51:1111/tank8after7",
                      ),
                      buildTableRow(
                        "Tank9 (3-9) : Phosphate (PB-3650X)",
                        Icons.add_chart_outlined,
                        Icons.add_box_outlined,
                        Colors.orange,
                        Tank97BeforePage(),
                        Tank97AfterPage(),
                        context,
                        "http://172.23.10.51:1111/tank9before7",
                        "http://172.23.10.51:1111/tank9after7",
                      ),
                      buildTableRow(
                        "Tank10 (3-10) : Phosphate (PB-181X) ",
                        Icons.add_chart_outlined,
                        Icons.add_box_outlined,
                        Colors.grey,
                        Tank107BeforePage(),
                        Tank107AfterPage(),
                        context,
                        "http://172.23.10.51:1111/tank10before7",
                        "http://172.23.10.51:1111/tank10after7",
                      ),
                      buildTableRow(
                        "Tank13 (3-13) : Lubricant (Lub-4618) ",
                        Icons.add_chart_outlined,
                        Icons.add_box_outlined,
                        Colors.green,
                        Tank137BeforePage(),
                        Tank137AfterPage(),
                        context,
                        "http://172.23.10.51:1111/tank13before7",
                        "http://172.23.10.51:1111/tank13after7",
                      ),
                      buildTableRow(
                        "Tank14 (3-14) : Lubricant (Lub-235T) ",
                        Icons.add_chart_outlined,
                        Icons.add_box_outlined,
                        Colors.blue,
                        Tank147BeforePage(),
                        Tank147AfterPage(),
                        context,
                        "http://172.23.10.51:1111/tank14before7",
                        "http://172.23.10.51:1111/tank14after7",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 168), // Add this line
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error', style: TextStyle(color: Colors.black)),
              content: Text(message, style: TextStyle(color: Colors.black)),
              actions: <Widget>[
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error', style: TextStyle(color: Colors.black)),
            content: Text('Failed to call API',
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
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
          style: TextStyle(color: Colors.black), // Set text color to black
        ),
        SizedBox(width: 5), // Add space between text and icon
        // Icon(Icons.arrow_circle_up, color: Colors.red),
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
        title: Text('System Error', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Text('หน้านี้ยังไม่เปิดใช้งาน',
            style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
