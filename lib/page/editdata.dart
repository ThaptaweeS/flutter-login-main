import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';

class Editdata extends StatefulWidget {
  const Editdata({super.key});

  @override
  State<Editdata> createState() => _EditdataState();
}

class _EditdataState extends State<Editdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[50],
        title: Text('Data Edit',
            style: GoogleFonts.ramabhadra(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            CuPage = P1DASHBOARDMAIN();
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
      ),
      body: const EditdataBody(),
    );
  }
}

class EditdataBody extends StatefulWidget {
  const EditdataBody({super.key});

  @override
  State<EditdataBody> createState() => _EditdataBodyState();
}

class _EditdataBodyState extends State<EditdataBody> {
  List<Map<String, dynamic>> tableData = [];
  bool isLoading = false;

  Future<void> _sendTankRequest(String tankNumber) async {
    setState(() {
      isLoading = true; // แสดง Animation Loading
    });

    final String url = 'http://172.23.10.51:1111/edit$tankNumber';
    final Map<String, dynamic> payload = {
      "tankNumber": tankNumber,
    };

    try {
      // แสดง Loading Dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
              // valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
        ),
      );

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        setState(() {
          tableData = decodedData
              .map((entry) => {
                    'id': entry['id']?.toString() ?? '',
                    'round': entry['round'] ?? '',
                    'data': entry['data'] ?? '',
                    'detail': entry['detail'] ?? '',
                    'value': entry['value']?.toString() ?? '',
                    'Username': entry['username'] ?? '',
                    'time': entry['time'] ?? '',
                    'date': entry['date'] ?? '',
                    'tank': tankNumber, // เพิ่ม tankNumber
                  })
              .toList();
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      Navigator.pop(context); // ปิด Loading Dialog
      setState(() {
        isLoading = false; // ปิด Animation Loading
      });
    }
  }

  Future<void> callEditDataAPI(
      String id, String value, String tankNumber) async {
    final url = Uri.parse('http://172.23.10.51:1111/calleditdata');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': id,
          'value': value,
          'tank': tankNumber,
        }),
      );

      if (response.statusCode == 200) {
        print('Data updated successfully: ${response.body}');
        // หลังจากการอัพเดตข้อมูลสำเร็จ ให้รีเฟรชข้อมูลตาราง
        await _sendTankRequest(tankNumber);
      } else {
        print('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while calling API: $e');
    }
  }

  Widget _buildTankButton(
      BuildContext context, String tank, Color color, String tankNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: color,
          minimumSize: Size(50, 60),
        ),
        onPressed: () => _sendTankRequest(tankNumber),
        child: Text(tank, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.indigo[50],
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTankButton(context, "Tank2", Colors.blue, "2"),
                      _buildTankButton(context, "Tank5", Colors.green, "5"),
                      _buildTankButton(context, "Tank8", Colors.yellow, "8"),
                      _buildTankButton(context, "Tank9", Colors.orange, "9"),
                      _buildTankButton(context, "Tank10", Colors.red, "10"),
                      _buildTankButton(context, "Tank13", Colors.purple, "13"),
                      _buildTankButton(context, "Tank14", Colors.amber, "14"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.blue[200]!, Colors.blue[200]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 45.0,
                      columns: [
                        DataColumn(
                            label: Text('ID',
                                style: GoogleFonts.ramabhadra(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Round',
                                style: GoogleFonts.ramabhadra(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Data',
                                style: GoogleFonts.ramabhadra(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Detail',
                                style: GoogleFonts.ramabhadra(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Value',
                                style: GoogleFonts.ramabhadra(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Username',
                                style: GoogleFonts.ramabhadra(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Time',
                                style: GoogleFonts.ramabhadra(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Date\n(DD-MM-YYYY)',
                                style: GoogleFonts.ramabhadra(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Action',
                                style: GoogleFonts.ramabhadra(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                      ],
                      rows: tableData.map((data) {
                        return DataRow(
                          cells: [
                            DataCell(Text(
                              data['id'].toString(),
                              style:
                                  GoogleFonts.ramabhadra(color: Colors.black),
                            )),
                            DataCell(Text(
                              data['round'].toString(),
                              style:
                                  GoogleFonts.ramabhadra(color: Colors.black),
                            )),
                            DataCell(Text(
                              data['data'].toString(),
                              style:
                                  GoogleFonts.ramabhadra(color: Colors.black),
                            )),
                            DataCell(Text(
                              data['detail'].toString(),
                              style:
                                  GoogleFonts.ramabhadra(color: Colors.black),
                            )),
                            DataCell(Text(
                              data['value'].toString(),
                              style:
                                  GoogleFonts.ramabhadra(color: Colors.black),
                            )),
                            DataCell(Text(
                              data['Username'].toString(),
                              style:
                                  GoogleFonts.ramabhadra(color: Colors.black),
                            )),
                            DataCell(Text(
                              data['time'].toString(),
                              style:
                                  GoogleFonts.ramabhadra(color: Colors.black),
                            )),
                            DataCell(Text(
                              DateFormat('dd-MM-yyyy').format(
                                  DateTime.parse(data['date'].toString())),
                              style:
                                  GoogleFonts.ramabhadra(color: Colors.black),
                            )),
                            DataCell(
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.black),
                                onPressed: () {
                                  final TextEditingController valueController =
                                      TextEditingController(
                                    text: data['value'] ?? '',
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Edit Value for ID: ${data['id'] ?? ''}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Detail: ${data['detail'] ?? ''}',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(height: 10),
                                            TextField(
                                              controller: valueController,
                                              decoration: InputDecoration(
                                                labelText: 'Value',
                                                labelStyle:
                                                    GoogleFonts.ramabhadra(
                                                        color: Colors.black),
                                                border: OutlineInputBorder(),
                                              ),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              final id = data['id'].toString();
                                              final value =
                                                  valueController.text;
                                              final tankNumber = data['tank'] ??
                                                  ''; // ดึงค่า tankNumber

                                              // แสดง Loading Dialog
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder:
                                                    (BuildContext context) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                              );

                                              // บันทึกค่าและ fetch data ใหม่
                                              await callEditDataAPI(
                                                  id, value, tankNumber);

                                              // ปิด Loading และ Dialog
                                              Navigator.of(context)
                                                  .pop(); // ปิด Loading
                                              Navigator.of(context)
                                                  .pop(); // ปิด AlertDialog
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green),
                                            child: Text('บันทึกค่า',
                                                style: GoogleFonts.ramabhadra(
                                                    color: Colors.black)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            child: Text('ยกเลิก',
                                                style: GoogleFonts.ramabhadra(
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
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
