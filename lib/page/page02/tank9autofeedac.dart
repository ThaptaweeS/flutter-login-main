import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/page/page02/barchartfeed.dart';

Widget buildPumpControlContainerac9(
  BuildContext context,
  String title,
  VoidCallback onStart,
  VoidCallback onStop,
) {
  TextEditingController _controller = TextEditingController();
  double ac9feedQuantity = 0.0; // Store quantity from TextFormField

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
                    ac9feedQuantity, // Display the updated feedQuantity
                feedAcual: ac9feedQuantity,
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
                  labelText: 'Quantity Feed (ml)',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  // Update feed quantity and refresh chart
                  setState(() {
                    ac9feedQuantity = double.tryParse(value) ?? 0.0;
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
                    sendDataToAPIac9(context, 'start', true, ac9feedQuantity);
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

void sendDataToAPIac9(BuildContext context, String action, bool pump,
    double pb181x9feedQuantity) async {
  final url = 'http://172.23.10.51:1111/acfeed9'; // Update as needed

  try {
    final response = await http.post(
      Uri.parse(url),
      body: {
        'Action': action,
        'Status': pump.toString(),
        'FeedQuantity': pb181x9feedQuantity.toString(),
      },
    );

    final message = response.statusCode == 200
        ? 'Action $action for Pump M-22 sent successfully with Feed Quantity: $pb181x9feedQuantity ml!'
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
