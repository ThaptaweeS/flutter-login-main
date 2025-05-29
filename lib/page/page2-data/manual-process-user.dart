import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';
import 'package:newmaster/page/page02/remote-pump-feed.dart';

late BuildContext ManualfeedUserContext;

class ManualfeedUser extends StatelessWidget {
  const ManualfeedUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ManualfeedUserContext = context;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[50],
        leading: Builder(
          builder: (BuildContext context) {
            return TextButton(
              onPressed: () {
                CuPage = P1DASHBOARDMAIN();
                MainBodyContext.read<ChangePage_Bloc>()
                    .add(ChangePage_nodrower());
              },
              style: const ButtonStyle(
                alignment: Alignment.centerRight,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  SizedBox(width: 8),
                  // Text(
                  //   'Dashboard',
                  //   style: GoogleFonts.ramabhadra(color: Colors.black),
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                ],
              ),
            );
          },
        ),
        // leading: Row(
        //   children: [
        //     TextButton(
        //       onPressed: () {
        //         CuPage = P1DASHBOARDMAIN();
        //         MainBodyContext.read<ChangePage_Bloc>()
        //             .add(ChangePage_nodrower());
        //       },
        //       style: const ButtonStyle(
        //         alignment: Alignment.centerRight, // ครอบคลุมพื้นที่ด้านซ้าย
        //       ),
        //       child: const Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Icon(Icons.arrow_back_ios_new, color: Colors.black),
        //           SizedBox(width: 8),
        //           Text(
        //             'Dashboard',
        //             style: GoogleFonts.ramabhadra(
        //               color: Colors.black,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        title: Center(
          child: Stack(
            children: <Widget>[
              // Stroked text as border.
              // Text(
              //   'Chemical Feed Order',
              //   style: GoogleFonts.ramabhadra(
              //     fontSize: 40,
              //     foreground: Paint()
              //       ..style = PaintingStyle.stroke
              //       ..strokeWidth = 6
              //       ..color = Colors.blue[700]!,
              //   ),
              // ),
              // Solid text as fill.
              Text(
                'Chemical Feed Order',
                style: GoogleFonts.ramabhadra(
                  fontSize: 40,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              CuPage = Remotefeed();
              MainBodyContext.read<ChangePage_Bloc>()
                  .add(ChangePage_nodrower());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Remote Feed',
                  style: GoogleFonts.ramabhadra(color: Colors.black),
                ),
                SizedBox(width: 8), // เว้นระยะระหว่างข้อความกับไอคอน
                Icon(Icons.arrow_forward_ios, color: Colors.black),
              ],
            ),
          ),
        ],
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
      } else {
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // print('Error fetching data: $error');
      // เพิ่ม Dialog แสดงข้อผิดพลาด
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('ข้อผิดพลาด',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
              content: Text('ไม่สามารถโหลดข้อมูลได้: $error',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('ปิด',
                      style: GoogleFonts.ramabhadra(color: Colors.black)),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void toggleDetailsVisibility(int index) {
    setState(() {
      showDetails[index] = !showDetails[index];
    });
  }

  void showDetailPopup(int index) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController lotController = TextEditingController();
    TextEditingController valueController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('รายละเอียด',
              style: GoogleFonts.ramabhadra(color: Colors.black)),
          content: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'เคมีที่ต้องเติม : ${tableData[index]['Detail']}',
                  style: GoogleFonts.ramabhadra(color: Colors.black),
                ),
                Text(
                  'ปริมาณที่แนะนำ : ${tableData[index]['Solv']} กิโลกรัม',
                  style: GoogleFonts.ramabhadra(color: Colors.black),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: lotController,
                  decoration: const InputDecoration(
                    labelText: 'Lot',
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                  ),
                  style: GoogleFonts.ramabhadra(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอก Lot';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: valueController,
                  decoration: const InputDecoration(
                    labelText: 'จำนวนที่เติม(กิโลกรัม)',
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                  ),
                  style: GoogleFonts.ramabhadra(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกจำนวนที่เติม';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      try {
                        if (tableData[index]['No'].toString() == "9" &&
                            tableData[index]['Detail'].toString() == "AC-131") {
                          feedData.ac9feedQuantity = value;
                          print(
                              "AC9 Feed Quantity Updated: ${feedData.ac9feedQuantity}");
                        }
                        if (tableData[index]['No'].toString() == "10" &&
                            tableData[index]['Detail'].toString() == "AC-131") {
                          feedData.ac10feedQuantity = value;
                          print(
                              "AC10 Feed Quantity Updated: ${feedData.ac10feedQuantity}");
                        }
                        if (tableData[index]['No'].toString() == "10" &&
                            tableData[index]['Detail'].toString() ==
                                "PB-181X(R)") {
                          feedData.pb10feedQuantity = value;
                          print(
                              "PB10 Feed Quantity Updated: ${feedData.pb10feedQuantity}");
                        }
                      } catch (e) {
                        debugPrint('Invalid input: $value');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  try {
                    String lot = lotController.text.trim();
                    String quantity = valueController.text.trim();
                    print("ID: ${tableData[index]['id']}");
                    print("Request ID: ${tableData[index]['request_id']}");
                    print("No: ${tableData[index]['No']}");
                    print('Detail: ${tableData[index]['Detail']}');
                    print("Lot: $lot");
                    print("จำนวนที่เติม: $quantity");

                    await _callFeedAPI(
                      tableData[index]['id'] ?? '',
                      tableData[index]['request_id'] ?? '',
                      tableData[index]['No'] ?? '',
                      lot,
                      quantity,
                      tableData[index]['Detail'] ?? '',
                      tableData[index]['Solv'] ?? '',
                      USERDATA.NAME ?? '',
                      tableData[index]['RoundTime'] ?? '',
                      tableData[index]['Date'] ?? '',
                      tableData[index]['Time'] ?? '',
                      tableData[index]['Chemicals'] ?? '',
                    );

                    await Future.delayed(const Duration(milliseconds: 300));
                    await fetchDataFromAPI();
                    setState(() {});
                    Navigator.of(context).pop(); // ปิด Popup
                  } catch (error) {
                    print('Error during save: $error');
                  }
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('บันทึกค่า',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('ยกเลิก',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
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
    String roundtime,
    String date,
    String ordertime,
    String chemicals,
  ) async {
    await _callAPI(
      'User-Feed',
      id,
      request_id,
      no,
      lot,
      value,
      detail,
      solv,
      name,
      roundtime,
      date,
      ordertime,
      chemicals,
    );
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
    String roundtime,
    String date,
    String ordertime,
    String chemicals,
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
        'roundtime': roundtime,
        'orderdate': date,
        'ordertime': ordertime,
      };

      final response = await http.post(
        Uri.parse('http://172.23.10.51:1111/$endpoint'),
        body: body,
      );

      if (response.statusCode == 200) {
        print('API call successful: $endpoint');
      } else {
        throw Exception(
            'Failed to call API. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error calling API: $error');
      throw error; // ส่งข้อผิดพลาดให้ฟังก์ชันที่เรียกใช้
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        color: Colors.indigo[50],
        // begin: Alignment.topCenter,
        // end: Alignment.bottomCenter,
        // ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading:
                      Icon(Icons.heat_pump, size: 36.0, color: Colors.blue),
                  title: Text(
                    'Order Feed chemicals from QC',
                    style: GoogleFonts.ramabhadra(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Colors.blue[100]!, Colors.blue[100]!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical, // เลื่อนแนวตั้ง
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // เลื่อนแนวนอน
                      child: DataTable(
                        columnSpacing: 45.0,
                        columns: [
                          DataColumn(
                              label: Text('Tank No.',
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Process',
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Item Check',
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Specification',
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Setpoint',
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Actual',
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Date',
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Round',
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Order Time',
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Status',
                                  style: GoogleFonts.ramabhadra(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('')),
                        ],
                        rows: List.generate(tableData.length, (index) {
                          return DataRow(
                            cells: [
                              DataCell(Text(
                                tableData[index]['Chemicals'].toString(),
                                style:
                                    GoogleFonts.ramabhadra(color: Colors.black),
                              )),
                              DataCell(Text(
                                tableData[index]['Process'].toString(),
                                style:
                                    GoogleFonts.ramabhadra(color: Colors.black),
                              )),
                              DataCell(Text(
                                tableData[index]['Item'].toString(),
                                style:
                                    GoogleFonts.ramabhadra(color: Colors.black),
                              )),
                              DataCell(Text(
                                tableData[index]['Spec'].toString(),
                                style:
                                    GoogleFonts.ramabhadra(color: Colors.black),
                              )),
                              DataCell(Text(
                                tableData[index]['SetPoint'].toString(),
                                style:
                                    GoogleFonts.ramabhadra(color: Colors.black),
                              )),
                              DataCell(Text(
                                tableData[index]['Actual'].toString(),
                                style:
                                    GoogleFonts.ramabhadra(color: Colors.black),
                              )),
                              DataCell(Text(
                                tableData[index]['Date'].toString(),
                                style:
                                    GoogleFonts.ramabhadra(color: Colors.black),
                              )),
                              DataCell(Text(
                                tableData[index]['RoundTime'].toString(),
                                style:
                                    GoogleFonts.ramabhadra(color: Colors.black),
                              )),
                              DataCell(Text(
                                tableData[index]['Time'].toString(),
                                style:
                                    GoogleFonts.ramabhadra(color: Colors.black),
                              )),
                              DataCell(
                                Text(
                                  tableData[index]['Status'] == 0
                                      ? 'Waiting'
                                      : tableData[index]['Status'] == 1
                                          ? 'Feed'
                                          : tableData[index]['Status'] == 3
                                              ? 'Make Up'
                                              : 'Unknown', // Add this for handling any unexpected status values
                                  style: GoogleFonts.ramabhadra(
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
                                child: Text('Action',
                                    style: GoogleFonts.ramabhadra(
                                        color: Colors.black)),
                              )),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 168),
            ],
          ),
        ),
      ),
    );
  }
}
