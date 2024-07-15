import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/page02.dart';

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
            CuPage = Page02body();
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
        title: Text("Feed History"),
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
  String selectedTank = ''; // Selected tank value for filtering
  String? selectedYear;
  String? selectedMonth;
  String? selectedDay;

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    final url = 'http://172.23.10.51:1111/chem-feed';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          tableData = responseData.cast<Map<String, dynamic>>();
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  List<Map<String, dynamic>> filterDataByDate(List<Map<String, dynamic>> data,
      String? year, String? month, String? day) {
    // Implement filtering logic based on selected date
    return data.where((item) {
      if (year != null && item['date'].startsWith(year)) {
        if (month != null && item['date'].substring(5, 7) != month) {
          return false;
        }
        if (day != null && item['date'].substring(8) != day) {
          return false;
        }
        return true;
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredData = filterDataByDate(
        tableData
            .where(
                (data) => selectedTank.isEmpty || data['tank'] == selectedTank)
            .toList(),
        selectedYear,
        selectedMonth,
        selectedDay);

    print('Selected tank: $selectedTank');
    print('Selected year: $selectedYear');
    print('Selected month: $selectedMonth');
    print('Selected day: $selectedDay');
    print('Filtered data length: ${filteredData.length}');

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(
                Icons.heat_pump,
                size: 36.0,
                color: Colors.white,
              ),
              title: Text(
                'Feed History : Dashboard',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            // Dropdown for filtering by tank value
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: selectedTank,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTank = newValue!;
                  });
                },
                items: <String>['', '1', '2'] // Add other tank values here
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text('Tank $value'),
                  );
                }).toList(),
              ),
            ),
            Row(
              children: [
                // Dropdown for selecting year
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: selectedYear,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedYear = newValue;
                      });
                    },
                    items: <String?>[
                      '',
                      '2024',
                      '2023'
                    ] // Add other year options here
                        .map<DropdownMenuItem<String>>((String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value ?? 'All'),
                      );
                    }).toList(),
                  ),
                ),
                // Dropdown for selecting month
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: selectedMonth,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue;
                      });
                    },
                    items: <String?>[
                      '',
                      '01',
                      '02',
                      '03',
                      '04',
                      '05',
                      '06',
                      '07',
                      '08',
                      '09',
                      '10',
                      '11',
                      '12'
                    ] // Add other month options here
                        .map<DropdownMenuItem<String>>((String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value ?? 'All'),
                      );
                    }).toList(),
                  ),
                ),
                // Dropdown for selecting day
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: selectedDay,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDay = newValue;
                      });
                    },
                    items: <String?>[
                      '',
                      '01',
                      '02',
                      '03',
                      '04',
                      '05',
                      '06',
                      '07',
                      '08',
                      '09',
                      '10',
                      '11',
                      '12',
                      '13',
                      '14',
                      '15',
                      '16',
                      '17',
                      '18',
                      '19',
                      '20',
                      '21',
                      '22',
                      '23',
                      '24',
                      '25',
                      '26',
                      '27',
                      '28',
                      '29',
                      '30',
                      '31'
                    ] // Add other day options here
                        .map<DropdownMenuItem<String>>((String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value ?? 'All'),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  primary: false,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Tank')),
                      DataColumn(label: Text('Detail')),
                      DataColumn(label: Text('Lot')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Value(Kg)')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Time')),
                    ],
                    rows: List<DataRow>.generate(filteredData.length, (index) {
                      return DataRow(
                        cells: [
                          DataCell(
                              Text(filteredData[index]['tank'].toString())),
                          DataCell(
                              Text(filteredData[index]['detail'].toString())),
                          DataCell(Text(filteredData[index]['lot'].toString())),
                          DataCell(
                              Text(filteredData[index]['name'].toString())),
                          DataCell(
                              Text(filteredData[index]['value'].toString())),
                          DataCell(
                              Text(filteredData[index]['date'].toString())),
                          DataCell(
                              Text(filteredData[index]['time'].toString())),
                        ],
                      );
                    }),
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
