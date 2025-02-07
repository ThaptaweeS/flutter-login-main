import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:newmaster/page/tank/tank1-data/data_page01.dart';
import 'package:newmaster/responsive.dart';

import '../../../data/global.dart';

class History1 extends StatefulWidget {
  @override
  _History1State createState() => _History1State();
}

class _History1State extends State<History1> {
  List<Map<String, String>> historyData = [
    {'date': '2023-11-08', 'time': '12:50', 'value': '1.24 Litter'},
    {'date': '2023-11-08', 'time': '12:50', 'value': '1.24 Litter'},
    {'date': '2023-11-08', 'time': '12:50', 'value': '1.24 Litter'},
    {'date': '2023-11-08', 'time': '12:50', 'value': '1.24 Litter'},
    {'date': '2023-11-08', 'time': '12:50', 'value': '1.24 Litter'},
    {'date': '2023-11-08', 'time': '12:50', 'value': '1.24 Litter'},
    {'date': '2023-11-08', 'time': '12:50', 'value': '1.24 Litter'},
    {'date': '2023-11-08', 'time': '12:50', 'value': '1.24 Litter'},

    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "TA FEED Data",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        // SizedBox(height: defaultPadding),
        Responsive(
          mobile: Historydata1(
            historyData: historyData,
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: Historydata1(
            historyData: historyData,
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          desktop: Historydata1(
            historyData: historyData,
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            crossAxisCount: _size.width < 800 ? 2 : 4,
          ),
        ),
      ],
    );
  }
}

class History2 extends StatefulWidget {
  @override
  _History2State createState() => _History2State();
}

class _History2State extends State<History2> {
  List<Map<String, String>> historyData = [
    {'date': '2023-11-08', 'time': '08:20', 'value': '1.24 Litter'},
    {'date': '2023-11-08', 'time': '08:50', 'value': '2.62 Litter'},
    {'date': '2023-11-08', 'time': '09:20', 'value': '1.64 Litter'},
    {'date': '2023-11-08', 'time': '10:00', 'value': '1.79 Litter'},
    {'date': '2023-11-08', 'time': '10:50', 'value': '3.11 Litter'},
    {'date': '2023-11-08', 'time': '11:40', 'value': '2.16 Litter'},
    {'date': '2023-11-08', 'time': '12:30', 'value': '2.44 Litter'},
    {'date': '2023-11-08', 'time': '13:50', 'value': '0.79 Litter'},

    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "AC FEED Data",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        // SizedBox(height: defaultPadding),
        Responsive(
          mobile: Historydata2(
            historyData: historyData,
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: Historydata2(
            historyData: historyData,
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          desktop: Historydata2(
            historyData: historyData,
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            crossAxisCount: _size.width < 800 ? 2 : 4,
          ),
        ),
      ],
    );
  }
}

class DataHistory2 extends StatefulWidget {
  @override
  _DataHistory2State createState() => _DataHistory2State();
}

class _DataHistory2State extends State<DataHistory2> {
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
          .post(Uri.parse('http://172.23.10.51:1111/tank2aftercheck'));
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
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTable2(),
        ],
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
              border: OutlineInputBorder(),
            ),
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
    double FAlValue = double.tryParse(FAlController.text) ?? 0.0;
    double tempValue = double.tryParse(tempController.text) ?? 0.0;

    return (FAlValue >= 30.0 && FAlValue <= 40.0) &&
        (tempValue >= 55.0 && tempValue <= 75.0);
  }

  void saveValuesToAPI(BuildContext context) async {
    final url = 'http://172.23.10.51:1111/t21a';
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
        'Range': '01:00',
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
    // Define date format
    final dateFormat = DateFormat('dd-MM-yyyy');

    // Filter the table data based on the entered round number
    List<Map<String, dynamic>> filteredData = tableData.where((data) {
      String round = roundFilterController.text.toLowerCase();
      return data['round'].toString().toLowerCase().contains(round);
    }).toList();

    return SingleChildScrollView(
      child: Column(
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
          // Display the filtered table data with maximum 7 rows
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // Disable scrolling
            itemCount: filteredData.length > 20 ? 20 : filteredData.length,
            itemBuilder: (context, index) {
              return Table(
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
                          child: Text(filteredData[index]['round'] ?? ''),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(filteredData[index]['detail'] ?? ''),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(filteredData[index]['value'] ?? ''),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(filteredData[index]['Username'] ?? ''),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(filteredData[index]['time'] ?? ''),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(filteredData[index]['date'] != null
                              ? dateFormat.format(
                                  DateTime.parse(filteredData[index]['date']))
                              : ''),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
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
            child: Text(time ?? ''),
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
    final url = 'http://172.23.10.51:1111/tank2';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      setState(() {
        tableData = decodedData
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
              'Failed to fetch data from the API. Status code: ${response.statusCode}',
            ),
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
