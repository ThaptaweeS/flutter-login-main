import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    timer = Timer.periodic(Duration(milliseconds: 700), (timer) {
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 247, 247, 247).withOpacity(0.5),
              offset: Offset(0, 1),
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
              widget.info.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: defaultPadding / 2),
            Text(
              widget.info.totalStorage ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: defaultPadding),
            ProgressLine(
              color: widget.info.color ?? Colors.blue,
              percentage: widget.info.percentage ?? 0,
            ),
            SizedBox(height: defaultPadding),
            if (widget.info.falValue != null && widget.info.tempValue != null)
              _buildPieChartSection2(
                falValue: widget.info.falValue!,
                tempValue: widget.info.tempValue!,
                falColor: Colors.lightBlueAccent,
                tempColor: Colors.greenAccent,
                falLabel: 'F.Al. Value',
                tempLabel: 'Temp. Value',
              ),
            if (widget.info.feValue != null && widget.info.conValue != null)
              _buildPieChartSection5(
                feValue: widget.info.feValue!,
                conValue: widget.info.conValue!,
                feColor: Colors.redAccent,
                conColor: Colors.orangeAccent,
                feLabel: 'Fe Value',
                conLabel: 'Con. Value',
              ),
            if (widget.info.talValue != null && widget.info.phValue != null)
              _buildPieChartSection8(
                talValue: widget.info.talValue!,
                phValue: widget.info.phValue!,
                talColor: Colors.blueAccent,
                phColor: Colors.purpleAccent,
                talLabel: 'T.Al. Value',
                phLabel: 'pH Value',
              ),
            if (widget.info.taValue != null &&
                widget.info.faValue != null &&
                widget.info.arValue != null &&
                widget.info.acValue != null &&
                widget.info.tank9TempValue != null)
              _buildPieChartSectionTank9(
                taValue: widget.info.taValue!,
                faValue: widget.info.faValue!,
                arValue: widget.info.arValue!,
                acValue: widget.info.acValue!,
                tank9TempValue: widget.info.tank9TempValue!,
                taColor: Colors.redAccent,
                faColor: Colors.purpleAccent,
                arColor: Colors.yellowAccent,
                acColor: Colors.lightBlueAccent,
                tank9TempColor: Colors.greenAccent,
                taLabel: 'T.A. Value',
                faLabel: 'F.A. Value',
                arLabel: 'A.R. Value',
                acLabel: 'A.C. Value',
                tank9TempLabel: 'Temp. Value',
              ),
            if (widget.info.taValue10 != null &&
                widget.info.faValue10 != null &&
                widget.info.arValue10 != null &&
                widget.info.acValue10 != null &&
                widget.info.tank10TempValue != null)
              _buildPieChartSectionTank10(
                taValue: widget.info.taValue10!,
                faValue: widget.info.faValue10!,
                arValue: widget.info.arValue10!,
                acValue: widget.info.acValue10!,
                tank10TempValue: widget.info.tank10TempValue!,
                taColor: Colors.redAccent,
                faColor: Colors.purpleAccent,
                arColor: Colors.yellowAccent,
                acColor: Colors.lightBlueAccent,
                tank10TempColor: Colors.greenAccent,
                taLabel: 'T.A. Value',
                faLabel: 'F.A. Value',
                arLabel: 'A.R. Value',
                acLabel: 'A.C. Value',
                tank10TempLabel: 'Temp. Value',
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
                faLabel: 'F.A. Value',
                conLabel: 'Con. Value',
                tank13TempLabel: 'Temp. Value',
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
                faLabel: 'F.A. Value',
                conLabel: 'Con. Value',
                tank14TempLabel: 'Temp. Value',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartSection2({
    required double falValue,
    required double tempValue,
    required Color falColor,
    required Color tempColor,
    required String falLabel,
    required String tempLabel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the content horizontally
          children: [
            Text(
              'F.AL. ',
              style: TextStyle(
                fontSize: 10,
                color:
                    const Color.fromARGB(255, 108, 108, 108), // Corrected line
              ),
            ),
            SizedBox(width: 5),
            Text(
              '$falValue',
              style: TextStyle(
                fontSize: 35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = const Color.fromARGB(255, 108, 108, 108),
              ),
            ),
            SizedBox(width: 5),
            Text(
              ' Pt.',
              style: TextStyle(
                fontSize: 10,
                color:
                    const Color.fromARGB(255, 108, 108, 108), // Corrected line
              ),
            ),
          ],
        ),
        // Additional widgets can be added here as needed, such as SizedBox or Tooltip.
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the content horizontally
          children: [
            Text(
              'Con. ',
              style: TextStyle(
                fontSize: 10,
                color:
                    const Color.fromARGB(255, 108, 108, 108), // Corrected line
              ),
            ),
            Text(
              '$conValue %',
              style: TextStyle(
                fontSize: 35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = const Color.fromARGB(255, 108, 108, 108),
              ),
            ),
          ],
        ),
        // Additional widgets can be added here as needed, such as SizedBox or Tooltip.
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the content horizontally
          children: [
            Text(
              'pH ',
              style: TextStyle(
                fontSize: 10,
                color:
                    const Color.fromARGB(255, 108, 108, 108), // Corrected line
              ),
            ),
            Text(
              '$phValue',
              style: TextStyle(
                fontSize: 35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = const Color.fromARGB(255, 108, 108, 108),
              ),
            ),
          ],
        ),
        // Additional widgets can be added here as needed, such as SizedBox or Tooltip.
      ],
    );
  }

  Widget _buildPieChartSectionTank9({
    required double taValue,
    required double faValue,
    required double arValue,
    required double acValue,
    required double tank9TempValue,
    required Color taColor,
    required Color faColor,
    required Color arColor,
    required Color acColor,
    required Color tank9TempColor,
    required String taLabel,
    required String faLabel,
    required String arLabel,
    required String acLabel,
    required String tank9TempLabel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Center the content horizontally
          children: [
            Text(
              'T.A. ',
              style: TextStyle(
                fontSize: 10,
                color:
                    const Color.fromARGB(255, 108, 108, 108), // Corrected line
              ),
            ),
            Text(
              '$taValue Pt.',
              style: TextStyle(
                fontSize: 35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = const Color.fromARGB(255, 108, 108, 108),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Center the content horizontally
          children: [
            Text(
              'A.R. ',
              style: TextStyle(
                fontSize: 10,
                color:
                    const Color.fromARGB(255, 108, 108, 108), // Corrected line
              ),
            ),
            Text(
              '$arValue Pt.',
              style: TextStyle(
                fontSize: 35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = const Color.fromARGB(255, 108, 108, 108),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Center the content horizontally
          children: [
            Text(
              'A.C.  ',
              style: TextStyle(
                fontSize: 10,
                color:
                    const Color.fromARGB(255, 108, 108, 108), // Corrected line
              ),
            ),
            Text(
              '$acValue Pt.',
              style: TextStyle(
                fontSize: 35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = const Color.fromARGB(255, 108, 108, 108),
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
    required double tank10TempValue,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Center the content horizontally
          children: [
            Text(
              'T.A. ',
              style: TextStyle(
                fontSize: 10,
                color:
                    const Color.fromARGB(255, 108, 108, 108), // Corrected line
              ),
            ),
            Text(
              '$taValue Pt.',
              style: TextStyle(
                fontSize: 35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = const Color.fromARGB(255, 108, 108, 108),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Center the content horizontally
          children: [
            Text(
              'A.R. ',
              style: TextStyle(
                fontSize: 10,
                color:
                    const Color.fromARGB(255, 108, 108, 108), // Corrected line
              ),
            ),
            Text(
              '$arValue Pt.',
              style: TextStyle(
                fontSize: 35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = const Color.fromARGB(255, 108, 108, 108),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Center the content horizontally
          children: [
            Text(
              'A.C.  ',
              style: TextStyle(
                fontSize: 10,
                color:
                    const Color.fromARGB(255, 108, 108, 108), // Corrected line
              ),
            ),
            Text(
              '$acValue Pt.',
              style: TextStyle(
                fontSize: 35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = const Color.fromARGB(255, 108, 108, 108),
              ),
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the content horizontally
          children: [
            Text(
              'Con. ',
              style: TextStyle(
                fontSize: 10,
                color:
                    const Color.fromARGB(255, 108, 108, 108), // Corrected line
              ),
            ),
            Text(
              '$conValue %',
              style: TextStyle(
                fontSize: 35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = const Color.fromARGB(255, 108, 108, 108),
              ),
            ),
          ],
        ),
        // Additional widgets can be added here as needed, such as SizedBox or Tooltip.
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the content horizontally
          children: [
            Text(
              'Con. ',
              style: TextStyle(
                fontSize: 10,
                color:
                    const Color.fromARGB(255, 108, 108, 108), // Corrected line
              ),
            ),
            Text(
              '$conValue %',
              style: TextStyle(
                fontSize: 35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = const Color.fromARGB(255, 108, 108, 108),
              ),
            ),
          ],
        ),
        // Additional widgets can be added here as needed, such as SizedBox or Tooltip.
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
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = Colors.blue,
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
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
