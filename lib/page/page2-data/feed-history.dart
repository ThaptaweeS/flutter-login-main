import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';

late BuildContext FeedHistoryContext;

class FeedHistory extends StatelessWidget {
  const FeedHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            CuPage = P1DASHBOARDMAIN();
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
        title: Text("Feed History", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.blue[100],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FeedHistoryBody(),
    );
  }
}

class FeedHistoryBody extends StatefulWidget {
  const FeedHistoryBody({Key? key});

  @override
  State<FeedHistoryBody> createState() => _FeedHistoryBodyState();
}

class _FeedHistoryBodyState extends State<FeedHistoryBody> {
  late List<Map<String, dynamic>> tableData = [];
  String selectedTank = '';
  DateTime? fromDate;
  DateTime? toDate;
  String? dropdownValue = '';

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    String url = 'http://172.23.10.51:1111/chem-feed';
    Map<String, String> body = {};

    if (selectedTank.isNotEmpty) {
      body['tank'] = selectedTank;
    }

    if (fromDate != null) {
      body['fromDate'] = DateFormat('yyyy-MM-dd').format(fromDate!);
    }

    if (toDate != null) {
      body['toDate'] = DateFormat('yyyy-MM-dd').format(toDate!);
    }

    print('Fetching data from: $url with body: $body');

    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        print('Response data: $responseData');
        setState(() {
          tableData = responseData.cast<Map<String, dynamic>>();
        });
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  List<Map<String, dynamic>> filterDataByDateRange(
      List<Map<String, dynamic>> data, DateTime? fromDate, DateTime? toDate) {
    return data.where((item) {
      DateTime itemDate = DateTime.parse(item['date']);
      if (fromDate != null && itemDate.isBefore(fromDate)) {
        return false;
      }
      if (toDate != null && itemDate.isAfter(toDate)) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredData = filterDataByDateRange(
        tableData
            .where(
                (data) => selectedTank.isEmpty || data['tank'] == selectedTank)
            .toList(),
        fromDate,
        toDate);

    print('Selected tank: $selectedTank');
    print('From date: $fromDate');
    print('To date: $toDate');
    print('Filtered data length: ${filteredData.length}');

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.blue[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: TextField(
                    controller: fromDateController,
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      hintText: 'DD-MM-YYYY',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            fromDate = null;
                            fromDateController.clear();
                            fetchDataFromAPI();
                          });
                        },
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: fromDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          fromDate = pickedDate;
                          fromDateController.text =
                              DateFormat('dd-MM-yyyy').format(fromDate!);
                          fetchDataFromAPI();
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 150,
                  child: TextField(
                    controller: toDateController,
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      hintText: 'dd-MM-yyyy',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            toDate = null;
                            toDateController.clear();
                            fetchDataFromAPI();
                          });
                        },
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: toDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          toDate = pickedDate;
                          toDateController.text =
                              DateFormat('dd-MM-yyyy').format(toDate!);
                          fetchDataFromAPI();
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 200,
                  child: DropdownButtonFormField<String>(
                    value: selectedTank.isEmpty ? null : selectedTank,
                    icon: Icon(Icons.arrow_drop_down),
                    decoration: InputDecoration(
                      labelText: 'Tank Select',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTank = newValue ?? '';
                        fetchDataFromAPI();
                      });
                    },
                    items: <String>['', '2', '5', '9', '10', '13', '14']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('Tank $value',
                            style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    dropdownColor: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: fetchDataFromAPI,
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 5),
                      Text('Search'),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Implement export to Excel functionality
                  },
                  child: Row(
                    children: [
                      Icon(Icons.save),
                      SizedBox(width: 5),
                      Text('Export to Excel'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                primary: false,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FixedColumnWidth(80.0),
                      1: FixedColumnWidth(120.0),
                      2: FixedColumnWidth(180.0),
                      3: FixedColumnWidth(180.0),
                      4: FixedColumnWidth(120.0),
                      5: FixedColumnWidth(120.0),
                      6: FixedColumnWidth(120.0),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Tank",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Detail",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Lot",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Name",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Value(Kg)",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Date",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Time",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...filteredData.map((data) {
                        return TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['tank'].toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['detail'].toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['lot'].toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['name'].toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['value'].toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(data['date'].toString())),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['time'].toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
