import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/page02.dart';
import 'package:newmaster/page/page02/barchartfeed.dart';

late BuildContext RemotefeedContext;

class Remotefeed extends StatelessWidget {
  const Remotefeed({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    RemotefeedContext = context;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            CuPage = Page02body();
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
        title: Center(
          child: Stack(
            children: <Widget>[
              // Stroked text as border.
              Text(
                'Remote Pump Feed Control',
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
                'Remote Pump Feed Control',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ),
      body: remotereedBody(),
    );
  }
}

class remotereedBody extends StatefulWidget {
  const remotereedBody({super.key});

  @override
  State<remotereedBody> createState() => _RemotefeedBodyState();
}

class _RemotefeedBodyState extends State<remotereedBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.blue[200]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: buildPumpTank9(context),
              ),
              SizedBox(width: 20), // Space between containers
              Expanded(
                child: buildPumpTank10(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPumpTank9(BuildContext context) {
    return Container(
      height: 650,
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tank9 : Zinc Phosphate (PB-3650X)',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 50),
            buildPumpControlRow9(context),
          ],
        ),
      ),
    );
  }

  Widget buildPumpControlRow9(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    double ac9feedQuantity = 0.0;
    double pb181x9feedQuantity = 0.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: buildPumpControlContainer1819(
            context,
            'PB-3650XM (PUMP M-22)',
            () => sendDataToAPI1819(context, 'start', true, ac9feedQuantity),
            () => sendDataToAPI1819(context, 'stop', false, ac9feedQuantity),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: buildPumpControlContainerac9(
            context,
            'AC-131 (PUMP M-55)',
            () => sendDataToAPIac9(context, 'start', true, pb181x9feedQuantity),
            () => sendDataToAPIac9(context, 'stop', false, pb181x9feedQuantity),
          ),
        ),
      ],
    );
  }

  Widget buildPumpTank10(BuildContext context) {
    return Container(
      height: 650,
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tank10 : Zinc Phosphate (PB-181X(M))',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 50),
            buildPumpControlRow(context),
          ],
        ),
      ),
    );
  }

  Widget buildPumpControlRow(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    double ac10feedQuantity = 0.0;
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
        )
      ],
    );
  }

  // Widget buildPumpdata(BuildContext context) {
  //   return SizedBox(
  //       width: 200,
  //       child: TextFormField(
  //         decoration: InputDecoration(
  //           labelText: 'Quantity Feed',
  //           labelStyle: TextStyle(color: Colors.black),
  //           border: OutlineInputBorder(),
  //         ),
  //         style: TextStyle(color: Colors.black),
  //       ));
  // }

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

  Widget buildPumpControlContainer1819(
    BuildContext context,
    String title,
    VoidCallback onStart,
    VoidCallback onStop,
  ) {
    TextEditingController _controller = TextEditingController();
    double pb181x9feedQuantity = 0.0;

    List<double> reciveDataFromAPI = [0];
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
                      pb181x9feedQuantity, // Display the updated feedQuantity
                  feedAcual: pb181x9feedQuantity,
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
                      pb181x9feedQuantity =
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
                      // onStart();
                      sendDataToAPI1819(
                          context, 'start', true, pb181x9feedQuantity);
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

  Widget buildPumpControlContainerac10(
    BuildContext context,
    String title,
    VoidCallback onStart,
    VoidCallback onStop,
  ) {
    TextEditingController _controller = TextEditingController();
    double ac10feedQuantity = 0.0; // Store quantity from TextFormField

    List<double> feedActualac10 = [100]; // Example data from API

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
                  recipeData: feedActualac10, // Data from API
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
                      sendDataToAPIac10(
                          context, 'start', true, ac10feedQuantity);
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

  Future<void> receiveDataFromAPIac10() async {
    final url = 'http://172.23.10.51:1111/ac10'; // Node-RED endpoint

    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        // Assuming Node-RED sends back data like this: {"feedActualac10": [100, 200, 300]}
        List<int> fetchedData =
            List<int>.from(data['feedActualac10'].map((item) => item as int));

        // Convert the fetched integer data to List<double> for the chart
        List<double> convertedData =
            fetchedData.map((e) => e.toDouble()).toList();

        // Update the state with the new data (as List<double>)
        setState(() {
          List<double> feedActualac10 = [];
        });

        // Show the fetched integer data in the debug console
        print('Received integer data from Node-RED: $fetchedData');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Received data from Node-RED: $fetchedData'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to receive data: ${response.statusCode}'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
      print('Error receiving data from Node-RED: $e');
    }
  }

  void sendDataToAPIac9(BuildContext context, String action, bool pump,
      double ac9feedQuantity) async {
    final url = 'http://172.23.10.51:1111/acfeed9'; // Update this URL as needed

    try {
      final response = await http.post(Uri.parse(url), body: {
        'Action': action,
        'Status': pump.toString(),
        'FeedQuantity': ac9feedQuantity.toString(),
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final message = response.statusCode == 200
          ? 'Action $action for Pump M-55 sent successfully with Feed Quantity: $ac9feedQuantity ml!'
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

  void sendDataToAPI1819(BuildContext context, String action, bool pump,
      double pb181x9feedQuantity) async {
    final url =
        'http://172.23.10.51:1111/181feed9'; // Update this URL as needed

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
}
