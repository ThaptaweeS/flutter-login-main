import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:newmaster/presentation/resources/app_colors.dart';

// List<FlSpot> Chart_data = [];
List<Map<String, dynamic>> Chart_data2 = [];

class LineChartUI extends StatefulWidget {
  LineChartUI({
    super.key,
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
    required this.value,
    required this.range,
    required this.date,
    //required this.chartData,
  })  : lineColor = lineColor ?? AppColors.contentColorRed,
        indicatorLineColor =
            indicatorLineColor ?? AppColors.contentColorYellow.withOpacity(0.2),
        indicatorTouchedLineColor =
            indicatorTouchedLineColor ?? AppColors.contentColorYellow,
        indicatorSpotStrokeColor = indicatorSpotStrokeColor ??
            AppColors.contentColorYellow.withOpacity(0.5),
        indicatorTouchedSpotStrokeColor =
            indicatorTouchedSpotStrokeColor ?? AppColors.contentColorYellow,
        bottomTextColor = bottomTextColor ?? const Color.fromARGB(255, 0, 0, 0),
        bottomTouchedTextColor =
            bottomTouchedTextColor ?? AppColors.contentColorYellow,
        averageLineColor =
            averageLineColor ?? AppColors.contentColorGreen.withOpacity(0.8),
        tooltipBgColor = tooltipBgColor ?? AppColors.contentColorGreen,
        tooltipTextColor = tooltipTextColor ?? Colors.black;

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
  final double value;
  final double range;
  final double date;
  //final List<Map<String, dynamic>> chartData;

  //List<String> get weekDays =>
  //     chartData.map((data) => data['date'].toString()).toList();

//  List<String> get yValues => chartData.map((data) => data['value']).toList();

  @override
  State createState() => _LineChartUIState();
}

class _LineChartUIState extends State<LineChartUI> {
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
      color: const Color.fromARGB(255, 0, 0, 0),
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 5:
        text = '5';
        break;
      case 10:
        text = '10';
        break;
      case 15:
        text = '15';
        break;
      case 20:
        text = '20';
        break;
      case 25:
        text = '25';
        break;
      case 30:
        text = '30';
        break;
      case 33:
        text = '33';
        break;
      case 35:
        text = '35';
        break;
      case 40:
        text = '40';
        break;
      case 45:
        text = '45';
        break;
      case 50:
        text = '50';
        break;

      case 55:
        text = '55'; // Customize this text for value 10
        break;
      case 60:
        text = '60'; // Customize this text for value 10
        break;
      case 65:
        text = '65'; // Customize this text for value 10
        break;
      case 70:
        text = '70'; // Customize this text for value 10
        break;
      case 75:
        text = '75'; // Customize this text for value 10
        break;
      case 80:
        text = '80'; // Customize this text for value 10
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: AxisSide.left, // or AxisSide.right, depending on your needs
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
      axisSide: meta.axisSide,
      space: 4,
      fitInside: fitInsideBottomTitle
          ? SideTitleFitInsideData.fromTitleMeta(meta, distanceFromEdge: 0)
          : SideTitleFitInsideData.disable(),
      child: Text(
        Chart_data2.toString(),
        //  widget.weekDays[value.toInt()],
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> chartData = [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Text(
            //   'Average Line',
            //   style: TextStyle(
            //     color: widget.averageLineColor.withOpacity(1),
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16,
            //   ),
            // ),
            // const Text(
            //   ' and ',
            //   style: TextStyle(
            //     color: AppColors.mainTextColor1,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16,
            //   ),
            // ),
            // Text(
            //   'Indicators',
            //   style: TextStyle(
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
          height: 130,
          width: double.infinity,
          // aspectRatio: 1,
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
                    getTooltipColor: (touchedSpot) => widget.tooltipBgColor,
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
                          'Date: ${widget.date} \n',
                          /*  '${widget.weekDays[flSpot.x.toInt()]} \n', */
                          TextStyle(
                            color: widget.tooltipTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: flSpot.y.toString(),
                              style: TextStyle(
                                color: widget.tooltipTextColor,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const TextSpan(
                              text: ' k ',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const TextSpan(
                              text: 'calories',
                              style: TextStyle(
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
                    // spots: Chart_data,
                    /* widget.yValues.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value);
                    }).toList(), */
                    isCurved: false,
                    barWidth: 4,
                    color: widget.lineColor,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          widget.lineColor.withOpacity(0.5),
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
                minY: 20,
                maxY: 50,
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
        // Column(
        //   children: [
        //     const Text('Fit Inside Title Option'),
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
