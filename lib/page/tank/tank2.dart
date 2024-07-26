import 'dart:convert';
import 'dart:html' as html;

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Tank2BodyPage extends StatefulWidget {
  @override
  _Tank2BodyPageState createState() => _Tank2BodyPageState();
}

class _Tank2BodyPageState extends State<Tank2BodyPage> {
  late TextEditingController ConController;
  late TextEditingController FeController;
  late TextEditingController roundFilterController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late int roundValue;
  List<Map<String, dynamic>> tableData = [];

  String? dropdownValue = '';

  @override
  void initState() {
    super.initState();
    ConController = TextEditingController();
    FeController = TextEditingController();
    roundFilterController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    roundValue = 1; // Set default value for roundValue
    fetchDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chemical Control Monitoring'),
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
                Text(
                  'Tank2 : Degreasing',
                  style: TextStyle(fontSize: 20, color: Colors.black),
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
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          style: TextStyle(color: Colors.black),
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
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          style: TextStyle(color: Colors.black),
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
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                '',
                                'F.Al',
                                'Temp'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
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
                      onPressed: () {
                        fetchDataFromAPI();
                      },
                      icon: Icon(Icons.search),
                      label: Text('Search'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        exportToExcel();
                      },
                      icon: Icon(Icons.save),
                      label: Text('Export to Excel'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: buildTable2(),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
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
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Data",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Detail",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Value",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Username",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Time",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Date",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
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
    final url = 'http://172.23.10.51:1111/tank2task';
    String startDate = startDateController.text;
    String endDate = endDateController.text;

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'startDate': startDate,
        'endDate': endDate,
      }),
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

  void exportToExcel() async {
    try {
      // สร้างไฟล์ Excel
      var excel = Excel.createExcel();
      Sheet sheet1 = excel['Sheet1'];
      Sheet sheet2 = excel['Sheet2']; // สร้าง Sheet ใหม่

      // เพิ่มข้อมูลใน Sheet1
      sheet1.appendRow(["Tank2 : Degreasing (FC-4360)"]);
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      sheet1.appendRow(["Date: $formattedDate"]); // เพิ่มแถวสำหรับวันที่
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

      // เพิ่มข้อมูลใน Sheet2
      sheet2.appendRow(["Example Data in Sheet2"]);
      sheet2.appendRow(["Row 1", "Data 1", "Data 2"]);
      sheet2.appendRow(["Row 2", "Data 3", "Data 4"]);

      // เข้ารหัสไฟล์ Excel เป็นไบต์
      var fileBytes = excel.encode();

      // สร้าง Blob และใช้ JavaScript สำหรับการดาวน์โหลดไฟล์
      final blob = html.Blob([fileBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute(
            "download", "Tank2_$formattedDate.xlsx") // เพิ่มวันที่ในชื่อไฟล์
        ..click();
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print('Error exporting Excel: $e');
    }
  }
}
