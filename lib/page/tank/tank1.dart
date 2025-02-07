import 'package:flutter/material.dart';
import 'package:newmaster/components/recent_files.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/page/resize/test.dart';
import 'package:newmaster/widget/appbar/AppBar.dart';
import 'package:newmaster/widget/menu/side_menu.dart';
import 'package:google_fonts/google_fonts.dart';
late BuildContext Tank1Context;

class Tank1 extends StatelessWidget {
  const Tank1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tank1Context = context;

    return Scaffold(appBar: AppBar(), body: Tank1body());
  }
}

class Tank1body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tank1 Page',
        style: GoogleFonts.ramabhadra(fontSize: 20),
      ),
    );
  }
}
