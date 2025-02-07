import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/models/MyFiles.dart';

import '../../../constants.dart';

class FileInfoCard extends StatefulWidget {
  final CloudStorageInfo info;
  final Function(String)? tapping;
  final Function()? onTap;
  final double width;
  final double height;

  FileInfoCard({
    Key? key,
    this.tapping,
    required this.info,
    this.onTap,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _FileInfoCardState createState() => _FileInfoCardState();
}

class _FileInfoCardState extends State<FileInfoCard> {
  late Color iconColor;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    iconColor = Colors.transparent;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        iconColor = (iconColor == const Color.fromARGB(40, 158, 158, 158))
            ? widget.info.color2!
            : const Color.fromARGB(40, 158, 158, 158);
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
        if (widget.onTap != null) widget.onTap!();
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        height: widget.height,
        width: widget.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding * 0.55),
                  height: 40,
                  width: 40,
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
                      : SizedBox(height: defaultPadding),
                ),
                Icon(Icons.circle, color: iconColor),
              ],
            ),
            SizedBox(height: defaultPadding),
            Text(
              widget.info.tank ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.ramabhadra(
                fontSize: 16,
                // fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              widget.info.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.ramabhadra(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: defaultPadding / 2),
            Text(
              widget.info.totalStorage ?? '',
              style: GoogleFonts.ramabhadra(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: defaultPadding),
            if (widget.info.falValue != null &&
                widget.info.tempValue != null &&
                widget.info.FC4360value != null)
              _buildPieChartSection2(
                falValue: widget.info.falValue!,
                tempValue: widget.info.tempValue!,
                FC4360value: widget.info.FC4360value!,
                falColor: Colors.blueAccent,
                tempColor: Colors.greenAccent,
                falLabel: 'F.Al. ',
                tempLabel: 'Temp. ',
                FC4360Label: 'FC-4360 Refilled',
              ),
            if (widget.info.feValue != null && widget.info.conValue != null)
              _buildPieChartSection5(
                feValue: widget.info.feValue!,
                conValue: widget.info.conValue!,
                HCIValue: widget.info.HCIValue!,
                feColor: Colors.redAccent,
                conColor: Colors.orangeAccent,
                feLabel: 'Fe ',
                conLabel: 'Con. ',
                HCILable: 'HCI Refilled ',
              ),
            if (widget.info.talValue != null &&
                widget.info.phValue != null &&
                widget.info.PLZValue != null)
              _buildPieChartSection8(
                talValue: widget.info.talValue!,
                phValue: widget.info.phValue!,
                PLZValue: widget.info.PLZValue!,
                talColor: Colors.blueAccent,
                phColor: Colors.purpleAccent,
                talLabel: 'T.Al. ',
                phLabel: 'pH ',
                PLZLabel: 'PL-ZN Refilled. ',
              ),
            if (widget.info.taValue != null &&
                widget.info.faValue != null &&
                widget.info.arValue != null &&
                widget.info.acValue != null &&
                widget.info.tank9tempValue != null &&
                widget.info.pb3650Value != null &&
                widget.info.ac9Value != null)
              _buildPieChartSectionTank9(
                taValue: widget.info.taValue!,
                faValue: widget.info.faValue!,
                arValue: widget.info.arValue!,
                acValue: widget.info.acValue!,
                tank9tempValue: widget.info.tank9tempValue!,
                pb3650Value: widget.info.pb3650Value!,
                ac9Value: widget.info.ac9Value!,
                taColor: Colors.redAccent,
                faColor: Colors.purpleAccent,
                arColor: Colors.yellowAccent,
                acColor: Colors.lightBlueAccent,
                tank9tempColor: Colors.greenAccent,
                pb3650Color: Colors.orangeAccent,
                ac9Color: Colors.blueAccent,
                taLabel: 'T.A. ',
                faLabel: 'F.A. ',
                arLabel: 'A.R. ',
                acLabel: 'A.C. ',
                tank9tempLabel: 'Temp. ',
                pb3650Label: 'PB-3650X Refilled ',
                ac9Label: 'AC-131 Refilled. ',
              ),
            if (widget.info.taValue10 != null &&
                widget.info.faValue10 != null &&
                widget.info.arValue10 != null &&
                widget.info.acValue10 != null &&
                widget.info.tank10tempValue != null)
              _buildPieChartSectionTank10(
                taValue: widget.info.taValue10!,
                faValue: widget.info.faValue10!,
                arValue: widget.info.arValue10!,
                acValue: widget.info.acValue10!,
                tank10tempValue: widget.info.tank10tempValue!,
                taColor: Colors.redAccent,
                faColor: Colors.purpleAccent,
                arColor: Colors.yellowAccent,
                acColor: Colors.lightBlueAccent,
                tank10TempColor: Colors.greenAccent,
                taLabel: 'T.A. ',
                faLabel: 'F.A. ',
                arLabel: 'A.R. ',
                acLabel: 'A.C. ',
                tank10TempLabel: 'Temp. ',
              ),
            if (widget.info.conValue13 != null &&
                widget.info.faValue13 != null &&
                widget.info.tank13TempValue != null)
              _buildPieChartSectionTank13(
                conValue: widget.info.conValue13!,
                faValue: widget.info.faValue13!,
                tank13TempValue: widget.info.tank13TempValue!,
                conColor: Colors.orangeAccent,
                faColor: Colors.purpleAccent,
                tank13TempColor: Colors.greenAccent,
                faLabel: 'F.A. ',
                conLabel: 'Con. ',
                tank13TempLabel: 'Temp. ',
              ),
            if (widget.info.conValue14 != null &&
                widget.info.faValue14 != null &&
                widget.info.tank14TempValue != null)
              _buildPieChartSectionTank14(
                faValue: widget.info.faValue14!,
                conValue: widget.info.conValue14!,
                tank14TempValue: widget.info.tank14TempValue!,
                conColor: Colors.orangeAccent,
                faColor: Colors.purpleAccent,
                tank14TempColor: Colors.greenAccent,
                faLabel: 'F.A. ',
                conLabel: 'Con. ',
                tank14TempLabel: 'Temp. ',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartSection2({
    required double falValue,
    required double tempValue,
    required double FC4360value,
    required Color falColor,
    required Color tempColor,
    required String falLabel,
    required String tempLabel,
    required String FC4360Label,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Default alignment to the start (left)
      children: [
        Align(
          alignment: Alignment.topLeft, // Align to the left
          child: Text(
            '$falLabel',
            style: GoogleFonts.ramabhadra(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Align(
              alignment: Alignment.center, // Center alignment
              child: Text(
                '$falValue',
                style: GoogleFonts.ramabhadra(
                    fontSize: 35, color: Colors.blueAccent),
              ),
            ),
            SizedBox(width: 10),
            Align(
              alignment: Alignment.topRight, // Align to the left
              child: Text(
                'Pt.',
                style: GoogleFonts.ramabhadra(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 90), // Space between sections
        Column(
          children: [
            Align(
              alignment: Alignment.centerLeft, // Align to the left
              child: Text(
                '$tempLabel',
                style: GoogleFonts.ramabhadra(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SizedBox(height: 5),
            Row(
              children: [
                Align(
                  alignment: Alignment.center, // Center alignment
                  child: Text(
                    '$tempValue',
                    style: GoogleFonts.ramabhadra(
                        fontSize: 35, color: Colors.blueAccent),
                  ),
                ),
                SizedBox(width: 10),
                Align(
                  alignment: Alignment.topRight, // Align to the left
                  child: Text(
                    '°C',
                    style: GoogleFonts.ramabhadra(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 10),
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft, // Align to the left
              child: Text(
                '$FC4360Label',
                style: GoogleFonts.ramabhadra(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SizedBox(height: 5),
            Row(
              children: [
                Align(
                  alignment: Alignment.center, // Center alignment
                  child: Center(
                    child: Text(
                      '$FC4360value',
                      style: GoogleFonts.ramabhadra(
                          fontSize: 35, color: Colors.blueAccent),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Align(
                  alignment: Alignment.topRight, // Align to the left
                  child: Text(
                    'Kg.',
                    style: GoogleFonts.ramabhadra(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPieChartSection5(
      {required double feValue,
      required double conValue,
      required Color feColor,
      required Color conColor,
      required String feLabel,
      required String conLabel,
      required double HCIValue,
      required String HCILable}) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Default alignment to the start (left)
      children: [
        Align(
          alignment: Alignment.topLeft, // Align to the left
          child: Text(
            '$conLabel',
            style: GoogleFonts.ramabhadra(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Align(
              alignment: Alignment.center, // Center alignment
              child: Text(
                '$conValue',
                style: GoogleFonts.ramabhadra(
                    fontSize: 35, color: Colors.blueAccent),
              ),
            ),
            SizedBox(width: 10),
            Align(
              alignment: Alignment.topRight, // Align to the left
              child: Text(
                '%',
                style: GoogleFonts.ramabhadra(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 175),
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft, // Align to the left
              child: Text(
                '$HCILable.',
                style: GoogleFonts.ramabhadra(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SizedBox(height: 5),
            Row(
              children: [
                Align(
                  alignment: Alignment.center, // Center alignment
                  child: Center(
                    child: Text(
                      '$HCIValue',
                      style: GoogleFonts.ramabhadra(
                          fontSize: 35, color: Colors.blueAccent),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Align(
                  alignment: Alignment.topRight, // Align to the left
                  child: Text(
                    'Kg.',
                    style: GoogleFonts.ramabhadra(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPieChartSection8(
      {required double talValue,
      required double phValue,
      required Color talColor,
      required Color phColor,
      required String talLabel,
      required String phLabel,
      required double PLZValue,
      required String PLZLabel}) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Default alignment to the start (left)
      children: [
        Align(
          alignment: Alignment.topLeft, // Align to the left
          child: Text(
            '$phLabel',
            style: GoogleFonts.ramabhadra(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            // Spacer(), // Pushes content to the right
            Align(
              alignment: Alignment.center, // Right alignment within the Row
              child: Text(
                '$phValue'.toDouble().toStringAsFixed(1),
                style: GoogleFonts.ramabhadra(
                    fontSize: 35, color: Colors.blueAccent),
              ),
            ),
          ],
        ),
        SizedBox(height: 175),
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft, // Align to the left
              child: Text(
                '$PLZLabel',
                style: GoogleFonts.ramabhadra(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Align(
                  alignment: Alignment.center, // Center alignment
                  child: Center(
                    child: Text(
                      '$PLZValue',
                      style: GoogleFonts.ramabhadra(
                          fontSize: 35, color: Colors.blueAccent),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Align(
                  alignment: Alignment.topRight, // Align to the left
                  child: Text(
                    'Kg.',
                    style: GoogleFonts.ramabhadra(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPieChartSectionTank9({
    required double taValue,
    required double faValue,
    required double arValue,
    required double acValue,
    required double tank9tempValue,
    required double pb3650Value,
    required double ac9Value,
    required Color taColor,
    required Color faColor,
    required Color arColor,
    required Color acColor,
    required Color tank9tempColor,
    required Color pb3650Color,
    required Color ac9Color,
    required String taLabel,
    required String faLabel,
    required String arLabel,
    required String acLabel,
    required String tank9tempLabel,
    required String pb3650Label,
    required String ac9Label,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Center alignment for Column
      children: [
        // F.AL. Section
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '$taLabel',
            style: GoogleFonts.ramabhadra(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Text(
              '$taValue',
              style: GoogleFonts.ramabhadra(
                  fontSize: 35, color: Colors.blueAccent),
            ),
            SizedBox(width: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Pt.',
                style: GoogleFonts.ramabhadra(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '$acLabel',
            style: GoogleFonts.ramabhadra(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SizedBox(height: 5),
        Row(
          children: [
            Text(
              '$acValue',
              style: GoogleFonts.ramabhadra(
                  fontSize: 35, color: Colors.blueAccent),
            ),
            SizedBox(width: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Pt.',
                style: GoogleFonts.ramabhadra(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '$tank9tempLabel',
            style: GoogleFonts.ramabhadra(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SizedBox(height: 5),
        Row(
          children: [
            Text(
              '$tank9tempValue',
              style: GoogleFonts.ramabhadra(
                  fontSize: 35, color: Colors.blueAccent),
            ),
            SizedBox(width: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '°C',
                style: GoogleFonts.ramabhadra(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '$pb3650Label',
            style: GoogleFonts.ramabhadra(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Row(
          children: [
            Text(
              '$pb3650Value',
              style: GoogleFonts.ramabhadra(
                  fontSize: 35, color: Colors.blueAccent),
            ),
            SizedBox(width: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Kg.',
                style: GoogleFonts.ramabhadra(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '$ac9Label',
            style: GoogleFonts.ramabhadra(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Row(
          children: [
            Text(
              '$ac9Value',
              style: GoogleFonts.ramabhadra(
                  fontSize: 35, color: Colors.blueAccent),
            ),
            SizedBox(width: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Kg.',
                style: GoogleFonts.ramabhadra(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPieChartSectionTank10({
    required double taValue,
    required double faValue,
    required double arValue,
    required double acValue,
    required double tank10tempValue,
    required Color taColor,
    required Color faColor,
    required Color arColor,
    required Color acColor,
    required Color tank10TempColor,
    required String taLabel,
    required String faLabel,
    required String arLabel,
    required String acLabel,
    required String tank10TempLabel,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Center alignment for Column
      children: [
        // F.AL. Section
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'T.A.',
            style: GoogleFonts.ramabhadra(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Text(
              '$taValue',
              style: GoogleFonts.ramabhadra(
                  fontSize: 35, color: Colors.blueAccent),
            ),
            SizedBox(width: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Pt.',
                style: GoogleFonts.ramabhadra(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10), // Space between sections
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'A.C.',
            style: GoogleFonts.ramabhadra(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SizedBox(height: 5),
        Row(
          children: [
            Text(
              '$acValue',
              style: GoogleFonts.ramabhadra(
                  fontSize: 35, color: Colors.blueAccent),
            ),
            SizedBox(width: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Pt.',
                style: GoogleFonts.ramabhadra(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '$tank10TempLabel',
            style: GoogleFonts.ramabhadra(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SizedBox(height: 5),
        Row(
          children: [
            Text(
              '$tank10tempValue',
              style: GoogleFonts.ramabhadra(
                  fontSize: 35, color: Colors.blueAccent),
            ),
            SizedBox(width: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '°C',
                style: GoogleFonts.ramabhadra(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ), // Space between sections
      ],
    );
  }

  Widget _buildPieChartSectionTank13({
    required double conValue,
    required double faValue,
    required double tank13TempValue,
    required Color conColor,
    required Color faColor,
    required Color tank13TempColor,
    required String conLabel,
    required String faLabel,
    required String tank13TempLabel,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Default alignment to the start (left)
      children: [
        Align(
          alignment: Alignment.topLeft, // Align to the left
          child: Text(
            'Con.',
            style: GoogleFonts.ramabhadra(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Align(
              alignment: Alignment.center, // Center alignment
              child: Text(
                '$conValue',
                style: GoogleFonts.ramabhadra(
                    fontSize: 35, color: Colors.blueAccent),
              ),
            ),
            SizedBox(width: 10),
            Align(
              alignment: Alignment.topRight, // Align to the left
              child: Text(
                '%',
                style: GoogleFonts.ramabhadra(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPieChartSectionTank14({
    required double conValue,
    required double faValue,
    required double tank14TempValue,
    required Color conColor,
    required Color faColor,
    required Color tank14TempColor,
    required String conLabel,
    required String faLabel,
    required String tank14TempLabel,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Default alignment to the start (left)
      children: [
        Align(
          alignment: Alignment.topLeft, // Align to the left
          child: Text(
            'Con.',
            style: GoogleFonts.ramabhadra(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Align(
              alignment: Alignment.center, // Center alignment
              child: Text(
                '$conValue',
                style: GoogleFonts.ramabhadra(
                    fontSize: 35, color: Colors.blueAccent),
              ),
            ),
            SizedBox(width: 10),
            Align(
              alignment: Alignment.topRight, // Align to the left
              child: Text(
                '%',
                style: GoogleFonts.ramabhadra(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          color: color,
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: GoogleFonts.ramabhadra(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }
}
