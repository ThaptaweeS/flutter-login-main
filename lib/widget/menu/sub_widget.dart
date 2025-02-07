import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../data/global.dart';
import '../../mainBody.dart';

class menu_normal extends StatelessWidget {
  menu_normal(
      {Key? key, this.name, this.icon, required this.page, required this.Lv})
      : super(key: key);
  String? name;
  Widget page;
  String? icon;
  int Lv;

  @override
  Widget build(BuildContext context) {
    String _name = name ?? "";
    String _icon = icon ?? "";

    return InkWell(
      onTap: () {
        // BlocProvider.of<SwPageCubit>(context).togglePage(page);
        CuPage = page;
        CuPageLV = Lv;
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage());
      },
      child: Container(
        //color: Colors.blue,
        height: 50,
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 35, 11, 84),
                    image: DecorationImage(
                      image: AssetImage("" + _icon),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  )),
            ),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "   " + _name,
                  style: GoogleFonts.ramabhadra(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
