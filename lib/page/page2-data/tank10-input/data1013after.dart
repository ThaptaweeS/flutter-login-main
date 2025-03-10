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

  @override
  void dispose() {
    ACController.dispose();
    tempController.dispose();
    TAIController.dispose();
    FAController.dispose();
    ARController.dispose();
    roundFilterController.dispose();
    super.dispose();
  }

  void fetchRoundValue() async {
    try {
      final response = await http
          .post(Uri.parse('http://172.23.10.51:1111/tank10aftercheck13'));
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
            child: Column(
              children: [
                buildTable(),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (validateValues()) {
                      saveValuesToAPI(context);
                    } else {
                      showInvalidValuesDialog(context);
                    }
                  },
                  child: Text('Save Values',
                      style: GoogleFonts.ramabhadra(color: Colors.black)),
                  style: ElevatedButton.styleFrom(),
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
                updateARValue();
              }
            },
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
    final url = 'http://172.23.10.51:1111/t1013a';
    final TAIValue = TAIController.text;
    final tempValue = tempController.text;
    final FAValue = FAController.text;
    final ARValue = ARController.text;
    final ACValue = ACController.text;
    final Round = roundValue.toString();

    final name = USERDATA.NAME;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'T_AI': TAIValue,
          'Temp': tempValue,
          'FA': FAValue,
          'AR': ARValue,
          'AC': ACValue,
          'Name': name,
          'Range': '13:00',
          'Round': Round,
        },
      );

      if (response.statusCode == 200) {
        TAIController.clear();
        tempController.clear();
        FAController.clear();
        ARController.clear();
        ACController.clear();
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
          title: Text('แจ้งเตือน',
              style: GoogleFonts.ramabhadra(color: Colors.black)),
          content: Text(
              'กรุณากรอกค่าภายในช่วงที่ระบุ\nF.A. (Point) ควรอยู่ระหว่าง 4.8 ถึง 6.5.\nTemp.(°C) ควรอยู่ระหว่าง 70 ถึง 80.\nA.C. (Point) ควรอยู่ระหว่าง 1 ถึง 3.\nA.R. (Point) ควรอยู่ระหว่าง 5.5 ถึง 7.5.\nT.A. (Point) ควรอยู่ระหว่าง 30 ถึง 36.',
              style: GoogleFonts.ramabhadra(color: Colors.black)),
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

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success',
              style: GoogleFonts.ramabhadra(color: Colors.black)),
          content: Text('บันทึกค่าสำเร็จ',
              style: GoogleFonts.ramabhadra(color: Colors.black)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil(ModalRoute.withName('/'));
              },
              child: Text('OK',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
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
          title:
              Text('Error', style: GoogleFonts.ramabhadra(color: Colors.black)),
          content:
              Text(message, style: GoogleFonts.ramabhadra(color: Colors.black)),
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
    final url = 'http://172.23.10.51:1111/tank10afterdata13';
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
