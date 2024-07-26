import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Tank13BodyPage extends StatefulWidget {
  @override
  _Tank13BodyPageState createState() => _Tank13BodyPageState();
}

class _Tank13BodyPageState extends State<Tank13BodyPage> {
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
    fetchDataFromAPI();
  }

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
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Tank13 : Lubricant',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300, // Set the width of the TextField
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: roundFilterController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.filter_list),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              roundFilterController.clear();
                              setState(() {});
                            },
                          ),
                          labelText: 'Filter',
                          hintText: 'Enter detail',
                          filled: true,
                          fillColor: Colors.black12,
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add your export to CSV logic here
                    },
                    child: Text('Export to Excel'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              buildTable2(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTable2() {
    // Filter the table data based on the entered round number
    List<Map<String, dynamic>> filteredData = tableData.where((data) {
      String round = roundFilterController.text.toLowerCase();
      return data['detail'].toString().toLowerCase().contains(round);
    }).toList();

    return Column(
      children: [
        SizedBox(height: 10),
        // Display the filtered table data
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(),
          columnWidths: {
            0: FixedColumnWidth(80.0),
            1: FixedColumnWidth(120.0),
            2: FixedColumnWidth(180.0),
            3: FixedColumnWidth(100.0),
            4: FixedColumnWidth(120.0),
            5: FixedColumnWidth(100.0),
            6: FixedColumnWidth(120.0),
          },
          children: [
            TableRow(
              children: [
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Round",
                          style: TextStyle(color: Colors.black),
                        ))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Data",
                          style: TextStyle(color: Colors.black),
                        ))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Detail",
                          style: TextStyle(color: Colors.black),
                        ))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Value",
                          style: TextStyle(color: Colors.black),
                        ))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Username",
                          style: TextStyle(color: Colors.black),
                        ))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Time",
                          style: TextStyle(color: Colors.black),
                        ))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Date",
                          style: TextStyle(color: Colors.black),
                        ))),
              ],
            ),
            // Map each data entry to a TableRow widget
            ...filteredData.map((data) => buildTableRow2(
                data['round'],
                data['data'],
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

  TableRow buildTableRow2(String? round, String? data, String? detail,
      String? value, String? username, String? time, String? date) {
    // Define date and time format
    final dateFormat = DateFormat('dd-MM-yyyy');
    final timeFormat = DateFormat('HH:mm:ss');

    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              round ?? '',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data ?? '',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              detail ?? '',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value ?? '',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              username ?? '',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              time != null ? timeFormat.format(DateTime.parse(time)) : '',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              date != null ? dateFormat.format(DateTime.parse(date)) : '',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  void fetchDataFromAPI() async {
    final url = 'http://172.23.10.51:1111/Tank13task';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      setState(() {
        tableData = decodedData
            .map((entry) => {
                  'round': entry['round'] ?? '',
                  'data': entry['data'] ?? '',
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
