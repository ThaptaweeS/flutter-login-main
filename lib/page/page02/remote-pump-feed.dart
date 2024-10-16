import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';
import 'package:newmaster/page/page02/tank10autofeed.dart';
import 'package:newmaster/page/page02/tank10autofeedpb181.dart';
import 'package:newmaster/page/page02/tank9autofeedac.dart';

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
            CuPage = P1DASHBOARDMAIN();
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
            PumpControlWidgetac9(),
          ],
        ),
      ),
    );
  }
}

Widget buildPumpControlRow10(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: PumpControlWidgetpb10(),
      ),
      SizedBox(width: 16),
      Expanded(
        child: PumpControlWidget(),
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
            'Tank10 : Zinc Phosphate (PB-181X)',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          SizedBox(height: 50),
          buildPumpControlRow10(context),
        ],
      ),
    ),
  );
}
