import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newmaster/models/MyFiles.dart';

import '../../../constants.dart';

class FileInfoCard extends StatefulWidget {
  FileInfoCard({
    Key? key,
    this.tapping,
    required this.info,
    this.onTap,
  }) : super(key: key);

  final CloudStorageInfo info;
  final Function(String)? tapping;
  final Function()? onTap;

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
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 236, 242, 247),
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
                  padding: EdgeInsets.all(defaultPadding * 0.55),
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
                      : SizedBox(height: defaultPadding),
                ),
                Icon(Icons.circle, color: iconColor),
              ],
            ),
            Text(
              widget.info.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            ProgressLine(
              color: widget.info.color,
              percentage: widget.info.percentage,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.info.totalStorage ?? '',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
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
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 2,
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
