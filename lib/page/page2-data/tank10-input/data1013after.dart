import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../data/global.dart';

class Tank1013AfterPage extends StatefulWidget {
  @override
  _Tank1013AfterPageState createState() => _Tank1013AfterPageState();
}

class _Tank1013AfterPageState extends State<Tank1013AfterPage> {
  late TextEditingController ACController;
  late TextEditingController tempController;
  late TextEditingController TAIController;
  late TextEditingController FAController;
  late TextEditingController ARController;
  late TextEditingController roundFilterController;
  late int roundValue;
  List<Map<String, dynamic>> tableData = [];
  bool isTAChecked = false;
  bool isFAlChecked = false;
  bool isACChecked = false;
  bool isTempChecked = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ACController = TextEditingController();
    tempController = TextEditingController();
    TAIController = TextEditingController();
    FAController = TextEditingController();
    ARController = TextEditingController();
    roundFilterController = TextEditingController();
    roundValue = 1; // Set default value for roundValue
    fetchRoundValue(); // Call the method to fetch roundValue from the API
    fetchDataFromAPI();
  }

  void fetchRoundValue() async {
    try {
      final response = await http
          .post(Uri.parse('http://127.0.0.1:1882/tank10aftercheck13'));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tank10 : Phosphate | 13:00 (After)',
            style: GoogleFonts.ramabhadra(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        // backgroundColor: Colors.white,
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
                                  'กรุณากรอกค่าภายในช่วงที่ระบุ \nT.A. (Point) ควรอยู่ระหว่าง 30.0 และ 36.0 \nF.A. (Point) ควรอยู่ระหว่าง 4.8 และ 6.5\nA.C. (Point) ควรอยู่ระหว่าง 1 และ 3\nTemp.(°C) ควรอยู่ระหว่าง 70 และ 80.',
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black)),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    if ((isTAChecked &&
                                            TAIController.text.isEmpty) &&
                                        (isFAlChecked &&
                                            FAController.text.isEmpty) &&
                                        (isACChecked &&
                                            ACController.text.isEmpty) &&
                                        (isTempChecked &&
                                            tempController.text.isEmpty))
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
            buildTableCell("T.A (Point)", TAIController,
                'T.A. ต้องอยู่ระหว่าง 30 ถึง 36', 30, 36, isTAChecked, (value) {
              setState(() {
                isTAChecked = value ?? false;
              });
            }),
            buildTableCell(
                "F.A. (Point)",
                FAController,
                'F.A. ต้องอยู่ระหว่าง 4.8 ถึง 6.5',
                4.8,
                6.5,
                isFAlChecked, (value) {
              setState(() {
                isFAlChecked = value ?? false;
              });
            }),
          ],
        ),
        TableRow(
          children: [
            buildTableCell("A.C. (Point)", ACController,
                'A.C. ต้องอยู่ระหว่าง 1 ถึง 3', 1, 3, isACChecked, (value) {
              setState(() {
                isACChecked = value ?? false;
              });
            }),
            buildTableCell(
                "Temp(°C)",
                tempController,
                'Temp. ต้องอยู่ระหว่าง 70 ถึง 80',
                70,
                80,
                isTempChecked, (value) {
              setState(() {
                isTempChecked = value ?? false;
              });
            }),
          ],
        ),
        TableRow(
          children: [
            buildAutoCalculateCell("A.R."),
            buildRoundTableRow(),
          ],
        ),
      ],
    );
  }

  Widget buildAutoCalculateCell(String label) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 200,
          child: TextFormField(
            controller: ARController,
            keyboardType: TextInputType.number,
            readOnly: true,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.ramabhadra(color: Colors.black),
              border: OutlineInputBorder(),
            ),
            style: GoogleFonts.ramabhadra(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget buildTableCell(
      String label,
      TextEditingController controller,
      String rangeMessage,
      double min,
      double max,
      bool isChecked,
      Function(bool?) onCheckboxChanged) {
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
                  onChanged: onCheckboxChanged,
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
                onChanged: (value) {
                  if (label == "F.A. (Point)" || label == "T.A. (Point)") {
                    updateARValue(); // อัปเดตค่า AR เมื่อค่าถูกเปลี่ยนใน TextFormField
                  }
                },
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

  void updateARValue() {
    double TAValue = double.tryParse(TAIController.text) ?? 0.0;
    double FAValue = double.tryParse(FAController.text) ?? 0.0;
    double ARValue = TAValue / FAValue;
    ARController.text = ARValue.toStringAsFixed(2);
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
            dropdownColor:
                Colors.white, // Set dropdown background color to white
            style: GoogleFonts.ramabhadra(
                color: Colors.black), // Set selected item text color to black
            decoration: InputDecoration(
              labelText: 'Round',
              labelStyle: GoogleFonts.ramabhadra(color: Colors.black),
              border: OutlineInputBorder(),
            ),
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
            child:
                Text(label, style: GoogleFonts.ramabhadra(color: Colors.black)),
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
                  hintStyle: GoogleFonts.ramabhadra(color: Colors.black),
                ),
                style: GoogleFonts.ramabhadra(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool validateValues() {
    double FAValue = double.tryParse(FAController.text) ?? 0.0;
    double tempValue = double.tryParse(tempController.text) ?? 0.0;
    double ACValue = double.tryParse(ACController.text) ?? 0.0;
    double TAIValue = double.tryParse(TAIController.text) ?? 0.0;
    double ARValue = double.tryParse(ARController.text) ?? 0.0;

    return (FAValue >= 4.8 && FAValue <= 6.5) &&
        (tempValue >= 70.0 && tempValue <= 80.0) &&
        (ACValue >= 1 && ACValue <= 3) &&
        (ARValue >= 5.5 && ARValue <= 7.5) &&
        (TAIValue >= 30.0 && TAIValue <= 36.0);
  }

  void saveValuesToAPI(BuildContext context) async {
    final url = 'http://127.0.0.1:1882/t1013a';
    final TAIValue = TAIController.text;
    final tempValue = tempController.text;
    final FAValue = FAController.text;
    final ARValue = ARController.text;
    final ACValue = ACController.text;
    final Round = roundValue.toString();
    final Name = USERDATA.NAME;

    final response = await http.post(
      Uri.parse(url),
      body: {
        'T_AI': TAIValue,
        'Temp': tempValue,
        'FA': FAValue,
        'AR': ARValue,
        'AC': ACValue,
        'Name': Name,
        'Range': '01:00',
        'Round': Round,
      },
    );
    if (response.statusCode == 200) {
      // Clear text input fields
      TAIController.clear();
      tempController.clear();
      FAController.clear();
      ARController.clear();
      ACController.clear();

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
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
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
            title: Text('Error',
                style: GoogleFonts.ramabhadra(color: Colors.black)),
            content: Text('Failed to save values to the API.',
                style: GoogleFonts.ramabhadra(color: Colors.black)),
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
    final url = 'http://127.0.0.1:1882/tank10afterdata13';
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
