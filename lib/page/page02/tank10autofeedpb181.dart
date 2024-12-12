import 'dart:async';
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PumpControlWidgetpb10 extends StatefulWidget {
  @override
  _PumpControlWidgetState createState() => _PumpControlWidgetState();
}

class _PumpControlWidgetState extends State<PumpControlWidgetpb10> {
  double feedActualpb9 = 0.0;
  double feedTargetpb9 = 0.0;
  double pb9feedQuantity = 0.0;
  List<double> reciveDataFromAPI = [];
  TextEditingController _controller = TextEditingController();
  Timer? _timer;
  int timeCounter = 0;

  @override
  void initState() {
    super.initState();
    startFetchingFeedActualData(); // Start fetching data for the graph
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when no longer needed
    _timer?.cancel(); // Cancel the timer when disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildPumpControlRow(context);
  }

  Widget buildPumpControlRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(width: 16), // Space between the containers
        Expanded(
          child: buildPumpControlContainer3650(
            context,
            'PB-181XR (PUMP M-23)',
            () => sendDataToAPIPB3650(context, 'start', true, pb9feedQuantity),
            () => sendDataToAPIPB3650(context, 'stop', false, pb9feedQuantity),
          ),
        ),
      ],
    );
  }

  Widget buildPumpControlContainer3650(
    BuildContext context,
    String title,
    VoidCallback onStart,
    VoidCallback onStop,
  ) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 10),

              // PumpFeedChart widget to show the feed data
              SizedBox(
                height: 250,
                width: 150,
                child: PumpFeedChartpb9(
                  feedActual: feedActualpb9, // Updated feed actual
                  feedTarget: feedTargetpb9, // Updated feed target
                ),
              ),
              // SizedBox(height: 10),
              // SizedBox(
              //   width: 200,
              //   child: TextFormField(
              //     controller: _controller,
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration(
              //       labelText: 'Lot. Number',
              //       labelStyle: TextStyle(color: Colors.black),
              //       border: OutlineInputBorder(),
              //     ),
              //     style: TextStyle(color: Colors.black),
              //     onChanged: (value) {
              //       setState(() {
              //         // LotNumber = double.tryParse(value) ?? 0.0;
              //       });
              //     },
              //   ),
              // ),
              SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Quantity Feed (kg)',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    // Update feed quantity and refresh chart
                    setState(() {
                      pb9feedQuantity =
                          double.tryParse(_controller.text) ?? 0.0;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),

              // Control buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Call the onStart method and pass the feedQuantity value
                      sendDataToAPIPB3650(
                          context, 'start', true, pb9feedQuantity);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.green,
                      minimumSize: Size(50, 60),
                    ),
                    child: Text('Start'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: onStop,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.red,
                      minimumSize: Size(50, 60),
                    ),
                    child: Text('Stop'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void sendDataToAPIPB3650(BuildContext context, String action, bool pump,
      double ac9feedQuantity) async {
    final url = 'http://172.23.10.51:1111/pb36509'; // Update this URL as needed

    try {
      final response = await http.post(Uri.parse(url), body: {
        'Action': action,
        'Status': pump.toString(),
        'FeedQuantity': pb9feedQuantity.toString(),
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final message = response.statusCode == 200
          ? 'Action $action for Pump M-22 sent successfully with Feed Quantity: $pb9feedQuantity kg!'
          : 'Failed to send action $action for Pump M-22';

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  void startFetchingFeedActualData() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      fetchFeedDataFromAPI().then((newData) {
        setState(() {
          feedActualpb9 = newData['feedActual'] ?? 0.0; // Update feed actual
          feedTargetpb9 = newData['feedTarget'] ?? 0.0; // Update feed target
          reciveDataFromAPI.add(timeCounter.toDouble()); // Update the X-axis
          timeCounter++;
        });
      });
    });
  }

  Future<Map<String, double>> fetchFeedDataFromAPI() async {
    final url =
        'http://172.23.10.51:1111/pb9acual'; // Update this URL as needed

    try {
      final response = await http.post(Uri.parse(url), body: {});

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body); // Decode the JSON response
        return {
          'feedActual': (data['feedActualPB9'] ?? 0.0).toDouble(),
          'feedTarget': (data['feedTargetPB9'] ?? 0.0).toDouble(),
        };
      } else {
        return {
          'feedActual': 0.0,
          'feedTarget': 0.0,
        };
      }
    } catch (e) {
      return {
        'feedActual': 0.0,
        'feedTarget': 0.0,
      };
    }
  }
}

class PumpFeedChartpb9 extends StatelessWidget {
  final double feedActual; // Feed actual data from API
  final double feedTarget; // Feed target (from TextField)

  PumpFeedChartpb9({
    required this.feedActual,
    required this.feedTarget,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: feedTarget > 0
            ? feedTarget
            : 0, // Set the max Y value based on feedTarget
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black, width: 1),
        ),
        titlesData: FlTitlesData(
          show: true,
          // Y-axis Titles (FeedTarget in kg)
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 40,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()} sec', // Show FeedTarget as kg
                  style: TextStyle(color: Colors.black, fontSize: 10),
                );
              },
            ),
          ),
          // X-axis Titles (feedActual in seconds)
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${feedActual.toInt()} sec', // Show FeedActual as seconds
                  style: TextStyle(color: Colors.black, fontSize: 10),
                );
              },
            ),
          ),
        ),
        // Bar chart data
        gridData: FlGridData(
            show: true, drawHorizontalLine: true, drawVerticalLine: true),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: feedActual,
                color: Colors.blue,
                width: 60,
                borderRadius: BorderRadius.zero,
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: feedTarget,
                  color: Colors.grey.withOpacity(0.5),
                ),
                // ปรับ tooltip ให้อยู่ภายในกราฟแท่ง
                rodStackItems: [
                  BarChartRodStackItem(
                    0,
                    feedActual,
                    Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
