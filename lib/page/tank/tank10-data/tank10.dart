import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/P01DASHBOARD/P01DASHBOARD.dart';
import 'package:newmaster/page/page2-data/autofeed-input.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/page/tank/Tank10-data/layout-chart.dart';
import 'package:newmaster/page/tank/Tank10-data/layout-chart2-2.dart';
import 'package:newmaster/page/tank/Tank10-data/layout-chart2.dart';
import 'package:newmaster/page/tank/tank10.dart';

late BuildContext Tank10Context;
late BuildContext Page02Context;

class Tank10 extends StatelessWidget {
  const Tank10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tank10Context = context;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            CuPage = P1DASHBOARDMAIN();
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
      ),
      body: Tank10Body(),
    );
  }
}

class Tank10Body extends StatefulWidget {
  const Tank10Body({Key? key}) : super(key: key);

  @override
  _Tank10BodyState createState() => _Tank10BodyState();
}

class _Tank10BodyState extends State<Tank10Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(),
            SizedBox(height: defaultPadding),
            ChartSection1(),
            SizedBox(height: defaultPadding),
            ChartSection2(),
            SizedBox(height: defaultPadding),
            ChartSection3(),
            SizedBox(height: defaultPadding),
            ChartSection4(),
          ],
        ),
      ),
    );
  }
}

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showTextPopup(context),
      child: ListTile(
        leading: Icon(
          Icons.storage,
          size: 24.0,
          color: Colors.white,
        ),
        title: Text(
          'Zinc Phosphate(PB-181X(6700L)) : Dashboard',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _showTextPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail'),
          content: Text(
            '',
            style: TextStyle(fontSize: 13.0),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class ChartSection1 extends StatelessWidget {
  const ChartSection1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: Chart133()),
        SizedBox(width: defaultPadding),
        Expanded(flex: 3, child: Chart13()),
      ],
    );
  }
}

class ChartSection2 extends StatelessWidget {
  const ChartSection2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: Chart134()),
        SizedBox(width: defaultPadding),
        Expanded(flex: 3, child: Chart135()),
      ],
    );
  }
}

class ChartSection3 extends StatelessWidget {
  const ChartSection3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: Chart136()),
        SizedBox(width: defaultPadding),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 140),
              CustomButton(
                onPressed: () {
                  CuPage = Page02Autobody();
                  MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
                },
                icon: Icons.add_to_photos_outlined,
                label: 'Data Input',
                backgroundColor: Color.fromARGB(255, 175, 184, 38),
              ),
              SizedBox(height: 25),
              CustomButton(
                onPressed: () {
                  CuPage = Tank10BodyPage();
                  MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
                },
                icon: Icons.fact_check_outlined,
                label: 'Data History',
                backgroundColor: Color.fromARGB(255, 15, 161, 130),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChartSection4 extends StatelessWidget {
  const ChartSection4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Chart21()),
        SizedBox(width: defaultPadding),
        Expanded(flex: 2, child: Chart25()),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor,
        minimumSize: Size(120, 60),
      ),
    );
  }
}
