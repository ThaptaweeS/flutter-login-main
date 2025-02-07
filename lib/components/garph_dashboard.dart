import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarChartPD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BarChart(
        BarChartData(
          barGroups: _generateBarGroups(),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}kg',
                    style: GoogleFonts.ramabhadra(
                        color: Colors.black, fontSize: 10),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const names = [
                    'FC-4360',
                    'HCL',
                    'PL-ZN',
                    'PB-3650X',
                    'PB-181X',
                    'LUB-4618',
                    'LUB-235T'
                  ];
                  return Text(
                    names[value.toInt()],
                    style: GoogleFonts.ramabhadra(
                        color: Colors.black, fontSize: 10),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(show: true, drawHorizontalLine: true),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              // tooltipBgColor: Colors.blueGrey,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${rod.toY.toInt()}',
                  GoogleFonts.ramabhadra(color: Colors.black, fontSize: 10),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(toY: 1, color: Colors.cyan, width: 10),
          BarChartRodData(toY: 2, color: Colors.pink, width: 10),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(toY: 3, color: Colors.cyan, width: 10),
          BarChartRodData(toY: 1.5, color: Colors.pink, width: 10),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(toY: 50, color: Colors.cyan, width: 10),
          BarChartRodData(toY: 3, color: Colors.pink, width: 10),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(toY: 5, color: Colors.cyan, width: 10),
          BarChartRodData(toY: 2.5, color: Colors.pink, width: 10),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(toY: 4.5, color: Colors.cyan, width: 10),
          BarChartRodData(toY: 25, color: Colors.pink, width: 10),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(toY: 3.5, color: Colors.cyan, width: 10),
          BarChartRodData(toY: 350, color: Colors.pink, width: 10),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(toY: 15, color: Colors.cyan, width: 10),
          BarChartRodData(toY: 15, color: Colors.pink, width: 10),
        ],
      ),
    ];
  }
}
