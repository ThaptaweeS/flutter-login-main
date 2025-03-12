import 'dart:async';
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/data/global.dart';

class PumpControlWidgetpb10 extends StatefulWidget {
  @override
  _PumpControlWidgetState createState() => _PumpControlWidgetState();
}

class _PumpControlWidgetState extends State<PumpControlWidgetpb10> {
  double feedActualpb10 = 0.0;
  double feedTargetpb10 = 0.0;
  double pb10feedQuantity = 0.0;
  List<double> reciveDataFromAPI = [];
  TextEditingController _controller = TextEditingController();
  Timer? _timer;
  int timeCounter = 0;

  @override
  void initState() {
    super.initState();
    startFetchingFeedActualData();
    _controller.text = feedData.pb10feedQuantity.toString();
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
          child: buildPumpControlContainer181X(
            context,
            'PB-181XR (PUMP M-23)',
            () => sendDataToAPIPB181X(context, 'start', true, pb10feedQuantity),
            () => sendDataToAPIPB181X(context, 'stop', false, pb10feedQuantity),
          ),
        ),
      ],
    );
  }

  Widget buildPumpControlContainer181X(
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

              // PumpFeedChart widget to show the feed data
              SizedBox(
                height: 250,
                width: 150,
                child: PumpFeedChartpb9(
                  feedActual: feedActualpb10, // Updated feed actual
                  feedTarget: feedTargetpb10, // Updated feed target
                ),
              ),
              SizedBox(height: 10),
              // SizedBox(
              //   width: 200,
              //   child: TextFormField(
              //     controller: _controller,
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration(
              //       labelText: 'Lot. Number',
              //       labelStyle: GoogleFonts.ramabhadra(color: Colors.black),
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
                      feedData.pb10feedQuantity =
                          '${double.tryParse(value) ?? 0.0}';
                      print('Updated Quantity: ${feedData.pb10feedQuantity}');
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
                      sendDataToAPIPB181X(
                          context, 'start', true, pb10feedQuantity);
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

  void sendDataToAPIPB181X(BuildContext context, String action, bool pump,
      double pb10feedQuantity) async {
    final url = 'http://127.0.0.1:1882/pb181x'; // Update this URL as needed

    try {
      final response = await http.post(Uri.parse(url), body: {
        'Action': action,
        'Status': pump.toString(),
        'FeedQuantity': feedData.pb10feedQuantity.toString(),
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final message = response.statusCode == 200
          ? 'Action $action for Pump M-23 sent successfully with Feed Quantity: $pb10feedQuantity kg!'
          : 'Failed to send action $action for Pump M-23';

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
      if (!mounted) {
        _timer?.cancel(); // Cancel the timer if the widget is not mounted
        return;
      }
      fetchFeedDataFromAPI().then((newData) {
        if (!mounted) return; // Double-check before calling setState

        setState(() {
          feedActualpb10 = newData['feedActual'] ?? 0.0; // Update feed actual
          feedTargetpb10 = newData['feedTarget'] ?? 0.0; // Update feed target
          reciveDataFromAPI.add(timeCounter.toDouble()); // Update the X-axis
          timeCounter++;
        });
      }).catchError((error) {
        if (!mounted) return;
        // Handle errors safely without calling setState unnecessarily
        // debugPrint("Error fetching data: $error");
      });
    });
  }

  Future<Map<String, double>> fetchFeedDataFromAPI() async {
    final url =
        'http://127.0.0.1:1882/pb181xacual'; // Update this URL as needed

    try {
      final response = await http.post(Uri.parse(url), body: {});

      print('Response status: API pb9acual code ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body); // Decode the JSON response
        return {
          'feedActual': (data['feedActualPB10'] ?? 0.0).toDouble(),
          'feedTarget': (data['feedTargetPB10'] ?? 0.0).toDouble(),
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
