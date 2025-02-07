import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/page/page2-data/autofeed-input.dart';

import '../bloc/BlocEvent/ChangePageEvent.dart';
import '../data/global.dart';
import '../mainBody.dart';
import 'page2-data/feed-history.dart';
import 'page2-data/manual-process.dart';

late BuildContext Page02Context;

class Page02 extends StatelessWidget {
  const Page02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Page02Context = context;
    return Page02body();
  }
}

class Page02body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          color: Colors.indigo[50],
          // begin: Alignment.topCenter,
          // end: Alignment.bottomCenter,
          // ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    CuPage = Page02Autobody();
                    MainBodyContext.read<ChangePage_Bloc>()
                        .add(ChangePage_nodrower());
                  },
                  icon: Icon(Icons.fact_check_outlined),
                  label: Text('Data Input'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    minimumSize: Size(180, 80),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    CuPage = Manualfeed();
                    MainBodyContext.read<ChangePage_Bloc>()
                        .add(ChangePage_nodrower());
                  },
                  icon: Icon(Icons.fiber_smart_record_outlined),
                  label: Text('Manual Feed'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    minimumSize: Size(180, 80),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    CuPage = FeedHistory();
                    MainBodyContext.read<ChangePage_Bloc>()
                        .add(ChangePage_nodrower());
                  },
                  icon: Icon(Icons.fiber_smart_record_outlined),
                  label: Text('Feed History'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    minimumSize: Size(180, 80),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showPopup(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(" "),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.ramabhadra(
            fontSize: 18,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
        ],
      );
    },
  );
}
