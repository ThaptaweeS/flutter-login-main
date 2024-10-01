import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PumpFeedChart extends StatefulWidget {
  final double feedQuantity; // The maximum feed quantity from TextField
  final List<double> recipeData; // Data from API for X-axis
  final double feedAcual; // Data from API for Y-axis

  PumpFeedChart({
    required this.feedQuantity,
    required this.recipeData,
    required this.feedAcual,
  });

  @override
  _PumpFeedChartState createState() => _PumpFeedChartState();
}

class _PumpFeedChartState extends State<PumpFeedChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: widget.feedAcual, // Set the Y-axis max limit from TextField
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black, width: 1),
        ),
        titlesData: FlTitlesData(
          show: true,

          // Left Titles (Y-axis)
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 40,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                
                return Text(
                  '${value.toInt()} ml', // Display Y-axis values in milliliters
                  style: TextStyle(color: Colors.black, fontSize: 8),
                );
              },
            ),
          ),

          // Bottom Titles (X-axis)
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index < widget.recipeData.length) {
                  return Text(
                    '${widget.recipeData[index]} ml', // Display data from API on X-axis
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  );
                }
                return Text('');
              },
            ),
          ),
        ),

        // Bar chart data
        barGroups: List.generate(widget.recipeData.length, (index) {
          return BarChartGroupData(
            x: index, // X-axis based on the index of recipe data
            barRods: [
              BarChartRodData(
                toY: widget.recipeData[index], // Bar height from API data
                color: Colors.blue,
                width: 20,
              ),
            ],
          );
        }),
      ),
    );
  }
}
