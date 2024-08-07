import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample23 extends StatefulWidget {
  LineChartSample23({
    super.key,
    required this.historyChartData,
    required int crossAxisCount,
    required num childAspectRatio,
  });
  List<HistoryChartModel2> historyChartData;
  @override
  State<LineChartSample23> createState() => _LineChartSample23State();
}

class _LineChartSample23State extends State<LineChartSample23> {
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
          // aspectRatio: 1.80,
          aspectRatio: 1.40,
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
        fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0'; // Customize this text for value 1
        break;
      case 1:
        text = '1.0'; // Customize this text for value 3
        break;
      case 2:
        text = '2.0'; // Customize this text for value 3
        break;
      case 3:
        text = '3.0'; // Customize this text for value 5
        break;
      case 4:
        text = '4.0'; // Customize this text for value 5
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
        drawVerticalLine: true,
        horizontalInterval: 100,
        verticalInterval: 3.7,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.red,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.blue,
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
            reservedSize: 120,
            interval: 1,
            getTitlesWidget: (value, titleMeta) {
              if (value.toInt() >= 0 &&
                  value.toInt() < widget.historyChartData.length) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    left: 55,
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
                // Return an empty container or default text if the index is out of range
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
      minY: 0,
      maxY: 4,
      lineBarsData: [
        LineChartBarData(
          spots: ((() {
            if (widget.historyChartData.length == 1 &&
                double.parse(
                        ConverstStr(widget.historyChartData[0].resultApprove)) >
                    0) {
              //for (int i = 0; i < historyChartData.length; i++)
              print("addddddd");
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
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              final radius = 1.5; // Adjust the size of the dots here
              return FlDotCirclePainter(
                radius: radius,
                color: Colors
                    .blue, // You can also adjust the color of the dots if needed
                strokeColor:
                    Colors.blue, // If you want to add border color to the dots
                strokeWidth: 2, // If you want to add border to the dots
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
      ],
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
            y: 3.0,
            color: Colors.red,
            strokeWidth: 1,
            label: HorizontalLineLabel(
              show: true,
              alignment: Alignment.topRight,
              labelResolver: (line) => 'USL: 3.0',
              style: TextStyle(
                color: Colors.red,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              padding: EdgeInsets.only(right: 10),
            ),
            dashArray: [5, 5],
          ),
          HorizontalLine(
            y: 2.0,
            color: Colors.green,
            strokeWidth: 1,
            label: HorizontalLineLabel(
              show: true,
              alignment: Alignment.topRight,
              labelResolver: (line) => 'UCL: 2.0',
              style: TextStyle(
                color: Colors.green,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              padding: EdgeInsets.only(right: 10),
            ),
            // dashArray: [5, 5],
          ),
          HorizontalLine(
            y: 1.0,
            color: Colors.red,
            strokeWidth: 1,
            label: HorizontalLineLabel(
              show: true,
              alignment: Alignment.topRight,
              labelResolver: (line) => 'LSL: 1.0',
              style: TextStyle(
                color: Colors.red,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              padding: EdgeInsets.only(right: 10),
            ),
            dashArray: [5, 5],
          )
        ],
      ),
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
            // getTitlesWidget: bottomTitleWidgets,
            getTitlesWidget: (value, titleMeta) {
              return Padding(
                // You can use any widget here
                padding: EdgeInsets.only(
                  top: 20,
                  left: 50,
                ),
                child: Transform.rotate(
                  angle: -45,
                  child: Text(
                    widget.historyChartData[value.toInt()].date,
/*                   style: TextStyle(color: Colors.red), */
                    style: TextStyle(fontSize: 14),
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

List<HistoryChartModel2> HistoryChartModel2FromJson(String str) =>
    List<HistoryChartModel2>.from(
        json.decode(str).map((x) => HistoryChartModel2.fromJson(x)));

String HistoryChartModel2ToJson(List<HistoryChartModel2> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryChartModel2 {
  HistoryChartModel2({
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

  factory HistoryChartModel2.fromJson(Map<String, dynamic> json) =>
      HistoryChartModel2(
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
