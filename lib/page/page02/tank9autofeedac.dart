import 'dart:async';
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/data/global.dart';

class PumpControlWidgetac9 extends StatefulWidget {
  @override
  _PumpControlWidgetac9State createState() => _PumpControlWidgetac9State();
}

class _PumpControlWidgetac9State extends State<PumpControlWidgetac9> {
  double feedActualac9 = 0.0;
  double feedTargetac9 = 0.0;
  double ac9feedQuantity = 0.0;
  List<double> reciveDataFromAPI = [];
  TextEditingController _controller = TextEditingController();
  Timer? _timer;
  int timeCounter = 0;

  @override
  void initState() {
    super.initState();
    startFetchingFeedActualData();
    _controller.text = feedData.ac9feedQuantity.toString();
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pump Control Container
        Expanded(
          child: buildPumpControlContainerac9(
            context,
            'AC-131 (PUMP M-55)',
            () => sendDataToAPIac9(
              // Update this line
              context,
              'Start',
              true,
              ac9feedQuantity,
            ),
            () => sendDataToAPIac9(
              // Update this line
              context,
              'Stop',
              false,
              ac9feedQuantity,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPumpControlContainerac9(
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
            boxShadow: const [
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
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                width: 150,
                child: PumpFeedChartac9(
                  feedActual: feedActualac9,
                  feedTarget: feedTargetac9,
                ),
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
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
                        feedData.ac9feedQuantity =
                            '${double.tryParse(value) ?? 0.0}';
                        print('Updated Quantity: ${feedData.ac9feedQuantity}');
                      });
                    }),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      sendDataToAPIac9(
                        context,
                        'start',
                        true,
                        ac9feedQuantity,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.green,
                      minimumSize: const Size(50, 60),
                    ),
                    child: const Text('Start'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: onStop,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.red,
                      minimumSize: const Size(50, 60),
                    ),
                    child: const Text('Stop'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void sendDataToAPIac9(BuildContext context, String action, bool pump,
      double ac9feedQuantity) async {
    final url = 'http://172.23.10.51:1111/acfeed9'; // Update this URL as needed

    try {
      print('sending data');
      final response = await http.post(
        Uri.parse(url),
        body: {
          'Action': action,
          'Status': pump.toString(),
          'FeedQuantity': feedData.ac9feedQuantity.toString(),
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final message = response.statusCode == 200
          ? 'Action $action for Pump M-55 sent successfully with Feed Quantity: $ac9feedQuantity kg!'
          : 'Failed to send action $action for Pump M-55';

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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        _timer?.cancel(); // Cancel the timer if the widget is not mounted
        return;
      }
      fetchFeedDataFromAPI().then((newData) {
        setState(() {
          feedActualac9 = newData['feedActual'] ?? 0.0; // Update feed actual
          feedTargetac9 = newData['feedTarget'] ?? 0.0; // Update feed target
          reciveDataFromAPI.add(timeCounter.toDouble()); // Update the X-axis
          timeCounter++;
        });
      });
    });
  }

  Future<Map<String, double>> fetchFeedDataFromAPI() async {
    const url =
        'http://172.23.10.51:1111/ac9acual'; // Update this URL as needed

    try {
      final response = await http.post(Uri.parse(url), body: {});

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body); // Decode the JSON response
        return {
          'feedActual': (data['feedActualac9'] ?? 0.0).toDouble(),
          'feedTarget': (data['feedTargetac9'] ?? 0.0).toDouble(),
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

@override
class PumpFeedChartac9 extends StatelessWidget {
  final double feedActual; // Feed actual data from API
  final double feedTarget; // Feed target (from TextField)

  const PumpFeedChartac9({
    // Add 'const' here
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
        gridData: const FlGridData(
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
