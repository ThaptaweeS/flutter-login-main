import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';

late BuildContext ManualfeedUserContext;

class ManualfeedUser extends StatelessWidget {
  const ManualfeedUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ManualfeedUserContext = context;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            CuPage = P1DASHBOARDMAIN();
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
        title: Center(
          child: Stack(
            children: <Widget>[
              // Stroked text as border.
              Text(
                'Chemical Feed Order',
                style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.blue[700]!,
                ),
              ),
              // Solid text as fill.
              Text(
                'Chemical Feed Order',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
        // title: const Text('Order Feed Chemicals'),
      ),
      body: const ManualfeedUserBody(),
    );
  }
}

class ManualfeedUserBody extends StatefulWidget {
  const ManualfeedUserBody({super.key});

  @override
  State<ManualfeedUserBody> createState() => _ManualfeedUserBodyState();
}

class _ManualfeedUserBodyState extends State<ManualfeedUserBody> {
  List<Map<String, dynamic>> tableData = [];
  List<bool> showDetails = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    const url = 'http://172.23.10.51:1111/manual-feed-user';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          tableData = responseData.cast<Map<String, dynamic>>();
          showDetails = List<bool>.filled(tableData.length, false);
        });
        print('Data fetched successfully: $tableData');
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void toggleDetailsVisibility(int index) {
    setState(() {
      showDetails[index] = !showDetails[index];
    });
  }

  void showDetailPopup(int index) {
    TextEditingController lotController = TextEditingController();
    TextEditingController valueController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              const Text('รายละเอียด', style: TextStyle(color: Colors.black)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('เคมีที่ต้องเติม : ${tableData[index]['Detail']}',
                  style: const TextStyle(color: Colors.black)),
              Text('ปริมาณที่แนะนำ : ${tableData[index]['Solv']} กิโลกรัม',
                  style: const TextStyle(color: Colors.black)),
              const SizedBox(height: 15),
              TextField(
                controller: lotController,
                decoration: const InputDecoration(labelText: 'Lot'),
                style: const TextStyle(color: Colors.black),
              ),
              TextField(
                controller: valueController,
                decoration:
                    const InputDecoration(labelText: 'จำนวนที่เติม(กิโลกรัม)'),
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                // Call the API and await response
                await _callFeedAPI(
                  tableData[index]['id'],
                  tableData[index]['request_id'],
                  tableData[index]['No'],
                  lotController.text,
                  valueController.text,
                  tableData[index]['Detail'],
                  tableData[index]['Solv'],
                  USERDATA.NAME,
                );

                // Add delay to ensure API is completely processed before refreshing data
                await Future.delayed(const Duration(milliseconds: 500));

                // Fetch new data and refresh the table
                await fetchDataFromAPI();

                // Trigger the UI to rebuild
                setState(() {});

                // Close the dialog only after refreshing the data
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('บันทึกค่า'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('ยกเลิก'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _callFeedAPI(
    int id,
    String request_id,
    int no,
    String lot,
    String value,
    String detail,
    String solv,
    String name,
  ) async {
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
    String userDataNam,
  ) async {
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
        print('API call successful: $endpoint');
      } else {
        print('Failed to call API: $endpoint');
      }
    } catch (error) {
      print('Error calling API: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.blue[100]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: const Icon(Icons.heat_pump,
                      size: 36.0, color: Colors.blue),
                  title: const Text(
                    'Order Feed chemicals from QC',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
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
                    columns: const [
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
                          label: Text('Date',
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
                              style: const TextStyle(color: Colors.black))),
                          DataCell(Text(tableData[index]['Process'].toString(),
                              style: const TextStyle(color: Colors.black))),
                          DataCell(Text(tableData[index]['Item'].toString(),
                              style: const TextStyle(color: Colors.black))),
                          DataCell(Text(tableData[index]['Spec'].toString(),
                              style: const TextStyle(color: Colors.black))),
                          DataCell(Text(tableData[index]['SetPoint'].toString(),
                              style: const TextStyle(color: Colors.black))),
                          DataCell(Text(tableData[index]['Actual'].toString(),
                              style: const TextStyle(color: Colors.black))),
                          DataCell(Text(tableData[index]['Date'].toString(),
                              style: const TextStyle(color: Colors.black))),
                          DataCell(Text(tableData[index]['Time'].toString(),
                              style: const TextStyle(color: Colors.black))),
                          DataCell(
                            Text(
                              tableData[index]['Status'] == 0
                                  ? 'Waiting'
                                  : tableData[index]['Status'] == 1
                                      ? 'Feed'
                                      : tableData[index]['Status'] == 3
                                          ? 'Make Up'
                                          : 'Unknown', // Add this for handling any unexpected status values
                              style: TextStyle(
                                color: tableData[index]['Status'] == 0
                                    ? Colors.blue
                                    : tableData[index]['Status'] == 1
                                        ? Colors.green[700]
                                        : tableData[index]['Status'] == 3
                                            ? Colors
                                                .red // You can use any color for Make Up status
                                            : Colors
                                                .red, // Color for unknown status
                              ),
                            ),
                          ),
                          DataCell(ElevatedButton(
                            onPressed: () => showDetailPopup(index),
                            child: const Text('Action'),
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
