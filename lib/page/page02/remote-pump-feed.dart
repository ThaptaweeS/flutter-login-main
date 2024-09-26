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
      body: const remotereedBody(),
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
          padding: const EdgeInsets.all(16.0),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: buildPumpControlContainer(
            context,
            'AC-131 (PUMP M-55)',
            () => sendDataToAPIac9(context, 'start', true),
            () => sendDataToAPIac9(context, 'stop', false),
          ),
        ),
        SizedBox(width: 16), // Space between the containers
        Expanded(
          child: buildPumpControlContainer(
            context,
            'PB-3650XM (PUMP M-22)',
            () => sendDataToAPI1819(context, 'start', true),
            () => sendDataToAPI1819(context, 'stop', false),
          ),
        )
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16), // Space between the containers
        Expanded(
          child: buildPumpControlContainer(
            context,
            'AC-131 (PUMP M-56)',
            () => sendDataToAPIac10(context, 'start', true),
            () => sendDataToAPIac10(context, 'stop', false),
          ),
        )
      ],
    );
  }

  Widget buildPumpdata(BuildContext context) {
    return SizedBox(
        width: 200,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Quantity Feed',
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(),
          ),
          style: TextStyle(color: Colors.black),
        ));
  }

  Widget buildPumpControlContainer(
    BuildContext context,
    String title,
    VoidCallback onStart,
    VoidCallback onStop,
  ) {
    TextEditingController _controller = TextEditingController();
    double feedQuantity = 0.0; // Store quantity from TextFormField
    List<double> reciveDataFromAPI = [120]; // Example data from API

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
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              SizedBox(height: 10),

              // PumpFeedChart widget to show the feed data
              SizedBox(
                height: 150,
                width: 150,
                child: PumpFeedChart(
                  feedQuantity: feedQuantity,
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
                      feedQuantity = double.tryParse(value) ?? 0.0;
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

  void sendDataToAPIac10(BuildContext context, String action, bool pump) async {
    final url = 'http://172.23.10.51:1111/ac10'; // Update this URL as needed

    try {
      final response = await http.post(Uri.parse(url), body: {
        'Action': action,
        'Status': pump.toString(),
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final message = response.statusCode == 200
          ? 'Action $action for $pump sent successfully!'
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

  void sendDataToAPIac9(BuildContext context, String action, bool pump) async {
    final url = 'http://172.23.10.51:1111/acfeed9'; // Update this URL as needed

    try {
      final response = await http.post(Uri.parse(url), body: {
        'Action': action,
        'Status': pump.toString(),
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final message = response.statusCode == 200
          ? 'Action $action for $pump sent successfully!'
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

  void sendDataToAPI1819(BuildContext context, String action, bool pump) async {
    final url =
        'http://172.23.10.51:1111/181feed9'; // Update this URL as needed

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'Action': action,
          'Status': pump.toString(),
        },
      );

      final message = response.statusCode == 200
          ? 'Action $action for $pump sent successfully!'
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
}
