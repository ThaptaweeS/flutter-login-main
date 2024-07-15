import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/data/global.dart';

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
  State<ManualfeedUserBody> createState() => _ManualfeedUserBodyState();
}

class _ManualfeedUserBodyState extends State<ManualfeedUserBody> {
  late List<Map<String, dynamic>> tableData = [];
  late List<bool> showDetails = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
    _timer =
        Timer.periodic(Duration(minutes: 5), (Timer t) => fetchDataFromAPI());
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  Future<void> fetchDataFromAPI() async {
    final url = 'http://172.23.10.51:1111/manual-feed-user';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        bool newDataFetched =
            tableData.isNotEmpty && responseData.length > tableData.length;
        setState(() {
          tableData = responseData.cast<Map<String, dynamic>>();
          showDetails = List<bool>.filled(tableData.length, false);
        });
        if (newDataFetched) {
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
    Future.delayed(Duration(seconds: 10), () {
      Navigator.of(context).pop();
    });
  }

  void showDetailPopup(int index) {
    TextEditingController lotController = TextEditingController();
    TextEditingController valueController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('รายละเอียด', style: TextStyle(color: Colors.black)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('เคมีที่ต้องเติม : ${tableData[index]['Detail']}',
                  style: TextStyle(color: Colors.black)),
              Text('ปริมาณที่เติม : ${tableData[index]['Solv']} กิโลกรัม',
                  style: TextStyle(color: Colors.black)),
              SizedBox(height: 15),
              TextField(
                controller: lotController,
                decoration: InputDecoration(labelText: 'Lot'),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: valueController,
                decoration:
                    InputDecoration(labelText: 'จำนวนที่เติม(กิโลกรัม)'),
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _callFeedAPI(
                  tableData[index]['id'],
                  tableData[index]['request_id'],
                  tableData[index]['No'],
                  lotController.text,
                  valueController.text,
                  tableData[index]['Detail'],
                  tableData[index]['Solv'],
                  USERDATA.NAME,
                ).then((_) {
                  fetchDataFromAPI();
                  Navigator.of(context).pop();
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('บันทึกค่า'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('ยกเลิก'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _callFeedAPI(int id, String request_id, int no, String lot,
      String value, String detail, String solv, String name) async {
    await _callAPI(
        'User-Feed', id, request_id, no, lot, value, detail, solv, name);
  }

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
        'userDataNam': userDataNam,
      };
      final response = await http
          .post(Uri.parse('http://172.23.10.51:1111/$endpoint'), body: body);
      if (response.statusCode == 200) {
        print(
            'API call successful: $endpoint, id: $no, lot: $lot, value: $value, detail: $detail, solv: $solv, userDataNam: $userDataNam');
      } else {
        print(
            'Failed to call API: $endpoint, id: $no, lot: $lot, value: $value, detail: $detail, solv: $solv, userDataNam: $userDataNam');
      }
    } catch (error) {
      print('Error calling API: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.blue[100]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.heat_pump,
                  size: 36.0,
                  color: Colors.blue,
                ),
                title: Text(
                  'Feed Chemical : Order by QC',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 500, // Adjust the height as needed
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Colors.blue[50]!, Colors.blue[100]!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: DataTable(
                    columns: [
                      DataColumn(
                          label: Text('Tank No.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Process',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Item Check',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Specification',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Setpoint',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Actual',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Time',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Status',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('')),
                    ],
                    rows: List.generate(tableData.length, (index) {
                      return DataRow(
                        cells: [
                          DataCell(Text(tableData[index]['No'].toString(),
                              style: TextStyle(color: Colors.black))),
                          DataCell(Text(tableData[index]['Process'].toString(),
                              style: TextStyle(color: Colors.black))),
                          DataCell(Text(tableData[index]['Item'].toString(),
                              style: TextStyle(color: Colors.black))),
                          DataCell(Text(tableData[index]['Spec'].toString(),
                              style: TextStyle(color: Colors.black))),
                          DataCell(Text(tableData[index]['SetPoint'].toString(),
                              style: TextStyle(color: Colors.black))),
                          DataCell(Text(tableData[index]['Actual'].toString(),
                              style: TextStyle(color: Colors.black))),
                          DataCell(Text(tableData[index]['Time'].toString(),
                              style: TextStyle(color: Colors.black))),
                          DataCell(Text(
                            tableData[index]['Status'] == 0
                                ? 'Waiting'
                                : 'Feed',
                            style: TextStyle(
                                color: tableData[index]['Status'] == 0
                                    ? Colors.blue
                                    : Colors.orange),
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
                ),
              ),
              SizedBox(height: 168),
            ],
          ),
        ),
      ),
    );
  }
}
