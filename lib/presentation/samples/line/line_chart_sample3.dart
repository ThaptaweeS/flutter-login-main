import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/presentation/resources/app_resources.dart';

class LineChartSample3 extends StatefulWidget {
  LineChartSample3({
    Key? key,
    Color? lineColor,
    Color? indicatorLineColor,
    Color? indicatorTouchedLineColor,
    Color? indicatorSpotStrokeColor,
    Color? indicatorTouchedSpotStrokeColor,
    Color? bottomTextColor,
    Color? bottomTouchedTextColor,
    Color? averageLineColor,
    Color? tooltipBgColor,
    Color? tooltipTextColor,
    required int crossAxisCount,
    required num childAspectRatio,
  })  : lineColor = lineColor ?? AppColors.contentColorRed,
        indicatorLineColor =
            indicatorLineColor ?? AppColors.contentColorYellow.withOpacity(0.2),
        indicatorTouchedLineColor =
            indicatorTouchedLineColor ?? AppColors.contentColorYellow,
        indicatorSpotStrokeColor = indicatorSpotStrokeColor ??
            AppColors.contentColorYellow.withOpacity(0.5),
        indicatorTouchedSpotStrokeColor =
            indicatorTouchedSpotStrokeColor ?? AppColors.contentColorYellow,
        bottomTextColor =
            bottomTextColor ?? AppColors.contentColorYellow.withOpacity(0.2),
        bottomTouchedTextColor =
            bottomTouchedTextColor ?? AppColors.contentColorYellow,
        averageLineColor =
            averageLineColor ?? AppColors.contentColorGreen.withOpacity(0.8),
        tooltipBgColor = tooltipBgColor ?? AppColors.contentColorGreen,
        tooltipTextColor = tooltipTextColor ?? Colors.black,
        super(key: key);

  final Color lineColor;
  final Color indicatorLineColor;
  final Color indicatorTouchedLineColor;
  final Color indicatorSpotStrokeColor;
  final Color indicatorTouchedSpotStrokeColor;
  final Color bottomTextColor;
  final Color bottomTouchedTextColor;
  final Color averageLineColor;
  final Color tooltipBgColor;
  final Color tooltipTextColor;

  List<String> get weekDays =>
      const ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  List<double> get yValues => const [1.3, 1, 1.8, 1.5, 2.2, 1.8, 3];

  @override
  State createState() => _LineChartSample3State();
}

class _LineChartSample3State extends State<LineChartSample3> {
  late double touchedValue;

  bool fitInsideBottomTitle = true;
  bool fitInsideLeftTitle = false;

  @override
  void initState() {
    touchedValue = -1;
    super.initState();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    if (value % 1 != 0) {
      return Container();
    }
    final style = TextStyle(
      color: AppColors.mainTextColor1.withOpacity(0.5),
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '';
        break;
      case 1:
        text = '1 Point';
        break;
      case 2:
        text = '2 Point';
        break;
      case 3:
        text = '3 Point';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 6,
      fitInside: fitInsideLeftTitle
          ? SideTitleFitInsideData.fromTitleMeta(meta)
          : SideTitleFitInsideData.disable(),
      child: Text(text, style: style, textAlign: TextAlign.center),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final isTouched = value == touchedValue;
    final style = TextStyle(
      color: isTouched ? widget.bottomTouchedTextColor : widget.bottomTextColor,
      fontWeight: FontWeight.bold,
    );

    if (value % 1 != 0) {
      return Container();
    }
    return SideTitleWidget(
      space: 4,
      axisSide: meta.axisSide,
      fitInside: fitInsideBottomTitle
          ? SideTitleFitInsideData.fromTitleMeta(meta, distanceFromEdge: 0)
          : SideTitleFitInsideData.disable(),
      child: Text(
        widget.weekDays[value.toInt()],
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Text(
            //   'Average Line',
            //   style: GoogleFonts.ramabhadra(
            //     color: widget.averageLineColor.withOpacity(1),
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16,
            //   ),
            // ),
            // const Text(
            //   ' and ',
            //   style: GoogleFonts.ramabhadra(
            //     color: AppColors.mainTextColor1,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16,
            //   ),
            // ),
            // Text(
            //   'Indicators',
            //   style: GoogleFonts.ramabhadra(
            //     color: widget.indicatorLineColor.withOpacity(1),
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16,
            //   ),
            // ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Container(
          width: 480.0,
          height: 195.0,
          child: AspectRatio(
            aspectRatio: 2.0,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 12),
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    getTouchedSpotIndicator:
                        (LineChartBarData barData, List<int> spotIndexes) {
                      return spotIndexes.map((spotIndex) {
                        final spot = barData.spots[spotIndex];
                        if (spot.x == 0 || spot.x == 6) {
                          return null;
                        }
                        return TouchedSpotIndicatorData(
                          FlLine(
                            color: widget.indicatorTouchedLineColor,
                            strokeWidth: 4,
                          ),
                          FlDotData(
                            getDotPainter: (spot, percent, barData, index) {
                              if (index.isEven) {
                                return FlDotCirclePainter(
                                  radius: 8,
                                  color: Colors.white,
                                  strokeWidth: 5,
                                  strokeColor:
                                      widget.indicatorTouchedSpotStrokeColor,
                                );
                              } else {
                                return FlDotSquarePainter(
                                  size: 16,
                                  color: Colors.white,
                                  strokeWidth: 5,
                                  strokeColor:
                                      widget.indicatorTouchedSpotStrokeColor,
                                );
                              }
                            },
                          ),
                        );
                      }).toList();
                    },
                    touchTooltipData: LineTouchTooltipData(
                      // tooltipBgColor: widget.tooltipBgColor,
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          final flSpot = barSpot;
                          if (flSpot.x == 0 || flSpot.x == 6) {
                            return null;
                          }

                          TextAlign textAlign;
                          switch (flSpot.x.toInt()) {
                            case 1:
                              textAlign = TextAlign.left;
                              break;
                            case 5:
                              textAlign = TextAlign.right;
                              break;
                            default:
                              textAlign = TextAlign.center;
                          }

                          return LineTooltipItem(
                            '${widget.weekDays[flSpot.x.toInt()]} \n',
                            TextStyle(
                              color: widget.tooltipTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: flSpot.y.toString(),
                                style: GoogleFonts.ramabhadra(
                                  color: widget.tooltipTextColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                               TextSpan(
                                text: '',
                                style: GoogleFonts.ramabhadra(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                               TextSpan(
                                text: 'Point',
                                style: GoogleFonts.ramabhadra(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                            textAlign: textAlign,
                          );
                        }).toList();
                      },
                    ),
                    touchCallback:
                        (FlTouchEvent event, LineTouchResponse? lineTouch) {
                      if (!event.isInterestedForInteractions ||
                          lineTouch == null ||
                          lineTouch.lineBarSpots == null) {
                        setState(() {
                          touchedValue = -1;
                        });
                        return;
                      }
                      final value = lineTouch.lineBarSpots![0].x;

                      if (value == 0 || value == 6) {
                        setState(() {
                          touchedValue = -1;
                        });
                        return;
                      }

                      setState(() {
                        touchedValue = value;
                      });
                    },
                  ),
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: 1.8,
                        color: widget.averageLineColor,
                        strokeWidth: 3,
                        dashArray: [20, 10],
                      ),
                    ],
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isStepLineChart: true,
                      spots: widget.yValues.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), e.value);
                      }).toList(),
                      isCurved: false,
                      barWidth: 4,
                      color: widget.lineColor,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            widget.lineColor.withOpacity(0.8),
                            widget.lineColor.withOpacity(0),
                          ],
                          stops: const [0.5, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        spotsLine: BarAreaSpotsLine(
                          show: true,
                          flLineStyle: FlLine(
                            color: widget.indicatorLineColor,
                            strokeWidth: 2,
                          ),
                          checkToShowSpotLine: (spot) {
                            if (spot.x == 0 || spot.x == 6) {
                              return false;
                            }

                            return true;
                          },
                        ),
                      ),
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          if (index.isEven) {
                            return FlDotCirclePainter(
                              radius: 6,
                              color: Colors.white,
                              strokeWidth: 3,
                              strokeColor: widget.indicatorSpotStrokeColor,
                            );
                          } else {
                            return FlDotSquarePainter(
                              size: 12,
                              color: Colors.white,
                              strokeWidth: 3,
                              strokeColor: widget.indicatorSpotStrokeColor,
                            );
                          }
                        },
                        checkToShowDot: (spot, barData) {
                          return spot.x != 0 && spot.x != 6;
                        },
                      ),
                    ),
                  ],
                  minY: 0,
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: AppColors.borderColor,
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: true,
                    checkToShowHorizontalLine: (value) => value % 1 == 0,
                    checkToShowVerticalLine: (value) => value % 1 == 0,
                    getDrawingHorizontalLine: (value) {
                      if (value == 0) {
                        return const FlLine(
                          color: AppColors.contentColorOrange,
                          strokeWidth: 2,
                        );
                      } else {
                        return const FlLine(
                          color: AppColors.mainGridLineColor,
                          strokeWidth: 0.5,
                        );
                      }
                    },
                    getDrawingVerticalLine: (value) {
                      if (value == 0) {
                        return const FlLine(
                          color: Colors.redAccent,
                          strokeWidth: 10,
                        );
                      } else {
                        return const FlLine(
                          color: AppColors.mainGridLineColor,
                          strokeWidth: 0.5,
                        );
                      }
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 46,
                        getTitlesWidget: leftTitleWidgets,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Column(
        //   children: [
        //     const Text(''),
        //     const Divider(),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         const Text('Left Title'),
        //         Switch(
        //           value: fitInsideLeftTitle,
        //           onChanged: (value) => setState(() {
        //             fitInsideLeftTitle = value;
        //           }),
        //         ),
        //         const Text('Bottom Title'),
        //         Switch(
        //           value: fitInsideBottomTitle,
        //           onChanged: (value) => setState(() {
        //             fitInsideBottomTitle = value;
        //           }),
        //         )
        //       ],
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
