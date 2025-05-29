import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../data/global.dart';

class Tank813AfterPage extends StatefulWidget {
  @override
  _Tank813AfterPageState createState() => _Tank813AfterPageState();
}

class _Tank813AfterPageState extends State<Tank813AfterPage> {
  late TextEditingController TAIController;
  late TextEditingController pHController;
  late TextEditingController roundFilterController;
  late int roundValue;
  List<Map<String, dynamic>> tableData = [];
  bool isTAlChecked = false;
  bool ispHChecked = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    TAIController = TextEditingController();
    pHController = TextEditingController();
    roundFilterController = TextEditingController();
    roundValue = 1; // Set default value for roundValue
    fetchRoundValue(); // Call the method to fetch roundValue from the API
    fetchDataFromAPI();
    fetchdataValue();
  }

  void fetchRoundValue() async {
    try {
      final response = await http
          .post(Uri.parse('http://172.23.10.51:1111/tank8aftercheck13'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          roundValue = data.length + 1;
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
          .post(Uri.parse('http://172.23.10.51:1111/tank8fetchdata13'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Debug: print the entire response to check if data is coming through
        print('Data received: $data');

        // Assuming "detail" can differentiate between F_Al and Temp
        String? TAIValue;
        String? pHValue;

        for (var entry in data) {
          print(
              'Processing entry: $entry'); // Debug: print each entry for debugging
          if (entry['detail'] == 'T.Al.') {
            // Double check the detail key
            TAIValue = entry['value'];
          } else if (entry['detail'] == 'pH') {
            pHValue = entry['value'];
          }
        }

        // Apply the conditions and set text fields if valid, only when roundValue <= 1
        setState(() {
          if (roundValue <= 1) {
            // Only set F_Al if it meets the condition
            if (TAIValue != null) {
              print(
                  'T_Al value: $TAIValue'); // Debug: print F_Al value for debugging
              if (int.parse(TAIValue) >= 2 && int.parse(TAIValue) <= 8) {
                TAIController.text = TAIValue; // Set F_Al value
              } else {
                print(
                    'T_Al value not in range: $TAIValue'); // Debug if value is out of range
                TAIController.clear(); // Clear if not meeting the condition
              }
            }

            // Only set Temp if it meets the condition
            if (pHValue != null) {
              print(
                  'pH value: $pHValue'); // Debug: print Temp value for debugging
              if (int.parse(pHValue) >= 8.5 && int.parse(pHValue) <= 9.5) {
                pHController.text = pHValue; // Set Temp value
              } else {
                print(
                    'Temp value not in range: $pHValue'); // Debug if value is out of range
                pHController.clear(); // Clear if not meeting the condition
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
        title: Text('Tank8 : Surface Condition | 13:00 (after)'),
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
                                'กรุณากรอกค่าภายในช่วงที่ระบุ\nT.Al.(Point) ควรอยู่ระหว่าง 2 ถึง 8\npH ควรอยู่ระหว่าง 8.5 ถึง 9.5',
                                style:
                                    GoogleFonts.ramabhadra(color: Colors.black),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    if ((isTAlChecked &&
                                            TAIController.text.isEmpty) &&
                                        (ispHChecked &&
                                            pHController.text.isEmpty))
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
            buildTableCell(
              "T.Al.(Point)",
              TAIController,
              "T.Al. ต้องอยู่ระหว่าง 2 ถึง 8",
              2.0,
              8.0,
              isTAlChecked,
              (value) {
                setState(
                  () {
                    isTAlChecked = value ?? false;
                  },
                );
              },
            )
          ],
        ),
        TableRow(
          children: [
            buildTableCell("pH", pHController, "pH ต้องอยู่ระหว่าง 8.5 ถึง 9.5",
                8.5, 9.5, ispHChecked, (value) {
              setState(
                () {
                  ispHChecked = value ?? false;
                },
              );
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
      bool isChecked,
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
            dropdownColor:
                Colors.white, // Set dropdown background color to white
            style: GoogleFonts.ramabhadra(
                color: Colors.black), // Set selected item text color to black
          ),
        ),
      ),
    );
  }

  bool validateValues() {
    double TAIValue = double.tryParse(TAIController.text) ?? 0.0;
    double pHValue = double.tryParse(pHController.text) ?? 0.0;

    return (TAIValue >= 2.0 && TAIValue <= 8.0) &&
        (pHValue >= 8.5 && pHValue <= 9.5);
  }

  void saveValuesToAPI(BuildContext context) async {
    final url = 'http://172.23.10.51:1111/t813a';
    final TAIValue = TAIController.text;
    final pHValue = pHController.text;
    final Round = roundValue.toString(); // Convert to string
    final Name = USERDATA.NAME;

    final response = await http.post(
      Uri.parse(url),
      body: {
        'TAI': TAIValue,
        'pH': pHValue,
        'Name': Name,
        'Round': Round,
        'Range': '01:00',
      },
    );
    if (response.statusCode == 200) {
      // Clear text input fields
      TAIController.clear();
      pHController.clear();

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

  void showInvalidValuesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('แจ้งเตือน',
              style: GoogleFonts.ramabhadra(color: Colors.black)),
          content: Text(
            'กรุณากรอกค่าภายในช่วงที่ระบุ\nT.AI.(Point) ควรอยู่ระหว่าง 2 ถึง 8\npH ควรอยู่ระหว่าง 8.5 ถึง 9.5',
            style: GoogleFonts.ramabhadra(color: Colors.black),
          ),
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

  Widget buildTable2() {
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
              labelStyle: GoogleFonts.ramabhadra(color: Colors.black),
              hintText: 'Enter round number',
              hintStyle: GoogleFonts.ramabhadra(color: Colors.black),
              prefixIcon: Icon(Icons.filter_list, color: Colors.black),
            ),
            style: GoogleFonts.ramabhadra(color: Colors.black),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
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
                buildHeaderCell("Round"),
                buildHeaderCell("Detail"),
                buildHeaderCell("Value"),
                buildHeaderCell("Username"),
                buildHeaderCell("Time"),
                buildHeaderCell("Date"),
              ],
            ),
            ...filteredData.map((data) => buildDataRow(
                  data['round'],
                  data['detail'],
                  data['value'],
                  data['Username'],
                  data['time'],
                  data['date'],
                )),
          ],
        ),
      ],
    );
  }

  TableCell buildHeaderCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, style: GoogleFonts.ramabhadra(color: Colors.black)),
      ),
    );
  }

  TableRow buildDataRow(String? round, String? detail, String? value,
      String? username, String? time, String? date) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    final timeFormat = DateFormat('HH:mm:ss');

    return TableRow(
      children: [
        buildDataCell(round),
        buildDataCell(detail),
        buildDataCell(value),
        buildDataCell(username),
        buildDataCell(
            time != null ? timeFormat.format(DateTime.parse(time)) : ''),
        buildDataCell(
            date != null ? dateFormat.format(DateTime.parse(date)) : ''),
      ],
    );
  }

  TableCell buildDataCell(String? text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text ?? '',
            style: GoogleFonts.ramabhadra(color: Colors.black)),
      ),
    );
  }

  void fetchDataFromAPI() async {
    final url = 'http://172.23.10.51:1111/tank8afterdata13';
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
