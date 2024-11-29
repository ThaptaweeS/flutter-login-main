import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Editdata extends StatefulWidget {
  const Editdata({super.key});

  @override
  State<Editdata> createState() => _Editdatatate();
}

class _Editdatatate extends State<Editdata> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: const Text('Data History'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            // Back action or navigation
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.blue[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTankButton(context, "Tank2", Colors.blue, "Edit2"),
                    _buildTankButton(context, "Tank5", Colors.green, "Edit5"),
                    _buildTankButton(context, "Tank8", Colors.yellow, "Edit8"),
                    _buildTankButton(context, "Tank9", Colors.orange, "Edit9"),
                    _buildTankButton(context, "Tank10", Colors.red, "Edit10"),
                    _buildTankButton(
                        context, "Tank13", Colors.purple, "Edit13"),
                    _buildTankButton(context, "Tank14", Colors.amber, "Edit14"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Select a tank to view data',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTankButton(
      BuildContext context, String tankName, Color color, String apiEndpoint) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TankTablePage(
                tankName: tankName,
                apiEndpoint: apiEndpoint,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: color,
          minimumSize: const Size(50, 60),
        ),
        child: Text(tankName),
      ),
    );
  }
}

class TankTablePage extends StatefulWidget {
  final String tankName;
  final String apiEndpoint;

  const TankTablePage(
      {Key? key, required this.tankName, required this.apiEndpoint})
      : super(key: key);

  @override
  _TankTablePageState createState() => _TankTablePageState();
}

class _TankTablePageState extends State<TankTablePage> {
  List<Map<String, dynamic>> tableData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final url = Uri.parse("http://172.23.10.51:1111/${widget.apiEndpoint}");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          tableData = List<Map<String, dynamic>>.from(data);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.tankName} Data Table'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Data')),
                    DataColumn(label: Text('Detail')),
                    DataColumn(label: Text('Round')),
                    DataColumn(label: Text('Value')),
                    DataColumn(label: Text('Range')),
                    DataColumn(label: Text('Username')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Time')),
                  ],
                  rows: tableData
                      .map(
                        (data) => DataRow(
                          cells: [
                            DataCell(Text(data['id'].toString())),
                            DataCell(Text(data['data'].toString())),
                            DataCell(Text(data['detail'].toString())),
                            DataCell(Text(data['round'].toString())),
                            DataCell(Text(data['value'].toString())),
                            DataCell(Text(data['range'].toString())),
                            DataCell(Text(data['username'].toString())),
                            DataCell(Text(data['date'].toString())),
                            DataCell(Text(data['time'].toString())),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
    );
  }
}
