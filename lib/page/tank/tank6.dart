import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/components/recent_files.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/widget/appbar/AppBar.dart';
import 'package:newmaster/widget/menu/side_menu.dart';

late BuildContext Tank6Context;

class Tank6 extends StatelessWidget {
  const Tank6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tank6Context = context;

    return Scaffold(appBar: AppBar(), body: Tank6body());
  }
}

class Tank6body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tank6 Page',
        style: GoogleFonts.ramabhadra(fontSize: 20),
      ),
    );
  }
}
