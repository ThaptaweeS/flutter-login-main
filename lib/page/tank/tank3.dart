import 'package:flutter/material.dart';
import 'package:newmaster/components/recent_files.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/widget/appbar/AppBar.dart';
import 'package:newmaster/widget/menu/side_menu.dart';
import 'package:google_fonts/google_fonts.dart';
late BuildContext Tank3Context;

class Tank3 extends StatelessWidget {
  const Tank3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tank3Context = context;

    return Scaffold(appBar: AppBar(), body: Tank3body());
  }
}

class Tank3body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tank3 Page',
        style: GoogleFonts.ramabhadra(fontSize: 20),
      ),
    );
  }
}
