import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/data/global.dart';
import 'package:newmaster/page/page02.dart';

import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../mainBody.dart';

late BuildContext ManualfeedContext;

class Manualfeed extends StatelessWidget {
  const Manualfeed({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ManualfeedContext = context;

    return Scaffold(
      appBar: AppBar(
        // shadowColor: Colors.transparent,
        backgroundColor: Colors.indigo[50],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            CuPage = Page02body();
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
        title: Center(
          child: Stack(
            children: <Widget>[
              // Stroked text as border.
              Text(
                'Chemical Feed Order',
                style: GoogleFonts.ramabhadra(
                  fontSize: 40,
                  // foreground: Paint()
                  //   ..style = PaintingStyle.stroke
                  //   ..strokeWidth = 6
                  color: Colors.black,
                ),
              ),
              // Solid text as fill.
              // Text(
              //   'Chemical Feed Order',
              //   style: GoogleFonts.ramabhadra(
              //     fontSize: 40,
              //     color: Colors.grey[300],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: ManualfeedBody(),
    );
  }
}

class ManualfeedBody extends StatefulWidget {
  const ManualfeedBody({super.key});

  @override
  State<ManualfeedBody> createState() => _ManualfeedBodyState();
}

class _ManualfeedBodyState extends State<ManualfeedBody> {
  late List<Map<String, dynamic>> tableData = [];
  late List<bool> showDetails = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    final url = 'http://127.0.0.1:1882/manual-feed';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          tableData = responseData.cast<Map<String, dynamic>>();

          showDetails = List<bool>.filled(tableData.length, false);
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  // Method to toggle visibility of details for a row
  void toggleDetailsVisibility(int index) {
    setState(() {
      showDetails[index] = !showDetails[index];
    });
  }

  // Method to show popup dialog
  void showDetailPopup(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Details',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Chemicals : ${tableData[index]['Detail']}',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(
                        text: tableData[index]['Solv'].toString(),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Feed',
                        border: OutlineInputBorder(),
                      ),
                      style: GoogleFonts.ramabhadra(color: Colors.black),
                      onChanged: (value) {
                        // Update the table data when the user changes the value
                        tableData[index]['Solv'] = value;
                      },
                    ),
                  ),
                  SizedBox(width: 10), // Spacing between TextField and "kg."
                  Text('kg.',
                      style: GoogleFonts.ramabhadra(
                        color: Colors.black,
                        fontSize: 16,
                      )),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _callAPI('Passed', tableData[index]['id'],
                        tableData[index]['Solv'])
                    .then((_) {
                  fetchDataFromAPI();

                  Navigator.of(context).pop();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Change the button color to red
                textStyle: GoogleFonts.ramabhadra(color: Colors.white),
              ),
              child: Text('No Feed',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                // Call API2 ('Approve' endpoint)
                _callAPI('Feed', tableData[index]['id'],
                        tableData[index]['Solv'])
                    .then((_) {
                  // Fetch updated data for the table
                  fetchDataFromAPI();
                  // Close the dialog
                  Navigator.of(context).pop();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green, // Change the button color to green
                textStyle: GoogleFonts.ramabhadra(color: Colors.white),
              ),
              child: Text('Feed',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                // Call API2 ('Approve' endpoint)
                _callAPI('Makeup', tableData[index]['id'],
                        tableData[index]['Solv'])
                    .then((_) {
                  // Fetch updated data for the table
                  fetchDataFromAPI();
                  // Close the dialog
                  Navigator.of(context).pop();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.yellow, // Change the button color to green
                textStyle: GoogleFonts.ramabhadra(
                    color: Colors.white), // Change the text color to white
              ),
              child: Text('Make Up',
                  style: GoogleFonts.ramabhadra(color: Colors.black)),
            )
          ],
        );
      },
    );
  }

  // Method to call API
  Future<void> _callAPI(String endpoint, int id, String updatedValue) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:1882/$endpoint'),
        body: {
          'id': id.toString(),
          'value': updatedValue, // Send the updated value
        },
      );
      if (response.statusCode == 200) {
        // API call successful
        print('API call successful: $endpoint, id: $id, value: $updatedValue');
        // You can perform any additional actions here if needed
      } else {
        // API call failed
        print('Failed to call API: $endpoint, id: $id');
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
    final textStyle = GoogleFonts.ramabhadra(color: Colors.black);
    final textStyleBold = GoogleFonts.ramabhadra(
        color: Colors.black, fontWeight: FontWeight.bold);
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        color: Colors.indigo[50],
        // begin: Alignment.topCenter,
        // end: Alignment.bottomCenter,
      ),
      child: SafeArea(
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
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Action command to feed to Production',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // gradient: LinearGradient(
                  color: Colors.blue[100],
                  // begin: Alignment.topCenter,
                  // end: Alignment.bottomCenter,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, // เลื่อนแนวตั้ง
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, // เลื่อนแนวนอน
                    child: DataTable(
                      columnSpacing: 45.0,
                      columns: [
                        DataColumn(
                            label: Text('No.',
                                style: GoogleFonts.ramabhadra(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold
                                ))),
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
                            label: Text('Chemical',
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
                            label: Text('Time',
                                style: GoogleFonts.ramabhadra(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Status',
                                style: GoogleFonts.ramabhadra(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('',
                                style: GoogleFonts.ramabhadra(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                      ],
                      rows: List.generate(tableData.length, (index) {
                        String statusText = '';
                        Color statusColor = Colors.black;
                        switch (tableData[index]['Status']) {
                          case 0:
                            statusText = 'Waiting';
                            statusColor = Colors.red;
                            break;
                          case 1:
                            statusText = 'Send Data';
                            statusColor = Colors.orange;
                            break;
                          case 2:
                            statusText = 'Feed';
                            statusColor = Colors.blue;
                            break;
                          default:
                            statusText = 'Unknown';
                        }

                        return DataRow(
                          cells: [
                            DataCell(Text(
                              tableData[index]['No'].toString(),
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
                              tableData[index]['Detail'].toString(),
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
                                statusText,
                                style:
                                    GoogleFonts.ramabhadra(color: statusColor),
                              ),
                            ),
                            DataCell(
                              FittedBox(
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDetailPopup(index);
                                  },
                                  child: Text('Action',
                                      style: GoogleFonts.ramabhadra(
                                          color: Colors.black)),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 168), // Adjust this size based on your need
            ],
          ),
        ),
      ),
    );
  }
}
