import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/page/page02/barchartfeed.dart';

Timer? _timer;
double feedActualac10 = 0.0;
bool isFetching = false; // Flag to check if fetching is running


Widget buildPumpControlContainerac10(
  BuildContext context,
  String title,
  VoidCallback onStart,
  VoidCallback onStop,
) {
  TextEditingController _controller = TextEditingController();
  double ac10feedQuantity = 0.0; // Store quantity from TextFormField

  List<double> reciveDataFromAPI = [0]; // Example data from API
  double feedActual = 0.0;

  return StatefulBuilder(
    builder: (context, setState) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
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
              child: PumpFeedChart(
                feedQuantity:
                    ac10feedQuantity, // Display the updated feedQuantity
                feedAcual: ac10feedQuantity,
                recipeData: reciveDataFromAPI, // Data from API
              ),
            ),
            SizedBox(height: 20),

            // TextField for Quantity Feed Input
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
                    ac10feedQuantity = double.tryParse(value) ?? 0.0;
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
                    // onStart();
                    sendDataToAPIac10(context, 'start', true, ac10feedQuantity);
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

void sendDataToAPIac10(BuildContext context, String action, bool pump,
    double ac10feedQuantity) async {
  final url = 'http://172.23.10.51:1111/ac10'; // Update this URL as needed

  try {
    final response = await http.post(Uri.parse(url), body: {
      'Action': action,
      'Status': pump.toString(),
      'FeedQuantity': ac10feedQuantity.toString(),
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

void receiveDataToAPIac10(BuildContext context, String action, bool pump,
    double ac10feedQuantity) async {
  final url = 'http://172.23.10.51:1111/ac10acual'; // Update this URL as needed

  try {
    final response = await http.post(Uri.parse(url), body: {
      'feedActualac10': ac10feedQuantity.toString(),
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
