import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/global.dart';

class Tank519AfterPage extends StatefulWidget {
  @override
  _Tank519AfterPageState createState() => _Tank519AfterPageState();
}

class _Tank519AfterPageState extends State<Tank519AfterPage> {
  late TextEditingController ConController;
  late TextEditingController FeController;
  late TextEditingController roundFilterController;
  late int roundValue;
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    ConController = TextEditingController();
    FeController = TextEditingController();
    roundFilterController = TextEditingController();
    roundValue = 1; // Set default value for roundValue
    fetchRoundValue(); // Call the method to fetch roundValue from the API
    fetchDataFromAPI();
  }

  // Method to fetch roundValue from the API
  void fetchRoundValue() async {
    try {
      final response = await http
          .post(Uri.parse('http://172.23.10.51:1111/tank5aftercheck19'));
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
        title: Text('Tank5 : Acid Picking No.1 | 19:00 (after)'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildTable(),
              SizedBox(height: 10),
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
                              'กรุณากรอกค่าภายในช่วงที่ระบุ\nConcentration (%) ควรอยู่ระหว่าง 10 ถึง 15.\nFe(%) ควรอยู่ระหว่าง 0 ถึง 80.'),
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
        TableRow(
          children: [
            buildTableCell("Concentration (%)", ConController),
          ],
        ),
        TableRow(
          children: [
            buildTableCell("Fe (%)", FeController),
          ],
        ),
        TableRow(
          children: [
            buildRoundTableRow(),
          ],
        ),
      ],
    );
  }

  Widget buildTableCell(String label, TextEditingController controller) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 200,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRoundTableRow() {
    return TableCell(
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
    double ConValue = double.tryParse(ConController.text) ?? 0.0;
    double FeValue = double.tryParse(FeController.text) ?? 0.0;


    return (ConValue >= 10.0 && ConValue <= 15.0) &&
        (FeValue >= 0.1 && FeValue <= 80.0) ;
  }

  void saveValuesToAPI(BuildContext context) async {
    final url = 'http://172.23.10.51:1111/t519a';
    final ConValue = ConController.text;
    final FeValue = FeController.text;
    final Round = roundValue.toString(); // Convert to string
    final Name = USERDATA.NAME;

    final response = await http.post(
      Uri.parse(url),
      body: {
        'Con': ConValue,
        'Fe': FeValue,
        'Name': Name,
        'Round': Round,
      },
    );
    if (response.statusCode == 200) {
      // Clear text input fields
      ConController.clear();
      FeController.clear();

      // Show success popup
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('บันทึกค่าสำเร็จ.'),
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
    // Filter the table data based on the entered round number
    List<Map<String, dynamic>> filteredData = tableData.where((data) {
      String round = roundFilterController.text.toLowerCase();
      return data['round'].toString().toLowerCase().contains(round);
    }).toList();

    return Column(
      children: [
        Container(
          width: 620,
          child: TextField(
            controller: roundFilterController,
            decoration: InputDecoration(
              labelText: 'Filter Round',
              hintText: 'Enter round number',
              prefixIcon: Icon(Icons.filter_list),
            ),
            onChanged: (value) {
              setState(() {
                // Update the UI when the filter text changes
              });
            },
          ),
        ),
        // Display the filtered table data
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(),
          columnWidths: {
            0: FixedColumnWidth(80.0),
            1: FixedColumnWidth(160.0),
            2: FixedColumnWidth(80.0),
            3: FixedColumnWidth(120.0),
            4: FixedColumnWidth(100.0),
            5: FixedColumnWidth(120.0),
          },
          children: [
            TableRow(
              children: [
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Round"))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Detail"))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Value"))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Username"))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Time"))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Date"))),
              ],
            ),
            // Map each data entry to a TableRow widget
            ...filteredData.map((data) => buildTableRow2(
                data['round'],
                data['detail'],
                data['value'],
                data['Username'],
                data['time'],
                data['date'])),
          ],
        ),
      ],
    );
  }

  TableRow buildTableRow2(String? round, String? detail, String? value,
      String? username, String? time, String? date) {
    // Define date and time format
    final dateFormat = DateFormat('dd-MM-yyyy');
    final timeFormat = DateFormat('HH:mm:ss');

    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(round ?? ''),
          ),
        ),
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
    final url = 'http://172.23.10.51:1111/tank5afterdata19';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      setState(() {
        tableData = decodedData
            .where((entry) => entry['data'] == 'after')
            .map((entry) => {
                  'round': entry['round'] ?? '',
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
