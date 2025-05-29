import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
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
  bool isConChecked = false;
  bool isFeChecked = false;
  List<Map<String, dynamic>> tableData = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ConController = TextEditingController();
    FeController = TextEditingController();
    roundFilterController = TextEditingController();
    roundValue = 1; // Set default value for roundValue
    fetchRoundValue(); // Call the method to fetch roundValue from the API
    fetchDataFromAPI();
    fetchdataValue();
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

  void fetchdataValue() async {
    if (roundValue > 1) {
      // If roundValue is greater than 1, no need to fetch the data or update the fields
      return;
    }
    try {
      final response = await http
          .post(Uri.parse('http://172.23.10.51:1111/tank5fetchdata19'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Debug: print the entire response to check if data is coming through
        print('Data received: $data');

        // Assuming "detail" can differentiate between F_Al and Temp
        String? ConValue;
        String? FeValue;

        for (var entry in data) {
          print(
              'Processing entry: $entry'); // Debug: print each entry for debugging
          if (entry['detail'] == 'Concentraition(%)') {
            // Double check the detail key
            ConValue = entry['value'];
          } else if (entry['detail'] == 'Fe(%)') {
            FeValue = entry['value'];
          }
        }

        // Apply the conditions and set text fields if valid
        setState(() {
          if (roundValue <= 1) {
            // Only set F_Al if it meets the condition
            if (ConValue != null) {
              print(
                  'Con value: $ConValue'); // Debug: print F_Al value for debugging
              if (int.parse(ConValue) >= 10 && int.parse(ConValue) <= 15) {
                ConController.text = ConValue; // Set F_Al value
              } else {
                print(
                    'Con value not in range: $ConValue'); // Debug if value is out of range
                ConController.clear(); // Clear if not meeting the condition
              }
            }

            // Only set Temp if it meets the condition
            if (FeValue != null) {
              print(
                  'Fe value: $FeValue'); // Debug: print Temp value for debugging
              if (int.parse(FeValue) >= 0 && int.parse(FeValue) <= 80) {
                FeController.text = FeValue; // Set Temp value
              } else {
                print(
                    'Fe value not in range: $FeValue'); // Debug if value is out of range
                FeController.clear(); // Clear if not meeting the condition
              }
            }
          } else {
            print('roundValue is greater than 1, skipping field updates.');
          }
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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.indigo[50],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  buildTable(),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        saveValuesToAPI(context);
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('แจ้งเตือน',
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black)),
                              content: Text(
                                  'กรุณากรอกค่าภายในช่วงที่ระบุ\nConcentration (%) ควรอยู่ระหว่าง 10 ถึง 15.\nFe(%) ควรอยู่ระหว่าง 0 ถึง 80.',
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black)),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    if ((isFeChecked &&
                                            FeController.text.isEmpty) &&
                                        (isConChecked &&
                                            ConController.text.isEmpty))
                                      saveValuesToAPI(context);
                                    else {
                                      showValidationDialog(context);
                                    }
                                  },
                                  child: Text('ยืนยัน'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.pink[50]),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('ยกเลิก',
                                      style: GoogleFonts.ramabhadra(
                                          color: Colors.black)),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('Save Values',
                        style: GoogleFonts.ramabhadra(color: Colors.black)),
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
      ),
    );
  }

  void showValidationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ข้อผิดพลาด',
              style: GoogleFonts.ramabhadra(color: Colors.black)),
          content: Text(
            'กรุณากรอกข้อมูลตามช่องที่กำหนด\nหากไม่ต้องการกรอกข้อมูลในช่องใด\nกรุณาทำเครื่องหมาย ✅ ในช่องนั้น',
            style: GoogleFonts.ramabhadra(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ปิด',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
            ),
          ],
        );
      },
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
            buildTableCell("Concentration (%)", ConController,
                "Con ต้องอยู่ระหว่าง 10 ถึง 15", 10, 15, isConChecked, (value) {
              setState(() {
                isConChecked = value ?? false;
              });
            }),
          ],
        ),
        TableRow(
          children: [
            buildTableCell("Fe (%)", FeController,
                "Fe ต้องอยู่ระหว่าง 0 ถึง 80", 0, 80, isFeChecked, (value) {
              setState(() {
                isFeChecked = value ?? false;
              });
            }),
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

  Widget buildTableCell(
      String label,
      TextEditingController controller,
      String rangeMessage,
      double min,
      double max,
      bool isChecked, // เพิ่มตัวแปรสำหรับสถานะของ Checkbox
      Function(bool?) onCheckboxChanged // ฟังก์ชัน callback สำหรับอัปเดตค่า
      ) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: GoogleFonts.ramabhadra(color: Colors.black)),
                Checkbox(
                  value: isChecked,
                  onChanged: onCheckboxChanged, // อัปเดตค่า Checkbox
                ),
              ],
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  errorStyle:
                      GoogleFonts.ramabhadra(fontSize: 11, color: Colors.red),
                ),
                validator: (value) {
                  if (isChecked) {
                    return null;
                  }
                  double? numericValue = double.tryParse(value ?? '');
                  if (numericValue == null ||
                      numericValue < min ||
                      numericValue > max) {
                    return rangeMessage;
                  }
                  return null;
                },
                style: GoogleFonts.ramabhadra(color: Colors.black),
              ),
            ),
          ],
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
              labelStyle: GoogleFonts.ramabhadra(color: Colors.black),
              border: OutlineInputBorder(),
            ),
            items: List.generate(
              10,
              (index) => DropdownMenuItem<int>(
                value: index + 1,
                child: Text(
                  (index + 1).toString(),
                  style: GoogleFonts.ramabhadra(color: Colors.black),
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                roundValue = value!;
              });
            },
            dropdownColor: Colors.white,
            style: GoogleFonts.ramabhadra(color: Colors.black),
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
        (FeValue >= 0.1 && FeValue <= 80.0);
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
        'Range': '19:00',
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
            title: Text('Success',
                style: GoogleFonts.ramabhadra(color: Colors.black)),
            content: Text('บันทึกค่าสำเร็จ.',
                style: GoogleFonts.ramabhadra(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.pink[50]),
                onPressed: () {
                  Navigator.of(context).popUntil(ModalRoute.withName(
                      '/')); // Navigate back to the home page
                },
                child: Text('OK',
                    style: GoogleFonts.ramabhadra(color: Colors.black)),
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
                        child: Text("Round",
                            style:
                                GoogleFonts.ramabhadra(color: Colors.black)))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Detail",
                            style:
                                GoogleFonts.ramabhadra(color: Colors.black)))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Value",
                            style:
                                GoogleFonts.ramabhadra(color: Colors.black)))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Username",
                            style:
                                GoogleFonts.ramabhadra(color: Colors.black)))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Time",
                            style:
                                GoogleFonts.ramabhadra(color: Colors.black)))),
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Date",
                            style:
                                GoogleFonts.ramabhadra(color: Colors.black)))),
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
            child: Text(round ?? '',
                style: GoogleFonts.ramabhadra(color: Colors.black)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(detail ?? '',
                style: GoogleFonts.ramabhadra(color: Colors.black)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value ?? '',
                style: GoogleFonts.ramabhadra(color: Colors.black)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(username ?? '',
                style: GoogleFonts.ramabhadra(color: Colors.black)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                time != null ? timeFormat.format(DateTime.parse(time)) : '',
                style: GoogleFonts.ramabhadra(color: Colors.black)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                date != null ? dateFormat.format(DateTime.parse(date)) : '',
                style: GoogleFonts.ramabhadra(color: Colors.black)),
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
}
