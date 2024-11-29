import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../data/global.dart';

class Tank213BeforePage extends StatefulWidget {
  @override
  _Tank213BeforePageState createState() => _Tank213BeforePageState();
}

class _Tank213BeforePageState extends State<Tank213BeforePage> {
  late TextEditingController FAlController;
  late TextEditingController tempController;
  late TextEditingController roundFilterController;
  late int roundValue;
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    FAlController = TextEditingController();
    tempController = TextEditingController();
    roundFilterController = TextEditingController();
    roundValue = 1; // Set default value for roundValue
    fetchRoundValue(); // Call the method to fetch roundValue from the API
    fetchDataFromAPI();
  }

  // Method to fetch roundValue from the API
  void fetchRoundValue() async {
    try {
      final response = await http
          .post(Uri.parse('http://172.23.10.51:1111/tank2beforecheck13'));
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
        title: Text('Tank2 : Degreasing | 13:00 (Before)'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildTable(),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    sendDataToAPI(context);
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
            buildTableCell("F.Al (Point)", FAlController),
          ],
        ),
        TableRow(
          children: [
            buildTableCell("Temp(°C)", tempController),
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
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.black),
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
            decoration: InputDecoration(
              labelText: 'Round',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
            items: List.generate(
              10,
              (index) => DropdownMenuItem<int>(
                value: index + 1,
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                roundValue = value!;
              });
            },
            dropdownColor:
                Colors.white, // Set dropdown background color to white
            style: TextStyle(
                color: Colors.black), // Set selected item text color to black
          ),
        ),
      ),
    );
  }

  bool validateValues() {
    double FAlValue = double.tryParse(FAlController.text) ?? 0.0;
    double tempValue = double.tryParse(tempController.text) ?? 0.0;

    return (FAlValue >= 30.0 && FAlValue <= 40.0) &&
        (tempValue >= 55.0 && tempValue <= 75.0);
  }

  void sendDataToAPI(BuildContext context) async {
    final url = 'http://172.23.10.51:1111/t213b';
    final FAlValue = FAlController.text;
    final tempValue = tempController.text;
    final Round = roundValue.toString(); // Convert to string
    final Name = USERDATA.NAME;

    final response = await http.post(
      Uri.parse(url),
      body: {
        'F_Al': FAlValue,
        'Temp': tempValue,
        'Name': Name,
        'Round': Round,
        'Range': '13:00',
      },
    );
    if (response.statusCode == 200) {
      // Clear text input fields
      FAlController.clear();
      tempController.clear();

      // Show success popup
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Success',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(
              'บันทึกค่าสำเร็จ',
              style: TextStyle(color: Colors.black),
            ),
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
            title: Text(
              'Error',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(
              'Failed to save values to the API.',
              style: TextStyle(color: Colors.black),
            ),
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
      return data['detail'].toString().toLowerCase().contains(round);
    }).toList();

    return Column(
      children: [
        Container(
          width: 620,
          child: TextField(
            controller: roundFilterController,
            decoration: InputDecoration(
              labelText: 'Filter',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Enter Detail',
              hintStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(Icons.filter_list, color: Colors.black),
            ),
            style: TextStyle(color: Colors.black),
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
            1: FixedColumnWidth(120.0),
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
                        child: Text("Round",
                            style: TextStyle(color: Colors.black)))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Detail",
                            style: TextStyle(color: Colors.black)))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Value",
                            style: TextStyle(color: Colors.black)))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Username",
                            style: TextStyle(color: Colors.black)))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Time",
                            style: TextStyle(color: Colors.black)))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Date",
                            style: TextStyle(color: Colors.black)))),
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
            child: Text(round ?? '', style: TextStyle(color: Colors.black)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(detail ?? '', style: TextStyle(color: Colors.black)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value ?? '', style: TextStyle(color: Colors.black)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(username ?? '', style: TextStyle(color: Colors.black)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                time != null ? timeFormat.format(DateTime.parse(time)) : '',
                style: TextStyle(color: Colors.black)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                date != null ? dateFormat.format(DateTime.parse(date)) : '',
                style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    );
  }

  void fetchDataFromAPI() async {
    final url = 'http://172.23.10.51:1111/tank2beforedata13';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      setState(() {
        tableData = decodedData
            .where((entry) => entry['data'] == 'before')
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
            title: Text(
              'Error',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(
              'Failed to fetch data from the API. Status code: ${response.statusCode}',
              style: TextStyle(color: Colors.black),
            ),
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
