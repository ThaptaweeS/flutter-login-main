import 'dart:convert';

import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    TAIController.dispose();
    pHController.dispose();
    roundFilterController.dispose();
    super.dispose();
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
                buildInputTable(),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (validateValues()) {
                      saveValuesToAPI(context);
                    } else {
                      showInvalidValuesDialog(context);
                    }
                  },
                  child: Text('Save Values'),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: buildDataTable(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputTable() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(),
      columnWidths: {
        0: FixedColumnWidth(200.0),
        1: FixedColumnWidth(200.0),
      },
      children: [
        buildInputTableRow("T.AI.(Point)", TAIController),
        buildInputTableRow("pH", pHController),
        buildRoundTableRow(),
      ],
    );
  }

  TableRow buildInputTableRow(String label, TextEditingController controller) {
    return TableRow(
      children: [
        Padding(
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
      ],
    );
  }

  TableRow buildRoundTableRow() {
    return TableRow(
      children: [
        Padding(
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
                      )),
              onChanged: (value) {
                setState(() {
                  roundValue = value!;
                });
              },
              dropdownColor: Colors.white,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
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
    final round = roundValue.toString();
    final name = USERDATA.NAME;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'TAI': TAIValue,
          'pH': pHValue,
          'Name': name,
          'Round': round,
        },
      );

      if (response.statusCode == 200) {
        TAIController.clear();
        pHController.clear();
        showSuccessDialog(context);
      } else {
        showErrorDialog(context, 'Failed to save values to the API.');
      }
    } catch (error) {
      showErrorDialog(context, 'Error: $error');
    }
  }

  void showInvalidValuesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Values', style: TextStyle(color: Colors.black)),
          content: Text(
            'กรุณากรอกค่าภายในช่วงที่ระบุ\nT.AI.(Point) ควรอยู่ระหว่าง 2 ถึง 8\npH ควรอยู่ระหว่าง 8.5 ถึง 9.5',
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

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success', style: TextStyle(color: Colors.black)),
          content:
              Text('บันทึกค่าสำเร็จ', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil(ModalRoute.withName('/'));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error', style: TextStyle(color: Colors.black)),
          content: Text(message, style: TextStyle(color: Colors.black)),
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

  Widget buildDataTable() {
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
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Enter round number',
              hintStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(Icons.filter_list, color: Colors.black),
            ),
            style: TextStyle(color: Colors.black),
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
        child: Text(text, style: TextStyle(color: Colors.black)),
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
        child: Text(text ?? '', style: TextStyle(color: Colors.black)),
      ),
    );
  }

  void fetchDataFromAPI() async {
    final url = 'http://172.23.10.51:1111/tank8afterdata13';
    try {
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
        showErrorDialog(context,
            'Failed to fetch data from the API. Status code: ${response.statusCode}');
      }
    } catch (error) {
      showErrorDialog(context, 'Error: $error');
    }
  }
}
