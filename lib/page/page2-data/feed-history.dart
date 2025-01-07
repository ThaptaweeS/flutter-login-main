import 'dart:convert';
import 'dart:html' as html;

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';

late BuildContext FeedHistoryContext;
List<Map<String, dynamic>> tableData = [];
int? selectedRowIndex;

class FeedHistory extends StatelessWidget {
  const FeedHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100]!,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
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
                'Feed History',
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
                'Feed History',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
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
          print('Fetched tableData: $tableData');
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
        alignment: Alignment.topCenter,
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
                      labelText: 'End Date',
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
                const SizedBox(width: 10),
                Container(
                  width: 200,
                  child: DropdownButtonFormField<String>(
                    value: selectedTank.isEmpty ? null : selectedTank,
                    icon: const Icon(Icons.arrow_drop_down),
                    decoration: const InputDecoration(
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
                    items: <String>['', '2', '5', '8', '9', '10', '13', '14']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('Tank $value',
                            style: const TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    dropdownColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
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
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    exportToExcel(filteredData);
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Export to Excel'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Column(
                children: [
                  // Fixed header row
                  Container(
                    child: Center(
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FixedColumnWidth(80.0), // Tank
                          1: FixedColumnWidth(180.0), // Detail
                          2: FixedColumnWidth(180.0), // Lot
                          3: FixedColumnWidth(180.0), // Name
                          4: FixedColumnWidth(120.0), // Order Date
                          5: FixedColumnWidth(120.0), // Round Check
                          6: FixedColumnWidth(120.0), // Order Time
                          7: FixedColumnWidth(120.0), // Fill Date
                          8: FixedColumnWidth(120.0), // Fill Time
                          9: FixedColumnWidth(120.0), // Value (Kg)
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[100], // สีพื้นหลังเต็ม
                                  ),
                                  alignment:
                                      Alignment.center, // จัดข้อความให้อยู่กลาง
                                  child: const Text(
                                    "Tank",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[100], // สีพื้นหลังเต็ม
                                  ),
                                  alignment:
                                      Alignment.center, // จัดข้อความให้อยู่กลาง
                                  child: const Text(
                                    "Detail",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[100], // สีพื้นหลังเต็ม
                                  ),
                                  alignment:
                                      Alignment.center, // จัดข้อความให้อยู่กลาง
                                  child: const Text(
                                    "Lot. Number",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[100], // สีพื้นหลังเต็ม
                                  ),
                                  alignment:
                                      Alignment.center, // จัดข้อความให้อยู่กลาง
                                  child: const Text(
                                    "User Name",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[100], // สีพื้นหลังเต็ม
                                  ),
                                  alignment:
                                      Alignment.center, // จัดข้อความให้อยู่กลาง
                                  child: const Text(
                                    "Order Date\n(DD-MM-YYYY)",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[100], // สีพื้นหลังเต็ม
                                  ),
                                  alignment:
                                      Alignment.center, // จัดข้อความให้อยู่กลาง
                                  child: const Text(
                                    "Round Check",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[100], // สีพื้นหลังเต็ม
                                  ),
                                  alignment:
                                      Alignment.center, // จัดข้อความให้อยู่กลาง
                                  child: const Text(
                                    "Order Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[100], // สีพื้นหลังเต็ม
                                  ),
                                  alignment:
                                      Alignment.center, // จัดข้อความให้อยู่กลาง
                                  child: const Text(
                                    "Fill Date\n(DD-MM-YYYY)",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[100], // สีพื้นหลังเต็ม
                                  ),
                                  alignment:
                                      Alignment.center, // จัดข้อความให้อยู่กลาง
                                  child: const Text(
                                    "Fill Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[100], // สีพื้นหลังเต็ม
                                  ),
                                  alignment:
                                      Alignment.center, // จัดข้อความให้อยู่กลาง
                                  child: const Text(
                                    "Value(Kg)",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Scrollable body
                  Expanded(
                    child: SingleChildScrollView(
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FixedColumnWidth(80.0), // Tank
                          1: FixedColumnWidth(180.0), // Detail
                          2: FixedColumnWidth(180.0), // Lot
                          3: FixedColumnWidth(180.0), // Name
                          4: FixedColumnWidth(120.0), // Order Date
                          5: FixedColumnWidth(120.0), // Round Check
                          6: FixedColumnWidth(120.0), // Order Time
                          7: FixedColumnWidth(120.0), // Fill Date
                          8: FixedColumnWidth(120.0), // Fill Time
                          9: FixedColumnWidth(120.0), // Value (Kg)
                        },
                        children: filteredData.map((data) {
                          return TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['tank'].toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['detail'].toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['lot'].toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['name'].toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    () {
                                      try {
                                        var date =
                                            DateTime.parse(data['orderdate']);
                                        return DateFormat('dd-MM-yyyy')
                                            .format(date);
                                      } catch (e) {
                                        return '-';
                                      }
                                    }(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['roundtime'].toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['ordertime'].toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    DateFormat('dd-MM-yyyy').format(
                                        DateTime.parse(
                                            data['date'].toString())),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['time'].toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['value'].toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void exportToExcel(List<Map<String, dynamic>> tableData) async {
    try {
      var excel = Excel.createExcel(); // Create a new Excel document
      Sheet sheet1 = excel['Sheet1']; // Access the first sheet

      // Add a header row for the sheet
      sheet1.appendRow(["Feed History Phosphate line 3"]);

      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      sheet1.appendRow(["Date: $formattedDate"]); // Add current date as a row

      // Add column titles for the table
      sheet1.appendRow([
        "Tank",
        "Detail",
        "Lot",
        "Name",
        "Order Date",
        "Round Check",
        "Order Time",
        "Fill Date",
        "Fill Time",
        "Value(Kg)"
      ]);

      // Loop through the data and append rows to the Excel sheet
      for (var data in tableData) {
        // Safely handle and format dates, add try-catch block to avoid errors
        String formattedTime = "";
        String formattedOrderDate = "";
        String formattedFillDate = "";

        try {
          final orderDateTime = DateTime.tryParse(data['orderdate'] ?? '');
          formattedOrderDate = orderDateTime != null
              ? DateFormat('dd-MM-yyyy').format(orderDateTime)
              : "";
        } catch (e) {
          print("Error parsing orderdate: $e");
        }

        try {
          final fillDateTime = DateTime.tryParse(data['date'] ?? '');
          formattedFillDate = fillDateTime != null
              ? DateFormat('dd-MM-yyyy').format(fillDateTime)
              : "";
        } catch (e) {
          print("Error parsing date: $e");
        }

        try {
          final time = DateTime.tryParse(data['time'] ?? '');
          formattedTime =
              time != null ? DateFormat('HH:mm:ss').format(time) : "";
        } catch (e) {
          print("Error parsing time: $e");
        }

        // Add row to the Excel sheet
        sheet1.appendRow([
          data['tank'] ?? "", // If empty, use an empty string
          data['detail'] ?? "",
          data['lot'] ?? "",
          data['name'] ?? "",
          formattedOrderDate,
          data['roundtime'] ?? "",
          data['ordertime'] ?? "",
          formattedFillDate,
          data['time'] ?? "",
          data['value'] ?? 0, // Use 0 if empty
        ]);
      }

      // Encode the Excel file to bytes
      var fileBytes = excel.encode()!;

      // Check if fileBytes is valid (not null)
      if (fileBytes != null) {
        // Create Blob and use JavaScript for downloading the file (Web only)
        final blob = html.Blob([fileBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = 'blank'
          ..download =
              "Feed History_$formattedDate.xlsx" // Add current date to filename
          ..click();
        html.Url.revokeObjectUrl(url); // Clean up after download
      } else {
        print("Failed to encode Excel file.");
      }
    } catch (e) {
      print('Error exporting Excel: $e');
    }
  }
}
