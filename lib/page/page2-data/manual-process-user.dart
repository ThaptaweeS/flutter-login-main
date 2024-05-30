import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/components/chart2.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/page/page02.dart';
import 'package:newmaster/page/page2-data/text-card.dart';
import 'package:newmaster/page/tank/tank1-data/data_page01.dart';
import 'package:newmaster/components/recent_files.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/page/tank/tank1-data/layout-history.dart';
import 'package:newmaster/page/tank/tank1-data/pump.dart';
import 'package:newmaster/presentation/samples/bar/bar_chart_sample1.dart';
import 'package:newmaster/presentation/samples/bar/bar_chart_sample2.dart';
import 'package:newmaster/presentation/samples/line/line_chart_sample2.dart';
import 'package:newmaster/presentation/samples/line/line_chart_sample3.dart';
import 'package:newmaster/presentation/samples/line/line_chart_sample4.dart';
import 'package:newmaster/responsive.dart';
import 'package:newmaster/widget/appbar/AppBar.dart';
import 'package:newmaster/widget/common/Radiobutton.dart';
import 'package:newmaster/widget/menu/side_menu.dart';
import 'package:newmaster/page/tank/tank1-data/layout-chart.dart';
import 'package:http/http.dart' as http;

import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../mainBody.dart';

late BuildContext ManualfeedUserContext;

class ManualfeedUser extends StatelessWidget {
  const ManualfeedUser({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ManualfeedUserContext = context;

    return Scaffold(body: ManualfeedUserBody());
  }
}

class ManualfeedUserBody extends StatefulWidget {
  const ManualfeedUserBody({super.key});

  @override
  State<ManualfeedUserBody> createState() => _P1DASHBOARDMAINState4();
}

class _P1DASHBOARDMAINState4 extends State<ManualfeedUserBody> {
  late List<Map<String, dynamic>> tableData = [];
  late List<bool> showDetails = [];

  late Timer _timer; // Timer variable

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();

    // Start timer to fetch data every 5 minutes
    _timer =
        Timer.periodic(Duration(seconds: 5), (Timer t) => fetchDataFromAPI());
  }

  @override
  void dispose() {
    super.dispose();
    _timer
        .cancel(); // Cancel timer when the widget is disposed to prevent memory leaks
  }

  // Fetch data from API
  Future<void> fetchDataFromAPI() async {
    final url = 'http://172.23.10.51:1111/manual-feed-user';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        // Check if new data is fetched
        bool newDataFetched =
            tableData.isNotEmpty && responseData.length > tableData.length;

        setState(() {
          tableData = responseData.cast<Map<String, dynamic>>();
          // Initialize showDetails list with false for each row
          showDetails = List<bool>.filled(tableData.length, false);
        });

        if (newDataFetched) {
          // Show the popup for 10 seconds if new data is fetched
          _showPopupForTenSeconds();
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _showPopupForTenSeconds() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('แจ้งเตือน'),
          content: Text('ได้รับข้อมูลเคมีที่ต้องเติมเพิ่ม'),
        );
      },
    );

    // Close the popup after 10 seconds
    Future.delayed(Duration(seconds: 10), () {
      Navigator.of(context).pop();
    });
  }

  // Method to toggle visibility of details for a row
  void toggleDetailsVisibility(int index) {
    setState(() {
      showDetails[index] = !showDetails[index];
    });
  }

  // Method to show popup dialog
  void showDetailPopup(int index) {
    TextEditingController lotController = TextEditingController();
    TextEditingController valueController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('รายละเอียด'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('เคมีที่ต้องเติม : ${tableData[index]['Detail']}'),
              Text('ปริมาณที่เติม : ${tableData[index]['Solv']}' ' กิโลกรัม'),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: lotController,
                decoration: InputDecoration(labelText: 'Lot'),
              ),
              TextField(
                controller: valueController,
                decoration:
                    InputDecoration(labelText: 'จำนวนที่เติม(กิโลกรัม)'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Call API2 ('Approve' endpoint) with Lot, Value, Detail, Solv, and USERDATA.NAM
                _callFeedAPI(
                  tableData[index]['id'],
                  tableData[index]['request_id'],
                  tableData[index]['No'],
                  lotController.text,
                  valueController.text,
                  tableData[index]['Detail'], // Pass Detail from tableData
                  tableData[index]['Solv'], // Pass Solv from tableData
                  USERDATA.NAME, // Pass USERDATA.NAM
                ).then((_) {
                  // Fetch updated data for the table
                  fetchDataFromAPI();
                  // Close the dialog
                  Navigator.of(context).pop();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green, // Change the button color to green
              ),
              child: Text('บันทึกค่า'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Change the button color to red
              ),
              child: Text('ยกเลิก'),
            ),
          ],
        );
      },
    );
  }

// Separate methods for different API calls
  Future<void> _callFeedAPI(int id, String request_id, int no, String lot,
      String value, String detail, String solv, String name) async {
    await _callAPI(
        'User-Feed', id, request_id, no, lot, value, detail, solv, name);
  }

// Updated _callAPI method to include Detail and Solv parameters
  Future<void> _callAPI(
      String endpoint,
      int id,
      String request_id,
      int no,
      String lot,
      String value,
      String detail,
      String solv,
      String userDataNam) async {
    try {
      final Map<String, String> body = {
        'id': id.toString(),
        'request': request_id,
        'tank': no.toString(),
        'lot': lot,
        'value': value,
        'detail': detail,
        'solv': solv,
        'userDataNam': userDataNam, // Include USERDATA.NAM in the request body
      };

      final response = await http.post(
        Uri.parse('http://172.23.10.51:1111/$endpoint'),
        body: body,
      );
      if (response.statusCode == 200) {
        // API call successful
        print(
            'API call successful: $endpoint, id: $no, lot: $lot, value: $value, detail: $detail, solv: $solv, userDataNam: $userDataNam');
        // You can perform any additional actions here if needed
      } else {
        // API call failed
        print(
            'Failed to call API: $endpoint, id: $no, lot: $lot, value: $value, detail: $detail, solv: $solv, userDataNam: $userDataNam');
        // You can handle errors or display a message to the user
      }
    } catch (error) {
      // An error occurred during the API call
      print('Error calling API: $error');
      // You can handle errors or display a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.heat_pump,
                  size: 36.0,
                  color: Colors.white,
                ),
                title: Text(
                  'Feed Chemical : Order by QC',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            DataTable(
              columns: [
                DataColumn(label: Text('Tank No.')),
                DataColumn(label: Text('Process')),
                DataColumn(label: Text('Item Check')),
                DataColumn(label: Text('Specification')),
                DataColumn(label: Text('Setpoint')),
                DataColumn(label: Text('Actual')),
                DataColumn(label: Text('Time')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('')),
              ],
              rows: List.generate(tableData.length, (index) {
                return DataRow(
                  cells: [
                    DataCell(Text(tableData[index]['No'].toString())),
                    DataCell(Text(tableData[index]['Process'].toString())),
                    DataCell(Text(tableData[index]['Item'].toString())),
                    DataCell(Text(tableData[index]['Spec'].toString())),
                    DataCell(Text(tableData[index]['SetPoint'].toString())),
                    DataCell(Text(tableData[index]['Actual'].toString())),
                    DataCell(Text(tableData[index]['Time'].toString())),
                    DataCell(Text(
                      tableData[index]['Status'] == 0 ? 'Waiting' : 'Feed',
                      style: TextStyle(
                        color: tableData[index]['Status'] == 0
                            ? Colors.blue
                            : Colors.orange,
                      ),
                    )),
                    DataCell(ElevatedButton(
                      onPressed: () {
                        showDetailPopup(index);
                      },
                      child: Text('Action'),
                    )),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
