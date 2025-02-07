import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/components/recent_files.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/widget/appbar/AppBar.dart';
import 'package:newmaster/widget/menu/side_menu.dart';

late BuildContext Tank11Context;

class Tank11 extends StatelessWidget {
  const Tank11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tank11Context = context;

    return Scaffold(appBar: AppBar(), body: Tank11body());
  }
}

class Tank11body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tank11 Page',
        style: GoogleFonts.ramabhadra(fontSize: 20),
      ),
    );
  }
}
