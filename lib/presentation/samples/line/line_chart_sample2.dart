import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:newmaster/presentation/resources/app_resources.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2(
      {super.key, required int crossAxisCount, required num childAspectRatio});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.80,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 50,
          child: Text(
            'Limit Max: 40',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 150,
          right: 50,
          child: Text(
            'Limit Min: 30',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 120,
          right: 50,
          child: Text(
            'Setpoint: 33',
            style: TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              '',
              style: TextStyle(
                fontSize: 12,
                color: showAvg
                    ? Colors.white.withOpacity(0.5)
                    : const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('', style: style);
        break;
      case 1:
        text = const Text('01:00', style: style);
        break;
      case 2:
        text = const Text('', style: style);
        break;
      case 3:
        text = const Text('', style: style);
        break;
      case 4:
        text = const Text('', style: style);
        break;
      case 5:
        text = const Text('', style: style);
        break;
      case 6:
        text = const Text('', style: style);
        break;
      case 7:
        text = const Text('07:00', style: style);
        break;
      case 8:
        text = const Text('', style: style);
        break;
      case 9:
        text = const Text('', style: style);
        break;
      case 10:
        text = const Text('', style: style);
        break;
      case 11:
        text = const Text('', style: style);
        break;
      case 12:
        text = const Text('', style: style);
        break;
      case 13:
        text = const Text('13:00', style: style);
        break;
      case 14:
        text = const Text('', style: style);
        break;
      case 15:
        text = const Text('', style: style);
        break;
      case 16:
        text = const Text('', style: style);
        break;
      case 17:
        text = const Text('', style: style);
        break;
      case 18:
        text = const Text('', style: style);
        break;
      case 19:
        text = const Text('19:00', style: style);
        break;
      case 20:
        text = const Text('', style: style);
        break;
      case 21:
        text = const Text('', style: style);
        break;
      case 22:
        text = const Text('', style: style);
        break;
      case 23:
        text = const Text('23:00', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    String text;
    switch (value.toInt()) {
      case 28:
        text = '28';
        break;
      case 30:
        text = '30';
        break;
      case 33:
        text = '33';
        break;
      case 38:
        text = '38';
        break;
      case 40:
        text = '40';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 28,
      minY: 0,
      maxY: 60,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 34),
            FlSpot(2, 34),
            FlSpot(4, 35.6),
            FlSpot(6, 32.7),
            FlSpot(8, 35),
            FlSpot(10, 35.1),
            FlSpot(12, 35.3),
            FlSpot(14, 34.5),
            FlSpot(16, 34),
            FlSpot(18, 35.6),
            FlSpot(20, 34.1),
            FlSpot(22, 35),
            FlSpot(24, 34.8),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 40),
            FlSpot(24, 40),
          ],
          isCurved: false,
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.orange],
          ),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.orange.withOpacity(0.3),
                Colors.orange.withOpacity(0.1)
              ],
            ),
          ),
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 30),
            FlSpot(24, 30),
          ],
          isCurved: false,
          gradient: LinearGradient(
            colors: [Colors.red, Colors.red],
          ),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.red.withOpacity(0.3),
                Colors.red.withOpacity(0.1)
              ],
            ),
          ),
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 33),
            FlSpot(24, 33),
          ],
          isCurved: false,
          gradient: LinearGradient(
            colors: [Colors.green, Colors.green],
          ),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.green.withOpacity(0.3),
                Colors.green.withOpacity(0.1)
              ],
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: true),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2, 3.44),
            FlSpot(4.0, 3.44),
            FlSpot(6, 3.44),
            FlSpot(8, 3.44),
            FlSpot(10, 3.44),
            FlSpot(12, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LineChartSample22 extends StatefulWidget {
  LineChartSample22({
    super.key,
    required this.historyChartData,
    required int crossAxisCount,
    required num childAspectRatio,
  });
  List<HistoryChartModel> historyChartData;
  @override
  State<LineChartSample22> createState() => _LineChartSample22State();
}

class _LineChartSample22State extends State<LineChartSample22> {
  List<Color> gradientColors = [
    Colors.blue,
    Colors.blue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.4,
          child: Padding(
            padding: const EdgeInsets.only(
                // right: 18,
                // left: 12,
                // top: 24,
                // bottom: 12,
                ),
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
        Positioned(
          top: 110,
          right: 50,
          child: Text(
            'USL: 40',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 235,
          right: 50,
          child: Text(
            'LSL: 30',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 195,
          right: 50,
          child: Text(
            'UCL: 33',
            style: TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SizedBox(
        //   width: 60,
        //   height: 34,
        //   child: TextButton(
        //     onPressed: () {
        //       setState(() {
        //         showAvg = !showAvg;
        //       });
        //     },
        //     child: Text(
        //       '',
        //       style: TextStyle(
        //         fontSize: 12,
        //         color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('', style: style);
        break;
      case 1:
        text = const Text('01:00', style: style);
        break;
      case 2:
        text = const Text('', style: style);
        break;
      case 3:
        text = const Text('', style: style);
        break;
      case 4:
        text = const Text('', style: style);
        break;
      case 5:
        text = const Text('', style: style);
        break;
      case 6:
        text = const Text('', style: style);
        break;
      case 7:
        text = const Text('07:00', style: style);
        break;
      case 8:
        text = const Text('', style: style);
        break;
      case 9:
        text = const Text('', style: style);
        break;
      case 10:
        text = const Text('', style: style);
        break;
      case 11:
        text = const Text('', style: style);
        break;
      case 12:
        text = const Text('', style: style);
        break;
      case 13:
        text = const Text('13:00', style: style);
        break;
      case 14:
        text = const Text('', style: style);
        break;
      case 15:
        text = const Text('', style: style);
        break;
      case 16:
        text = const Text('', style: style);
        break;
      case 17:
        text = const Text('', style: style);
        break;
      case 18:
        text = const Text('', style: style);
        break;
      case 19:
        text = const Text('19:00', style: style);
        break;
      case 20:
        text = const Text('', style: style);
        break;
      case 21:
        text = const Text('', style: style);
        break;
      case 22:
        text = const Text('', style: style);
        break;
      case 23:
        text = const Text('23:00', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: Colors.black,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 10:
        text = '10';
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
      case 40:
        text = '40';
        break;
      case 45:
        text = '45';
        break;
      case 50:
        text = '50';
        break;
      case 60:
        text = '60';
        break;
      case 70:
        text = '70';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.right);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        drawHorizontalLine: false,
        horizontalInterval: 100,
        verticalInterval: 3.7,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.black,
            strokeWidth: 1,
            dashArray: [5, 5],
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.black,
            strokeWidth: 1,
            dashArray: [5, 5],
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 120,
            interval: 1,
            getTitlesWidget: (value, titleMeta) {
              if (value.toInt() >= 0 &&
                  value.toInt() < widget.historyChartData.length) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    left: 20,
                  ),
                  child: Transform.rotate(
                    angle: -45,
                    child: Text(
                      widget.historyChartData[value.toInt()].samplingDate,
                      style: TextStyle(fontSize: 10, color: Colors.black),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.black, width: 3),
      ),
      minX: 0,
      maxX: 28,
      minY: 20,
      maxY: 50,
      lineBarsData: [
        LineChartBarData(
          spots: ((() {
            if (widget.historyChartData.length == 1 &&
                double.parse(
                        ConverstStr(widget.historyChartData[0].resultApprove)) >
                    0) {
              return [
                FlSpot(
                    1,
                    (double.parse(
                        ConverstStr(widget.historyChartData[0].resultApprove))))
              ];
            } else {
              List<FlSpot> buff = [];
              for (int i = 0; i < widget.historyChartData.length; i++) {
                buff.add(FlSpot(
                    i.toDouble(),
                    (double.parse(ConverstStr(
                        widget.historyChartData[i].resultApprove)))));
              }
              return buff;
            }
          }())),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              final radius = 2.0;
              return FlDotCirclePainter(
                radius: radius,
                color: Colors.blue,
                strokeColor: Colors.blue,
                strokeWidth: 2,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 33),
            FlSpot(28, 33),
          ],
          isCurved: false,
          gradient: LinearGradient(
            colors: [Colors.green, Colors.green],
          ),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 30),
            FlSpot(28, 30),
          ],
          isCurved: false,
          gradient: LinearGradient(
            colors: [Colors.red, Colors.red],
          ),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
          dashArray: [5, 5], // This will create a dashed line
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 40),
            FlSpot(28, 40),
          ],
          isCurved: false,
          gradient: LinearGradient(
            colors: [Colors.red, Colors.red],
          ),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
          dashArray: [5, 5], // This will create a dashed line
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: true),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.black,
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.black,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, titleMeta) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 50,
                ),
                child: Transform.rotate(
                  angle: -45,
                  child: Text(
                    widget.historyChartData[value.toInt()].date,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2, 3.44),
            FlSpot(4.0, 3.44),
            FlSpot(6, 3.44),
            FlSpot(8, 3.44),
            FlSpot(10, 3.44),
            FlSpot(12, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String ConverstStr(dynamic input) {
  if (isNumeric(input)) {
    return input;
  } else {
    return '0';
  }
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

List<HistoryChartModel> historyChartModelFromJson(String str) =>
    List<HistoryChartModel>.from(
        json.decode(str).map((x) => HistoryChartModel.fromJson(x)));

String historyChartModelToJson(List<HistoryChartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryChartModel {
  HistoryChartModel({
    this.id,
    this.custFull,
    this.sampleName,
    this.samplingDate,
    this.stdMax,
    this.stdMin,
    this.resultApprove,
    this.resultApproveUnit,
    this.position,
    this.date,
  });

  dynamic id;
  dynamic custFull;
  dynamic sampleName;
  dynamic samplingDate;
  dynamic date;
  dynamic stdMax;
  dynamic stdMin;
  dynamic resultApprove;
  dynamic resultApproveUnit;
  dynamic position;

  factory HistoryChartModel.fromJson(Map<String, dynamic> json) =>
      HistoryChartModel(
        id: json["id"] ?? "",
        custFull: json["CustFull"] ?? "",
        sampleName: json["SampleName"] ?? "",
        samplingDate: json["SamplingDate"] ?? "",
        date: json["Date"] ?? "",
        stdMax: json["StdMax"] ?? "0",
        stdMin: json["StdMin"] ?? "0",
        resultApprove: json["ResultApprove"] ?? "",
        resultApproveUnit: json["ResultApproveUnit"] ?? "",
        position: json["Position"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "CustFull": custFull ?? "",
        "SampleName": sampleName ?? "",
        "SamplingDate": samplingDate ?? "",
        "date": date ?? "",
        "StdMax": stdMax ?? "",
        "StdMin": stdMin ?? "",
        "ResultApprove": resultApprove ?? "",
        "ResultApproveUnit": resultApproveUnit ?? "",
        "Position": position ?? "",
      };
}
