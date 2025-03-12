import 'dart:convert';
import 'dart:html' as html;

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Tank10BodyPage extends StatefulWidget {
  @override
  _Tank10BodyPageState createState() => _Tank10BodyPageState();
}

class _Tank10BodyPageState extends State<Tank10BodyPage> {
  late TextEditingController taController;
  late TextEditingController faController;
  late TextEditingController arController;
  late TextEditingController acController;
  late TextEditingController tempController;
  late TextEditingController roundFilterController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late int roundValue;
  List<Map<String, dynamic>> tableData = [];
  String? dropdownValue = '';

  @override
  void initState() {
    super.initState();
    taController = TextEditingController();
    faController = TextEditingController();
    arController = TextEditingController();
    acController = TextEditingController();
    tempController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    roundFilterController = TextEditingController();
    roundValue = 1; // Set default value for roundValue
    fetchDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo[50],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Tank10 : Zinc Phosphate(PB-181X)',
                style:
                    GoogleFonts.ramabhadra(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: startDateController,
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          hintText: 'YYYY-MM-DD',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelStyle:
                              GoogleFonts.ramabhadra(color: Colors.black),
                          hintStyle:
                              GoogleFonts.ramabhadra(color: Colors.black),
                        ),
                        style: GoogleFonts.ramabhadra(color: Colors.black),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            startDateController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: endDateController,
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          hintText: 'YYYY-MM-DD',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelStyle:
                              GoogleFonts.ramabhadra(color: Colors.black),
                          hintStyle:
                              GoogleFonts.ramabhadra(color: Colors.black),
                        ),
                        style: GoogleFonts.ramabhadra(color: Colors.black),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            endDateController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          DropdownButtonFormField<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_drop_down),
                            decoration: InputDecoration(
                              labelText: 'Filter',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.0), // Adjust padding here
                              labelStyle:
                                  GoogleFonts.ramabhadra(color: Colors.black),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>[
                              '',
                              'T.A.',
                              'F.A.',
                              'A.R.',
                              'A.C.',
                              'Temp',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black),
                                ),
                              );
                            }).toList(),
                            dropdownColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: fetchDataFromAPI,
                    icon: Icon(Icons.search, color: Colors.black),
                    label: Text('Search',
                        style: GoogleFonts.ramabhadra(color: Colors.black)),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      exportToExcel();
                    },
                    icon: Icon(Icons.save, color: Colors.black),
                    label: Text('Export to Excel',
                        style: GoogleFonts.ramabhadra(color: Colors.black)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                // child: SingleChildScrollView(
                child: buildTable2(),
                // ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTable2() {
    // Filter the table data based on the selected dropdown value
    List<Map<String, dynamic>> filteredData = tableData.where((data) {
      if (dropdownValue == null || dropdownValue!.isEmpty) {
        return true; // No filter applied, return all data
      }
      return data['detail'].toString().toLowerCase() ==
          dropdownValue!.toLowerCase();
    }).toList();

    // Fixed header row
    Widget header = Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(),
      columnWidths: const {
        0: FixedColumnWidth(80.0), // Round
        1: FixedColumnWidth(120.0), // Data
        2: FixedColumnWidth(180.0), // Detail
        3: FixedColumnWidth(100.0), // Value
        4: FixedColumnWidth(120.0), // Username
        5: FixedColumnWidth(100.0), // Time
        6: FixedColumnWidth(120.0), // Date
      },
      children: [
        TableRow(
          children: [
            TableCell(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.indigo[100], // สีพื้นหลังเต็ม
                ),
                alignment: Alignment.center, // Center align text
                child: Text(
                  "Round",
                  style: GoogleFonts.ramabhadra(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.indigo[100], // สีพื้นหลังเต็ม
                ),
                alignment: Alignment.center, // Center align text
                child: Text(
                  "Data",
                  style: GoogleFonts.ramabhadra(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.indigo[100], // สีพื้นหลังเต็ม
                ),
                alignment: Alignment.center, // Center align text
                child: Text(
                  "Detail",
                  style: GoogleFonts.ramabhadra(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.indigo[100], // สีพื้นหลังเต็ม
                ),
                alignment: Alignment.center, // Center align text
                child: Text(
                  "Value",
                  style: GoogleFonts.ramabhadra(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.indigo[100], // สีพื้นหลังเต็ม
                ),
                alignment: Alignment.center, // Center align text
                child: Text(
                  "Username",
                  style: GoogleFonts.ramabhadra(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.indigo[100], // สีพื้นหลังเต็ม
                ),
                alignment: Alignment.center, // Center align text
                child: Text(
                  "Time",
                  style: GoogleFonts.ramabhadra(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.indigo[100], // สีพื้นหลังเต็ม
                ),
                alignment: Alignment.center, // Center align text
                child: Text(
                  "Date",
                  style: GoogleFonts.ramabhadra(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    // Scrollable rows
    Widget scrollableRows = Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical, // Vertical scrolling
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Horizontal scrolling
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(),
            columnWidths: {
              0: FixedColumnWidth(80.0), // Round
              1: FixedColumnWidth(120.0), // Data
              2: FixedColumnWidth(180.0), // Detail
              3: FixedColumnWidth(100.0), // Value
              4: FixedColumnWidth(120.0), // Username
              5: FixedColumnWidth(100.0), // Time
              6: FixedColumnWidth(120.0), // Date
            },
            children: filteredData.map((data) {
              return buildTableRow2(
                data['round'],
                data['data'],
                data['detail'],
                data['value'],
                data['Username'],
                data['time'],
                data['date'],
              );
            }).toList(),
          ),
        ),
      ),
    );

    return Column(
      children: [
        header, // Fixed header
        scrollableRows, // Scrollable content
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

  Widget buildButton(String label, IconData icon, Function() onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }

  Widget buildTable() {
    // Filter the table data based on the entered round number
    List<Map<String, dynamic>> filteredData = tableData.where((data) {
      String round = roundFilterController.text.toLowerCase();
      return data['detail'].toString().toLowerCase().contains(round);
    }).toList();

    return Table(
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
        buildTableHeader(),
        ...filteredData.map((data) => buildTableRow(
            data['round'],
            data['data'],
            data['detail'],
            data['value'],
            data['Username'],
            data['time'],
            data['date'])),
      ],
    );
  }

  TableRow buildTableHeader() {
    return TableRow(
      children: [
        buildTableCell("Round", isHeader: true),
        buildTableCell("Data", isHeader: true),
        buildTableCell("Detail", isHeader: true),
        buildTableCell("Value", isHeader: true),
        buildTableCell("Username", isHeader: true),
        buildTableCell("Time", isHeader: true),
        buildTableCell("Date", isHeader: true),
      ],
    );
  }

  TableRow buildTableRow(String? round, String? data, String? detail,
      String? value, String? username, String? time, String? date) {
    final timeFormat = DateFormat('HH:mm:ss');
    final dateFormat = DateFormat('dd-MM-yyyy');

    return TableRow(
      children: [
        buildTableCell(round),
        buildTableCell(data),
        buildTableCell(detail),
        buildTableCell(value),
        buildTableCell(username),
        buildTableCell(
            time != null ? timeFormat.format(DateTime.parse(time)) : ''),
        buildTableCell(
            date != null ? dateFormat.format(DateTime.parse(date)) : ''),
      ],
    );
  }

  Widget buildTableCell(String? text, {bool isHeader = false}) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text ?? '',
          style: GoogleFonts.ramabhadra(
              color: Colors.black,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }

  void fetchDataFromAPI() async {
    final url = 'http://127.0.0.1:1882/tank10task';
    String startDate = startDateController.text;
    String endDate = endDateController.text;

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
          <String, String>{'startDate': startDate, 'endDate': endDate}),
    );

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
      showErrorDialog(
          'Failed to fetch data from the API. Status code: ${response.statusCode}');
    }
  }

  void exportToExcel() async {
    try {
      var excel = Excel.createExcel();
      Sheet sheet1 = excel['Sheet1'];

      sheet1.appendRow(["Tank10 : Zinc Phosphate(PB-181X)"]);
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      sheet1.appendRow(["Date: $formattedDate"]);
      sheet1.appendRow(
          ["Round", "Data", "Detail", "Value", "Username", "Time", "Date"]);

      for (var data in tableData) {
        final dateTime = DateTime.parse(data['time']);
        final formattedTime = DateFormat('HH:mm:ss').format(dateTime);
        final formattedDate =
            DateFormat('dd-MM-yyyy').format(DateTime.parse(data['date']));

        sheet1.appendRow([
          data['round'],
          data['data'],
          data['detail'],
          data['value'],
          data['Username'],
          formattedTime,
          formattedDate,
        ]);
      }

      var fileBytes = excel.encode();
      final blob = html.Blob([fileBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "Tank10_$formattedDate.xlsx")
        ..click();
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print('Error exporting Excel: $e');
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.pink[50]),
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
