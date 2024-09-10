import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/page02.dart';

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
      height: 500,
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
              'Tank9 : Zinc Phosphate (PB-L3650X)',
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
        buildPumpControlContainer(
          context,
          'Pump PB-L3650X',
          () => sendDataToAPI1819(context, 'start', 'PB-181X'),
          () => sendDataToAPI1819(context, 'stop', 'PB-181X'),
        ),
        SizedBox(width: 16), // Space between the containers
        buildPumpControlContainer(
          context,
          'Pump AC-131',
          () => sendDataToAPIac9(context, 'start', 'AC-131'),
          () => sendDataToAPIac9(context, 'stop', 'AC-131'),
        ),
      ],
    );
  }

  Widget buildPumpTank10(BuildContext context) {
    return Container(
      height: 500,
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
        buildPumpControlContainer(
          context,
          'Pump AC-131',
          () => sendDataToAPIac10(context, 'start', 'AC-131'),
          () => sendDataToAPIac10(context, 'stop', 'AC-131'),
        ),
      ],
    );
  }

  Widget buildPumpControlContainer(
    BuildContext context,
    String title,
    VoidCallback onStart,
    VoidCallback onStop,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          SizedBox(height: 10),
          // Image.asset(
          //   'assets/icons/pumpandtank.svg', // Correct asset path
          //   width: 50,
          //   height: 50,
          // ),
          SizedBox(height: 10),
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
  }

  void sendDataToAPIac10(
      BuildContext context, String action, String pump) async {
    final url =
        'http://172.23.10.51:1111/acfeed10'; // Update this URL as needed

    try {
      final response = await http.post(Uri.parse(url), body: {
        'action': action,
        'pump': pump,
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

  void sendDataToAPIac9(
      BuildContext context, String action, String pump) async {
    final url = 'http://172.23.10.51:1111/acfeed9'; // Update this URL as needed

    try {
      final response = await http.post(Uri.parse(url), body: {
        'action': action,
        'pump': pump,
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

  void sendDataToAPI1819(
      BuildContext context, String action, String pump) async {
    final url =
        'http://172.23.10.51:1111/181feed9'; // Update this URL as needed

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'action': action,
          // 'pump': pump,
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
