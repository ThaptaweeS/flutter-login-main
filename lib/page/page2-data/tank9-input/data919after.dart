import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/global.dart';

class Tank919AfterPage extends StatefulWidget {
  @override
  _Tank919AfterPageState createState() => _Tank919AfterPageState();
}

class _Tank919AfterPageState extends State<Tank919AfterPage> {
  late TextEditingController ACController;
  late TextEditingController tempController;
  late TextEditingController TAIController;
  late TextEditingController FAController;
  late TextEditingController ARController;
  late TextEditingController roundFilterController;
  late int roundValue;
  List<Map<String, dynamic>> tableData = [];

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

  // Method to fetch roundValue from the API
  void fetchRoundValue() async {
    try {
      final response = await http
          .post(Uri.parse('http://172.23.10.51:1111/tank9aftercheck19'));
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
        title: Text('Tank9 : Phosphate | 19:00 (After)'),
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
                              'กรุณากรอกค่าภายในช่วงที่ระบุ\nF.A. (Point) ควรอยู่ระหว่าง 4.0 ถึง 4.7.\nTemp.(°C) ควรอยู่ระหว่าง 70 ถึง 80.\nA.C. (Point) ควรอยู่ระหว่าง 1 ถึง 3.\nA.R. (Point) ควรอยู่ระหว่าง 5.5 ถึง 7.5.\nT.A. (Point) ควรอยู่ระหว่าง 26 ถึง 30.'),
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
            buildTableCell("T.A (Point)", TAIController),
            buildTableCell("F.A (Point)", FAController),
          ],
        ),
        TableRow(
          children: [
            buildTableCell("A.C (Point)", ACController),
            buildTableCell("Temp(°C)", tempController),
          ],
        ),
        TableRow(
          children: [
            buildAutoCalculateCell("A.R"),
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
            readOnly: true, // Set readOnly to true
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
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
            onChanged: (_) {
              if (label == "F.A (Point)" || label == "T.A (Point)") {
                // Call the method to update AR value when FA or TA changes
                updateARValue();
              }
            },
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  void updateARValue() {
    // Get values from controllers
    double TAValue = double.tryParse(TAIController.text) ?? 0.0;
    double FAValue = double.tryParse(FAController.text) ?? 0.0;

    // Perform calculation
    double ARValue = TAValue / FAValue;

    // Update AR controller
    ARController.text =
        ARValue.toStringAsFixed(2); // Update AR value with 2 decimal places
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
    double FAValue = double.tryParse(FAController.text) ?? 0.0;
    double tempValue = double.tryParse(tempController.text) ?? 0.0;
    double ACValue = double.tryParse(ACController.text) ?? 0.0;
    double TAIValue = double.tryParse(TAIController.text) ?? 0.0;
    double ARValue = double.tryParse(ARController.text) ?? 0.0;

    return (FAValue >= 4.0 && FAValue <= 4.7) &&
        (tempValue >= 70.0 && tempValue <= 80.0) &&
        (ACValue >= 1 && ACValue <= 3) &&
        (ARValue >= 5.5 && ARValue <= 7.5) &&
        (TAIValue >= 26.0 && TAIValue <= 30.0);
  }

  void saveValuesToAPI(BuildContext context) async {
    final url = 'http://172.23.10.51:1111/t919a';
    final TAIValue = TAIController.text;
    final tempValue = tempController.text;
    final FAValue = FAController.text;
    final ARValue = ARController.text;
    final ACValue = ACController.text;
    final Round = roundValue.toString(); // Convert to string
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
    final url = 'http://172.23.10.51:1111/tank9afterdata19';
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
