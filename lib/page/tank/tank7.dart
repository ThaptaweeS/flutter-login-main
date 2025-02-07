import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/components/recent_files.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/widget/appbar/AppBar.dart';
import 'package:newmaster/widget/menu/side_menu.dart';

late BuildContext Tank7Context;

class Tank7 extends StatelessWidget {
  const Tank7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tank7Context = context;

    return Scaffold(appBar: AppBar(), body: Tank7body());
  }
}

class Tank7body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tank7 Page',
        style: GoogleFonts.ramabhadra(fontSize: 20),
      ),
    );
  }
}
