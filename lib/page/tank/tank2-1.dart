import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Tank2BodyPage extends StatefulWidget {
  @override
  _Tank2BodyPageState createState() => _Tank2BodyPageState();
}

class _Tank2BodyPageState extends State<Tank2BodyPage> {
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Tank2 : Degreasing',
              style: GoogleFonts.ramabhadra(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the children
              children: [
                Container(
                  width: 300, // Set the width of the TextField
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: roundFilterController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.filter_list),
                        suffixIcon: Icon(Icons.clear),
                        labelText: 'Filter',
                        hintText: 'Enter detail',
                        filled: true,
                        fillColor: Colors.black12,
                      ),
                      onChanged: (value) {
                        setState(() {
                          // Update the UI when the filter text changes
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(50, 60),
                  ),
                  onPressed: () {
                    exportToCsv();
                  },
                  child: Text('Export to Excel'),
                ),
              ],
            ),
            SizedBox(height: 10),
            buildTable2(), // Your table widget
            SizedBox(height: 168),
          ],
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
                          style: GoogleFonts.ramabhadra(color: Colors.black),
                        ))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Data",
                          style: GoogleFonts.ramabhadra(color: Colors.black),
                        ))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Detail",
                          style: GoogleFonts.ramabhadra(color: Colors.black),
                        ))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Value",
                          style: GoogleFonts.ramabhadra(color: Colors.black),
                        ))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Username",
                          style: GoogleFonts.ramabhadra(color: Colors.black),
                        ))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Time",
                          style: GoogleFonts.ramabhadra(color: Colors.black),
                        ))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Date",
                          style: GoogleFonts.ramabhadra(color: Colors.black),
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
              style: GoogleFonts.ramabhadra(color: Colors.black),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data ?? '',
              style: GoogleFonts.ramabhadra(color: Colors.black),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              detail ?? '',
              style: GoogleFonts.ramabhadra(color: Colors.black),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value ?? '',
              style: GoogleFonts.ramabhadra(color: Colors.black),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              username ?? '',
              style: GoogleFonts.ramabhadra(color: Colors.black),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              time != null ? timeFormat.format(DateTime.parse(time)) : '',
              style: GoogleFonts.ramabhadra(color: Colors.black),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              date != null ? dateFormat.format(DateTime.parse(date)) : '',
              style: GoogleFonts.ramabhadra(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  void fetchDataFromAPI() async {
    final url = 'http://127.0.0.1:1882/tank2task';
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

  void exportToCsv() async {
    try {
      final String csv = tableData.map((data) {
        return '${data['round']},${data['data']},${data['detail']},${data['value']},${data['Username']},${data['time']},${data['date']}';
      }).join('\n');

      final Directory directory = await getTemporaryDirectory();
      final String path = '${directory.path}/data.csv';
      final File file = File(path);
      await file.writeAsString(csv);

      // Open the file using the default CSV viewer on the device
      await Process.run('open', [file.path]);
    } catch (e) {
      print('Error exporting CSV: $e');
    }
  }
}
