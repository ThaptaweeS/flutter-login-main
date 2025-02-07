import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/BlocEvent/ChangePageEvent.dart';
import '../data/global.dart';
import '../mainBody.dart';
import 'TEST.dart';
import 'page01.dart';
import 'page02.dart';
import 'page3.dart';

bool isChecked = false;

class Page0 extends StatelessWidget {
  const Page0({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page01body();
  }
}

class Page0Body extends StatelessWidget {
  const Page0Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome to Chemical Monitoring',
            style: GoogleFonts.ramabhadra(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Monitor your chemicals here.',
            style: GoogleFonts.ramabhadra(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add functionality to navigate to the monitoring page
              // You can use Navigator.push to navigate to the next page.
              CuPage = Page01();
              MainBodyContext.read<ChangePage_Bloc>()
                  .add(ChangePage_nodrower());
            },
            child: Text('Start Monitoring'),
          ),
        ],
      ),
    );
  }
}
