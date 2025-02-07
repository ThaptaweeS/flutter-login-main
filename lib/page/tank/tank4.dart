import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/components/recent_files.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/widget/appbar/AppBar.dart';
import 'package:newmaster/widget/menu/side_menu.dart';

late BuildContext Tank4Context;

class Tank4 extends StatelessWidget {
  const Tank4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tank4Context = context;

    return Scaffold(appBar: AppBar(), body: Tank4body());
  }
}

class Tank4body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Data History Page',
        style: GoogleFonts.ramabhadra(fontSize: 20),
      ),
    );
  }
}
