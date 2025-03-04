// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:newmaster/bloc/BlocEvent/tank8_bloc.dart';

// // List<FlSpot> Chart_data = [];

// class LineChart3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Expanded(
//         flex: 1,
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           padding: EdgeInsets.all(8.0),
//           child: LineChart(
//             LineChartData(
//               lineTouchData:
//                   LineTouchData(touchTooltipData: LineTouchTooltipData()),

//               maxY: 40,
//               minY: 30,
//               // maxX: 30,
//               backgroundColor: Colors.transparent,
//               gridData: FlGridData(
//                 show: false,
//                 drawHorizontalLine: false,
//                 getDrawingHorizontalLine: (value) {
//                   return FlLine(
//                     color: Colors.black.withOpacity(0.2),
//                     strokeWidth: 1,
//                   );
//                 },
//                 drawVerticalLine: false,
//                 getDrawingVerticalLine: (value) {
//                   return FlLine(
//                     color: Colors.black.withOpacity(0.2),
//                     strokeWidth: 1,
//                   );
//                 },
//               ),

//               titlesData: FlTitlesData(
//                 leftTitles: AxisTitles(
//                   // axisNameSize: 10,
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 30,
//                   ),
//                 ),
//                 rightTitles: AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//                 topTitles: AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//               ),
//               borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(
//                   color: Colors.black,
//                   width: 2,
//                 ),
//               ),
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: (Chart_data8),

//                   // [
//                   // FlSpot(0, 1),
//                   // FlSpot(1, 3),
//                   // FlSpot(2, 1.5),
//                   // FlSpot(3, 4),
//                   // FlSpot(4, 2),
//                   // FlSpot(5, 3.5),
//                   // ],
//                   isCurved: true, // กราฟโค้ง
//                   color: Colors.white, // สีเส้น
//                   dotData: FlDotData(show: true), // แสดงจุดบนเส้น
//                   belowBarData: BarAreaData(
//                       show: true,
//                       color:
//                           Colors.white.withOpacity(0.3)), // สีที่ด้านล่างเส้น
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// void main() => runApp(MaterialApp(home: LineChart3()));
