import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Tank2AfterPage extends StatefulWidget {
  @override
  _Tank2AfterPageState createState() => _Tank2AfterPageState();
}

class _Tank2AfterPageState extends State<Tank2AfterPage> {
  late TextEditingController fAIController;
  late TextEditingController tempController;
  late int roundValue;
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fAIController = TextEditingController();
    tempController = TextEditingController();
    roundValue = 1; // Set default value for roundValue
    fetchRoundValue(); // Call the method to fetch roundValue from the API
    fetchDataFromAPI();
  }

  // Method to fetch roundValue from the API
  void fetchRoundValue() async {
    try {
      final response = await http
          .post(Uri.parse('http://172.23.10.51:1111/tank2aftercheck'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          // Set roundValue based on the length of the data array
          roundValue =
              data.length + 1; // Increment by 1 to set the default value
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tank2 : Degresing | 01:00 (After)'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildTable(),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (validateValues()) {
                    // Save values to API
                    saveValuesToAPI(context);
                  } else {
                    // Show popup for invalid values
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Invalid Values'),
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
                  child: buildTable2(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTable() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(),
      columnWidths: {
        0: FixedColumnWidth(200.0),
        1: FixedColumnWidth(200.0),
      },
      children: [
        buildTableRow("F.AI ( Point )", fAIController),
        buildTableRow("Temp", tempController),
        buildRoundTableRow(),
      ],
    );
  }

  TableRow buildRoundTableRow() {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Round"),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: DropdownButtonFormField<int>(
                value: roundValue,
                items: List.generate(
                  10,
                  (index) => DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text((index + 1).toString()),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    roundValue = value!;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  TableRow buildTableRow(String label, TextEditingController controller) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter value',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool validateValues() {
    double fAIValue = double.tryParse(fAIController.text) ?? 0.0;
    double tempValue = double.tryParse(tempController.text) ?? 0.0;
    return (fAIValue >= 30 && fAIValue <= 40) &&
        (tempValue >= 55 && tempValue <= 70);
  }

  void saveValuesToAPI(BuildContext context) async {
    final url = 'http://172.23.10.51:1111/t21a';
    final fAIValue = fAIController.text;
    final tempValue = tempController.text;

    final response = await http.post(
      Uri.parse(url),
      body: {
        'F_AI': fAIValue,
        'Temp': tempValue,
        'Range': '01:00',
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

  Widget buildTable2() {
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
        ...tableData.map((data) => buildTableRow2(data['detail'], data['value'],
            data['Username'], data['time'], data['date'])),
      ],
    );
  }

  TableRow buildTableRow2(String? detail, String? value, String? username,
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
    final url = 'http://172.23.10.51:1111/tank2afterdata';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      setState(() {
        tableData = decodedData
            .where((entry) => entry['data'] == 'after')
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
}
