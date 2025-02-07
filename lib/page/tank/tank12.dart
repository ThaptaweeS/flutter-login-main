import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/components/recent_files.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/widget/appbar/AppBar.dart';
import 'package:newmaster/widget/menu/side_menu.dart';

late BuildContext Tank12Context;

class Tank12 extends StatelessWidget {
  const Tank12({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tank12Context = context;

    return Scaffold(appBar: AppBar(), body: Tank12body());
  }
}

class Tank12body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tank12 Page',
        style: GoogleFonts.ramabhadra(fontSize: 20),
      ),
    );
  }
}
