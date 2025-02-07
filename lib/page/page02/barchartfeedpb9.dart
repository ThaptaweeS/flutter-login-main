// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class PumpFeedChartpb9 extends StatelessWidget {
//   final double feedQuantity; // The maximum feed quantity from TextField
//   final List<double> recipeData; // Data from API for X-axis
//   final double feedAcual; // Data from API for Y-axis

//   PumpFeedChartpb9({
//     required this.feedQuantity,
//     required this.recipeData,
//     required this.feedAcual,
//   });

//    Widget build(BuildContext context) {
//     return BarChart(
//       BarChartData(
//         maxY: feedTarget > 0
//             ? feedTarget
//             : 0, // Set the max Y value based on feedTarget
//         borderData: FlBorderData(
//           show: true,
//           border: Border.all(color: Colors.black, width: 1),
//         ),
//         titlesData: FlTitlesData(
//           show: true,
//           // Y-axis Titles (FeedTarget in kg)
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               reservedSize: 40,
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 return Text(
//                   '${value.toInt()} sec', // Show FeedTarget as kg
//                   style: GoogleFonts.ramabhadra(color: Colors.black, fontSize: 10),
//                 );
//               },
//             ),
//           ),
//           // X-axis Titles (feedActual in seconds)
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 return Text(
//                   '${feedActual.toInt()} sec', // Show FeedActual as seconds
//                   style: GoogleFonts.ramabhadra(color: Colors.black, fontSize: 10),
//                 );
//               },
//             ),
//           ),
//         ),
//         // Bar chart data
//         gridData: FlGridData(
//             show: true, drawHorizontalLine: true, drawVerticalLine: true),
//         barGroups: [
//           BarChartGroupData(
//             x: 0,
//             barRods: [
//               BarChartRodData(
//                 toY: feedActual,
//                 color: Colors.blue,
//                 width: 60,
//                 borderRadius: BorderRadius.zero,
//                 backDrawRodData: BackgroundBarChartRodData(
//                   show: true,
//                   toY: feedTarget,
//                   color: Colors.grey.withOpacity(0.5),
//                 ),
//                 // ปรับ tooltip ให้อยู่ภายในกราฟแท่ง
//                 rodStackItems: [
//                   BarChartRodStackItem(
//                     0,
//                     feedActual,
//                     Colors.blue,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
