import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:newmaster/presentation/resources/app_resources.dart';

class LineChartUI extends StatelessWidget {
  LineChartUI({
    super.key,
    Color? line1Color,
    Color? line2Color,
    Color? betweenColor,
    final dynamic chartData,
  })  : line1Color = line1Color ?? AppColors.contentColorGreen,
        line2Color = line2Color ?? AppColors.contentColorRed,
        betweenColor =
            betweenColor ?? AppColors.contentColorRed.withOpacity(0.5);

  final Color line1Color;
  final Color line2Color;
  final Color betweenColor;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
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
      default:
        return Container();
    }

    return Padding(
      padding:
          EdgeInsets.only(right: 3.0), // Adjust the padding to move the text
      child: Text(
        text,
        style: style,
        textAlign:
            TextAlign.right, // Text alignment inside the padded container
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 18,
          top: 10,
          bottom: 4,
        ),
        child: LineChart(
          LineChartData(
            lineTouchData: const LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 4),
                  FlSpot(1, 3.5),
                  FlSpot(2, 4.5),
                  FlSpot(3, 1),
                  FlSpot(4, 4),
                  FlSpot(5, 6),
                  FlSpot(6, 6.5),
                  FlSpot(7, 6),
                  FlSpot(8, 4),
                  FlSpot(9, 6),
                  FlSpot(10, 6),
                  FlSpot(11, 7),
                ],
                isCurved: true,
                barWidth: 2,
                color: line1Color,
                dotData: const FlDotData(
                  show: false,
                ),
              ),
              LineChartBarData(
                spots: const [
                  FlSpot(0, 7),
                  FlSpot(1, 3),
                  FlSpot(2, 4),
                  FlSpot(3, 2),
                  FlSpot(4, 3),
                  FlSpot(5, 4),
                  FlSpot(6, 5),
                  FlSpot(7, 3),
                  FlSpot(8, 1),
                  FlSpot(9, 8),
                  FlSpot(10, 1),
                  FlSpot(11, 3),
                ],
                isCurved: false,
                barWidth: 2,
                color: line2Color,
                dotData: const FlDotData(
                  show: false,
                ),
              ),
            ],
            betweenBarsData: [
              BetweenBarsData(
                fromIndex: 0,
                toIndex: 1,
                color: betweenColor,
              )
            ],
            minY: 0,
            borderData: FlBorderData(
              show: false,
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: leftTitleWidgets,
                  interval: 1,
                  reservedSize: 36,
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              checkToShowHorizontalLine: (double value) {
                return value == 1 || value == 6 || value == 4 || value == 5;
              },
            ),
          ),
        ),
      ),
    );
  }
}
