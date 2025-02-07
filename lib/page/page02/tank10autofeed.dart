import 'dart:async';
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class PumpControlWidget extends StatefulWidget {
  @override
  _PumpControlWidgetState createState() => _PumpControlWidgetState();
}

class _PumpControlWidgetState extends State<PumpControlWidget> {
  double feedActualac10 = 0.0;
  double feedTargetac10 = 0.0;
  double ac10feedQuantity = 0.0;
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
        SizedBox(width: 16), // Space between the containers
        Expanded(
          child: buildPumpControlContainerac10(
            context,
            'AC-131 (PUMP M-56)',
            () => sendDataToAPIac10(context, 'start', true, ac10feedQuantity),
            () => sendDataToAPIac10(context, 'stop', false, ac10feedQuantity),
          ),
        ),
      ],
    );
  }

  Widget buildPumpControlContainerac10(
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
                style:
                    GoogleFonts.ramabhadra(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 250,
                width: 150,
                child: PumpFeedChartac10(
                  feedActual: feedActualac10, // Actual feed data from API
                  feedTarget: feedTargetac10, // Quantity feed from TextField
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
              //       labelstyle: GoogleFonts.ramabhadra(color: Colors.black),
              //       border: OutlineInputBorder(),
              //     ),
              //     style: GoogleFonts.ramabhadra(color: Colors.black),
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
                    labelStyle: GoogleFonts.ramabhadra(color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.ramabhadra(color: Colors.black),
                  onChanged: (value) {
                    setState(() {
                      ac10feedQuantity = double.tryParse(value) ?? 0.0;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: onStart,
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

  // Function to send data to API when start/stop button is pressed
  void sendDataToAPIac10(BuildContext context, String action, bool pump,
      double ac10feedQuantity) async {
    final url = 'http://172.23.10.51:1111/ac10'; // Update this URL as needed

    try {
      final response = await http.post(Uri.parse(url), body: {
        'Action': action,
        'Status': pump.toString(),
        'FeedQuantity': ac10feedQuantity.toString(), // Send the feed quantity
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final message = response.statusCode == 200
          ? 'Action $action for Pump M-56 sent successfully!'
          : 'Failed to send action $action for $pump';

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  // Function to start fetching the feedActual data and updating the graph
  void startFetchingFeedActualData() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      fetchFeedDataFromAPI().then((newData) {
        setState(() {
          feedActualac10 = newData['feedActual'] ?? 0.0; // Update feed actual
          feedTargetac10 = newData['feedTarget'] ?? 0.0; // Update feed target
          reciveDataFromAPI
              .add(timeCounter.toDouble()); // Update the X-axis (seconds)
          timeCounter++;
        });
      });
    });
  }

  Future<Map<String, double>> fetchFeedDataFromAPI() async {
    const url =
        'http://172.23.10.51:1111/ac10acual'; // Update this URL as needed

    try {
      final response = await http.post(Uri.parse(url), body: {
        // Pass parameters if needed
      });

      // Print the status code and response body for debugging
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body); // Decode the JSON response
        // Print the received data for debugging
        // print('Received data: $data');

        return {
          'feedActual': (data['feedActualac10'] ?? 0.0).toDouble(),
          'feedTarget': (data['feedTargetac10'] ?? 0.0).toDouble(),
        };
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        return {
          // 'feedActual': 0.0, // Return default value on failure
          // 'feedTarget': 0.0, // Return default value on failure
        };
      }
    } catch (e) {
      print('Error: $e');
      return {
        // 'feedActual': 0.0, // Return default value if error occurs
        // 'feedTarget': 0.0, // Return default value if error occurs
      };
    }
  }
}

class PumpFeedChartac10 extends StatelessWidget {
  final double feedActual; // Feed actual data from API
  final double feedTarget; // Feed target (from TextField)

  PumpFeedChartac10({
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
                  style:
                      GoogleFonts.ramabhadra(color: Colors.black, fontSize: 10),
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
                  style:
                      GoogleFonts.ramabhadra(color: Colors.black, fontSize: 10),
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
