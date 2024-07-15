import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Tank2BeforePage extends StatefulWidget {
  @override
  _Tank2BeforePageState createState() => _Tank2BeforePageState();
}

class _Tank2BeforePageState extends State<Tank2BeforePage> {
  TextEditingController fAIController = TextEditingController();
  TextEditingController tempController = TextEditingController();
  List<Map<String, dynamic>> tableData = []; // List to store table data

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI(); // Call method to fetch data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tank2 : Degresing | 01:00 (Before)'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildInputFields(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (validateValues()) {
                    // Save values to API
                    saveValuesToAPI(context);
                  } else {
                    // Show popup for Invalid Values',

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Invalid Values',
                              style: TextStyle(color: Colors.black)),
                          content: Text(
                              'กรุณากรอกค่าภายในช่วงที่ระบุ\nF.AI. (Point) ควรอยู่ระหว่าง 30 and 40.\nTemp.(°C) ควรอยู่ระหว่าง 55 and 70.'),
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
                },
                child: Text('Save Values'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: buildTable(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputFields() {
    return Column(
      children: [
        SizedBox(
          width: 200, // Adjust the width as needed
          child: TextFormField(
            controller: fAIController,
            decoration: InputDecoration(labelText: 'F.AI'),
          ),
        ),
        SizedBox(height: 10), // Add some spacing between the text inputs
        SizedBox(
          width: 200, // Adjust the width as needed
          child: TextFormField(
            controller: tempController,
            decoration: InputDecoration(labelText: 'Temp'),
          ),
        ),
      ],
    );
  }

  Widget buildTable() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(),
      columnWidths: {
        0: FixedColumnWidth(120.0),
        1: FixedColumnWidth(80.0),
        2: FixedColumnWidth(120.0),
        3: FixedColumnWidth(100.0),
        4: FixedColumnWidth(120.0),
      },
      children: [
        TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Detail"),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Value"),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Username"),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Time"),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Date"),
              ),
            ),
          ],
        ),
        // Map each data entry to a TableRow widget
        ...tableData.map((data) => buildTableRow(data['detail'], data['value'],
            data['Username'], data['time'], data['date'])),
      ],
    );
  }

  TableRow buildTableRow(String? detail, String? value, String? username,
      String? time, String? date) {
    // Define date and time format
    final dateFormat = DateFormat('dd-MM-yyyy');
    final timeFormat = DateFormat('HH:mm:ss');

    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(detail ?? ''),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value ?? ''),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(username ?? ''),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                time != null ? timeFormat.format(DateTime.parse(time)) : ''),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                date != null ? dateFormat.format(DateTime.parse(date)) : ''),
          ),
        ),
      ],
    );
  }

  void fetchDataFromAPI() async {
    final url = 'http://172.23.10.51:1111/tank2beforedata';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      setState(() {
        tableData = decodedData
            .where((entry) =>
                entry['data'] ==
                'before') // Filter out entries with 'data' not equal to 'before'
            .map((entry) => {
                  'detail': entry['detail'] ?? '',
                  'value': entry['value']?.toString() ?? '',
                  'Username': entry['username'] ?? '',
                  'time': entry['time'] ?? '',
                  'date': entry['date'] ?? '',
                })
            .toList();
      });
    } else {
      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'Failed to fetch data from the API. Status code: ${response.statusCode}'),
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

  bool validateValues() {
    double fAIValue = double.tryParse(fAIController.text) ?? 0.0;
    double tempValue = double.tryParse(tempController.text) ?? 0.0;
    return (fAIValue >= 30 && fAIValue <= 40) &&
        (tempValue >= 55 && tempValue <= 70);
  }

  void saveValuesToAPI(BuildContext context) async {
    final url = 'http://172.23.10.51:1111/t21b';
    final fAIValue = fAIController.text;
    final tempValue = tempController.text;

    print('F.AI Value: $fAIValue');
    print('Temp Value: $tempValue');

    final response = await http.post(
      Uri.parse(url),
      body: {
        'F_AI': fAIValue,
        'Temp': tempValue,
      },
    );

    if (response.statusCode == 200) {
      // Clear text input fields
      fAIController.clear();
      tempController.clear();

      // Show success popup
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success', style: TextStyle(color: Colors.black)),
            content:
                Text('บันทึกค่าสำเร็จ.', style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).popUntil(ModalRoute.withName(
                      '/')); // Navigate back to the home page
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Show error popup
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to save values to the API.'),
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
}
