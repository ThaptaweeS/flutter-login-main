import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/models/MyFiles.dart';
import 'package:newmaster/page/tank/tank1-data/pum-info.dart';

import '../../../constants.dart';

class Pumpinfo extends StatefulWidget {
  Pumpinfo({
    Key? key,
    this.tapping,
    required this.info,
  }) : super(key: key);

  final PumpdataInfo info;
  Function(String)? tapping;

  @override
  _PumpinfoState createState() => _PumpinfoState();
}

class _PumpinfoState extends State<Pumpinfo> {
  late Color iconColor;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    iconColor = Colors.black;
    timer = Timer.periodic(Duration(milliseconds: 700), (timer) {
      setState(() {
        iconColor = ((iconColor == const Color.fromARGB(33, 35, 49, 20))
            ? widget.info.color2
            : Color.fromARGB(33, 35, 49, 20))!;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.tapping?.call("tapping");
      },
      child: Container(
        padding: EdgeInsets.all(defaultPadding ?? 8.0),
        decoration: BoxDecoration(
          // color: secondaryColor ??
          //     Colors.blue, // Define secondaryColor or pass it as a parameter
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all((12 ?? 5.0) * 0.55),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: widget.info.color?.withOpacity(0.1) ??
                        Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: widget.info.svgSrc != null
                      ? SvgPicture.asset(
                          widget.info.svgSrc!,
                          colorFilter: ColorFilter.mode(
                              widget.info.color ?? Colors.black,
                              BlendMode.srcIn),
                        )
                      : SizedBox(), // Handle case where svgSrc is null
                ),
                Icon(Icons.circle, color: iconColor),
              ],
            ),
            Text(
              widget.info.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.ramabhadra(fontSize: 12.0),
            ),
            ProgressLine(
              percentage: widget.info.percentage,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.info.totalStorage ?? '',
                  style: GoogleFonts.ramabhadra(fontSize: 12.0),
                ),
                Text(
                  widget.info.numOfFiles ?? '',
                  style: GoogleFonts.ramabhadra(fontSize: 12.0),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

const Color primaryColor = Colors.blue; // Replace with your primary color

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  final int? percentage;

  @override
  Widget build(BuildContext context) {
    Color getColor(int percentage) {
      if (percentage >= 0 && percentage <= 20) {
        return Colors.red;
      } else if (percentage > 20 && percentage <= 50) {
        return Colors.orange;
      } else if (percentage > 50 && percentage <= 80) {
        return Colors.yellow;
      } else {
        return Colors.green;
      }
    }

    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) => Container(
                width: constraints.maxWidth * (percentage! / 100),
                height: 10,
                decoration: BoxDecoration(
                  color: getColor(percentage!),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ],
        ),
        Text(
          '$percentage%',
          style: GoogleFonts.ramabhadra(
            fontWeight: FontWeight.w200,
            fontSize: 12,
            color: getColor(percentage!),
          ),
        ),
      ],
    );
  }
}

//---------------------------------------------------------//

class Pumpinfo2 extends StatefulWidget {
  Pumpinfo2({
    Key? key,
    this.tapping,
    required this.info,
  }) : super(key: key);

  final PumpdataInfo2 info;
  Function(String)? tapping;

  @override
  _PumpinfoState2 createState() => _PumpinfoState2();
}

class _PumpinfoState2 extends State<Pumpinfo2> {
  late Color iconColor;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    iconColor = Colors.black;
    timer = Timer.periodic(Duration(milliseconds: 700), (timer) {
      setState(() {
        iconColor = ((iconColor == const Color.fromARGB(33, 35, 49, 20))
            ? widget.info.color2
            : Color.fromARGB(33, 35, 49, 20))!;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.tapping?.call("tapping");
      },
      child: Container(
        padding: EdgeInsets.all(defaultPadding ?? 8.0),
        decoration: BoxDecoration(
          // color: secondaryColor ??
          //     Colors.blue, // Define secondaryColor or pass it as a parameter
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all((defaultPadding ?? 8.0) * 0.55),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: widget.info.color?.withOpacity(0.1) ??
                        Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: widget.info.svgSrc != null
                      ? SvgPicture.asset(
                          widget.info.svgSrc!,
                          colorFilter: ColorFilter.mode(
                              widget.info.color ?? Colors.black,
                              BlendMode.srcIn),
                        )
                      : SizedBox(), // Handle case where svgSrc is null
                ),
                Icon(Icons.circle, color: iconColor),
              ],
            ),
            Text(
              widget.info.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.ramabhadra(fontSize: 12.0),
            ),
            ProgressLine(
              percentage: widget.info.percentage,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.info.totalStorage ?? '',
                  style: GoogleFonts.ramabhadra(fontSize: 12.0),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProgressLine2 extends StatelessWidget {
  const ProgressLine2({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
