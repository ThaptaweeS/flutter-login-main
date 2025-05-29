import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/models/MyFiles.dart';
import 'package:newmaster/presentation/widgets/LineGaugeTank.dart';

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
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    iconColor = Colors.transparent;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        iconColor = (iconColor == const Color.fromARGB(40, 158, 158, 158))
            ? widget.info.color2!
            : const Color.fromARGB(40, 158, 158, 158);
        // CloudStorageInfo cloudStorageInfo = widget.info;
        // widget.info.taValue = cloudStorageInfo.taValue;
        // widget.info.faValue = cloudStorageInfo.faValue;
        // widget.info.arValue = cloudStorageInfo.arValue;
        // widget.info.acValue = cloudStorageInfo.acValue;
        // widget.info.tank9tempValue = cloudStorageInfo.tank9tempValue;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.white, Colors.blueAccent],
            center: Alignment.center, // จุดศูนย์กลาง
            radius: 3, // ขนาดการไล่สี (1.0 = เต็มพื้นที่)
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding * 0.55),
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                    color: widget.info.color?.withOpacity(0.1) ??
                        Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.info.tank ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.ramabhadra(
                      fontSize: 11,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // child: widget.info.svgSrc != null
                  //     ? SvgPicture.asset(
                  //         widget.info.svgSrc!,
                  //         colorFilter: ColorFilter.mode(
                  //             widget.info.color ?? Colors.black,
                  //             BlendMode.srcIn),
                  //       )
                  // : SizedBox(height: defaultPadding),
                ),
                Icon(Icons.circle, color: iconColor),
              ],
            ),
            // SizedBox(height: defaultPadding),
            // Text(
            //   widget.info.tank ?? '',
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            //   style: GoogleFonts.ramabhadra(
            //     fontSize: 16,
            //     // fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //   ),
            // ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.info.totalStorage ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ramabhadra(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  widget.info.title ?? '',
                  style: GoogleFonts.ramabhadra(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            // Text(
            //   widget.info.title ?? '',
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            //   style: GoogleFonts.ramabhadra(
            //     fontSize: 14,
            //     color: Colors.white,
            //   ),
            // ),
            // SizedBox(height: defaultPadding / 2),
            // Text(
            //   widget.info.totalStorage ?? '',
            //   style: GoogleFonts.ramabhadra(
            //     fontSize: 12,
            //     color: Colors.white,
            //   ),
            // ),
            SizedBox(height: defaultPadding),
            if (widget.info.falValue != null && widget.info.tempValue != null)
              // widget.info.FC4360value != null)
              // print("Building LineGaugeTank: falValue=${ widget.info.falValue}, tempValue=${ widget.info.tempValue}")
              _buildPieChartSection2(
                falValue: widget.info.falValue!,
                tempValue: widget.info.tempValue!,
                // FC4360value: widget.info.FC4360value!,
                falColor: Colors.red,
                tempColor: Colors.greenAccent,
                falLabel: 'F.Al. :',
                tempLabel: 'Temperature :',
                // FC4360Label: 'FC-4360 Refilled',
                Label: 'Temperature :',
                tankValue: widget.info.tempValue!,
                Unit1: 'Pt.',
                Unit2: '°C',
                // print("Building LineGaugeTank: falValue=${falValue}, tempValue=${tempValue}, FC4360value=${FC4360value}");
              ),
            if (widget.info.feValue != null && widget.info.conValue != null)
              _buildPieChartSection5(
                feValue: widget.info.feValue!,
                conValue: widget.info.conValue!,
                // HCIValue: widget.info.HCIValue!,
                feColor: Colors.redAccent,
                conColor: Colors.orangeAccent,
                feLabel: 'Fe :',
                conLabel: 'Con. :',
                HCILable: 'HCI Refilled ',
                Label: 'Con :',
                Label2: 'Fe :',
                Unit: '%',
              ),
            if (widget.info.talValue != null && widget.info.phValue != null)
              _buildPieChartSection8(
                talValue: widget.info.talValue!,
                phValue: widget.info.phValue!,
                // PLZValue: widget.info.PLZValue!,
                talColor: Colors.blueAccent,
                phColor: Colors.purpleAccent,
                talLabel: 'T.Al. :',
                phLabel: 'pH :',
                // PLZLabel: 'PL-ZN Refilled. ',
                Unit: 'Pt.',
              ),
            if (widget.info.taValue != null &&
                widget.info.faValue != null &&
                widget.info.arValue != null &&
                widget.info.acValue != null &&
                widget.info.tank9tempValue != null)
              _buildPieChartSectionTank9(
                taValue: widget.info.taValue ?? 0.0,
                faValue: widget.info.faValue ?? 0.0,
                arValue: widget.info.arValue ?? 0.0,
                acValue: widget.info.acValue ?? 0.0,
                tank9tempValue: widget.info.tank9tempValue ?? 0.0,
                taLabel: 'T.A. :',
                faLabel: 'F.A. :',
                arLabel: 'A.R. :',
                acLabel: 'A.C. :',
                tank9tempLabel: 'Temperature :',
                Unit: 'Pt.',
                Unit2: '°C',
              ),

            if (widget.info.taValue10 != null &&
                widget.info.faValue10 != null &&
                widget.info.arValue10 != null &&
                widget.info.acValue10 != null &&
                widget.info.tank10tempValue != null)
              _buildPieChartSectionTank10(
                taValue10: widget.info.taValue10!,
                faValue10: widget.info.faValue10!,
                arValue10: widget.info.arValue10!,
                acValue10: widget.info.acValue10!,
                tank10tempValue: widget.info.tank10tempValue!,
                taColor: Colors.redAccent,
                faColor: Colors.purpleAccent,
                arColor: Colors.yellowAccent,
                acColor: Colors.lightBlueAccent,
                tank10TempColor: Colors.greenAccent,
                taLabel: 'T.A. :',
                faLabel: 'F.A. :',
                arLabel: 'A.R. :',
                acLabel: 'A.C. :',
                tank10TempLabel: 'Temperature :',
                Unit: 'Pt.',
                Unit2: '°C',
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
                faLabel: 'F.A. :',
                conLabel: 'Con. :',
                tank13TempLabel: 'Temperature :',
                Unit: 'Pt.',
                Unit2: '°C',
                Unit3: '%',
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
                faLabel: 'F.A. :',
                conLabel: 'Con. :',
                tank14TempLabel: 'Temperature :',
                Unit: 'Pt.',
                Unit2: '°C',
                Unit3: '%',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartSection2({
    required double falValue,
    required double tempValue,
    // required double FC4360value,
    required Color falColor,
    required Color tempColor,
    required String falLabel,
    required String tempLabel,
    // required String FC4360Label,
    required String Label,
    required double tankValue,
    required String Unit1,
    required String Unit2,
  }) {
    // print('Tank2 FAL: $falValue');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 80,
              alignment: Alignment.center,
              child: falValue == null || falValue == 0.0 || falValue == 0
                  ? const Center(child: CircularProgressIndicator())
                  : LineGaugeTank(
                      Label: falLabel,
                      value: falValue,
                      Unit: Unit1,
                      min: 25,
                      max: 45,
                      sp: 33,
                      isRadialGauge: true,
                      isFalScale: true,
                      showThreshold: true,
                    ),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center, // Center alignment
                  child: tempValue == null || tempValue == 0.0 || tempValue == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: Label,
                          value: tempValue,
                          Unit: Unit2,
                          min: 40,
                          max: 95,
                          sp: 65,
                          isRadialGauge: true,
                          isTempScale: true,
                        ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPieChartSection5({
    required double feValue,
    required double conValue,
    required Color feColor,
    required Color conColor,
    required String feLabel,
    required String conLabel,
    // required double HCIValue,
    required String HCILable,
    required String Label,
    required String Label2,
    required String Unit,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Default alignment to the start (left)
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 80,
              decoration: BoxDecoration(),
              alignment: Alignment.center,
              child: conValue == null || conValue == 0.0 || conValue == 0
                  ? const Center(child: CircularProgressIndicator())
                  : LineGaugeTank(
                      Label: Label,
                      value: conValue,
                      Unit: Unit,
                      min: 5,
                      max: 20,
                      sp: 12.5,
                      isRadialGauge: true,
                      isConScale: true,
                    ),
            )
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center,
                  child: feValue == null || feValue == 0.0 || feValue == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: Label2,
                          value: feValue,
                          Unit: Unit,
                          min: 0,
                          max: 100,
                          sp: 55,
                          isRadialGauge: true,
                          isFeScale: true,
                          showThreshold: false,
                        ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPieChartSection8({
    required double talValue,
    required double phValue,
    required Color talColor,
    required Color phColor,
    required String talLabel,
    required String phLabel,
    required String Unit,
  }) {
    // print('Building _buildPieChartSection8');
    // print('Tank8 TAL: $talValue');
    // print('Tank8 PH: $phValue');
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Default alignment to the start (left)
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 80,
              alignment: Alignment.center,
              child: talValue == null || talValue == 0.0 || talValue == 0
                  ? const Center(child: CircularProgressIndicator())
                  : LineGaugeTank(
                      Label: talLabel,
                      value: talValue,
                      Unit: Unit,
                      min: 0,
                      max: 10,
                      sp: 5,
                      isRadialGauge: true,
                      isTalScale: true,
                      showThreshold: false,
                    ),
            )
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center,
                  child: phValue == null || phValue == 0.0 || phValue == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: phLabel,
                          value: phValue,
                          Unit: '',
                          min: 7,
                          max: 11,
                          sp: 9,
                          isRadialGauge: true,
                          isPhScale: true,
                          showThreshold: false,
                        ),
                )
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
    required String taLabel,
    required String faLabel,
    required String arLabel,
    required String acLabel,
    required String tank9tempLabel,
    required String Unit,
    required String Unit2,
  }) {
    print('Building _buildPieChartSection9');
    print('Tank9 TA: $taValue');
    print('Tank9 FA: $faValue');
    print('Tank9 AR: $arValue');
    print('Tank9 AC: $acValue');
    print('Tank9 Temp: $tank9tempValue');
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Center alignment for Column
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 80,
              alignment: Alignment.center,
              child: taValue == null || taValue == 0.0 || taValue == 0
                  ? const Center(child: CircularProgressIndicator())
                  : LineGaugeTank(
                      Label: taLabel,
                      value: taValue,
                      Unit: Unit,
                      min: 20,
                      max: 35,
                      sp: 28,
                      isRadialGauge: true,
                      isTa9Scale: true,
                    ),
            )
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center,
                  child: faValue == null || faValue == 0.0 || faValue == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: faLabel,
                          value: faValue,
                          Unit: Unit,
                          min: 3,
                          max: 5,
                          sp: 4,
                          isRadialGauge: true,
                          isFa9Scale: true,
                          showThreshold: false,
                        ),
                )
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center,
                  child: arValue == null || arValue == 0.0 || arValue == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: arLabel,
                          value: arValue,
                          Unit: Unit,
                          min: 4,
                          max: 8,
                          sp: 6,
                          isRadialGauge: true,
                          isAR910Scale: true,
                          showThreshold: false,
                        ),
                )
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center,
                  child: acValue == null || acValue == 0.0 || acValue == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: acLabel,
                          value: acValue,
                          Unit: Unit,
                          min: 0,
                          max: 4,
                          sp: 1.5,
                          isRadialGauge: true,
                          isAC910Scale: true,
                        ),
                )
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center,
                  child: tank9tempValue == null ||
                          tank9tempValue == 0.0 ||
                          tank9tempValue == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: tank9tempLabel,
                          value: tank9tempValue,
                          Unit: Unit2,
                          min: 65,
                          max: 85,
                          sp: 75,
                          isRadialGauge: true,
                          isTemp910Scale: true,
                        ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPieChartSectionTank10({
    required double taValue10,
    required double faValue10,
    required double arValue10,
    required double acValue10,
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
    required String Unit,
    required String Unit2,
  }) {
    print('Building _buildPieChartSection8');
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Center alignment for Column
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 80,
              alignment: Alignment.center,
              child: taValue10 == null || taValue10 == 0
                  ? const Center(child: CircularProgressIndicator())
                  : LineGaugeTank(
                      Label: taLabel,
                      value: taValue10,
                      Unit: Unit,
                      min: 20,
                      max: 40,
                      sp: 32,
                      isRadialGauge: true,
                      isTa10Scale: true,
                    ),
            )
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center,
                  child: faValue10 == null || faValue10 == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: faLabel,
                          value: faValue10,
                          Unit: Unit,
                          min: 4,
                          max: 7,
                          sp: 30,
                          isRadialGauge: true,
                          isFa10Scale: true,
                          showThreshold: false,
                        ),
                )
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center,
                  child: arValue10 == null || arValue10 == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: arLabel,
                          value: arValue10,
                          Unit: Unit,
                          min: 4,
                          max: 8,
                          sp: 6,
                          isRadialGauge: true,
                          isAR910Scale: true,
                          showThreshold: false,
                        ),
                )
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center,
                  child: acValue10 == null || acValue10 == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: acLabel,
                          value: acValue10,
                          Unit: Unit,
                          min: 0,
                          max: 4,
                          sp: 2,
                          isRadialGauge: true,
                          isAC910Scale: true,
                        ),
                )
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center,
                  child: tank10tempValue == null || tank10tempValue == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: tank10TempLabel,
                          value: tank10tempValue,
                          Unit: Unit2,
                          min: 65,
                          max: 85,
                          sp: 75,
                          isRadialGauge: true,
                          isTemp910Scale: true,
                        ),
                )
              ],
            ),
          ],
        ),
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
    required String Unit,
    required String Unit2,
    required String Unit3,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Default alignment to the start (left)
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 80,
              alignment: Alignment.center,
              child: conValue == null || conValue == 0
                  ? const Center(child: CircularProgressIndicator())
                  : LineGaugeTank(
                      Label: conLabel,
                      value: conValue,
                      Unit: Unit,
                      min: 0,
                      max: 3,
                      sp: 1.7,
                      isRadialGauge: true,
                      isCon13Scale: true,
                    ),
            )
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center,
                  child: faValue == null || faValue == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: faLabel,
                          value: faValue,
                          Unit: Unit,
                          min: -2,
                          max: 2,
                          sp: 0.7,
                          isRadialGauge: true,
                          isFa1314Scale: true,
                        ),
                )
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center,
                  child: tank13TempValue == null || tank13TempValue == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: tank13TempLabel,
                          value: tank13TempValue,
                          Unit: Unit,
                          min: 70,
                          max: 90,
                          sp: 80,
                          isRadialGauge: true,
                          isTemp13Scale: true,
                        ),
                )
              ],
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
    required String Unit,
    required String Unit2,
    required String Unit3,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Default alignment to the start (left)
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 80,
              alignment: Alignment.center,
              child: conValue == null || conValue == 0
                  ? const Center(child: CircularProgressIndicator())
                  : LineGaugeTank(
                      Label: conLabel,
                      value: conValue,
                      Unit: Unit,
                      min: 1,
                      max: 3,
                      sp: 2.1,
                      isRadialGauge: true,
                      isCon14Scale: true,
                    ),
            )
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  alignment: Alignment.center,
                  child: faValue == null || faValue == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: faLabel,
                          value: faValue,
                          Unit: Unit,
                          min: -2,
                          max: 2,
                          sp: 0.7,
                          isRadialGauge: true,
                          isFa1314Scale: true,
                        ),
                )
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 155,
                  height: 80,
                  alignment: Alignment.center,
                  child: tank14TempValue == null || tank14TempValue == 0
                      ? const Center(child: CircularProgressIndicator())
                      : LineGaugeTank(
                          Label: tank14TempLabel,
                          value: tank14TempValue,
                          Unit: Unit,
                          min: 65,
                          max: 85,
                          sp: 75,
                          isRadialGauge: true,
                          isTemp14Scale: true,
                        ),
                )
              ],
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
