import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Historydata1 extends StatelessWidget {
  final List<Map<String, String>> historyData;

  Historydata1(
      {required this.historyData,
      required int crossAxisCount,
      required double childAspectRatio});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 460.0,
      height: 250.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(
              label:
                  Text('Date', style: GoogleFonts.ramabhadra(fontSize: 12.0)),
            ),
            DataColumn(
              label:
                  Text('Times', style: GoogleFonts.ramabhadra(fontSize: 12.0)),
            ),
            DataColumn(
              label:
                  Text('Values', style: GoogleFonts.ramabhadra(fontSize: 12.0)),
            ),
          ],
          rows: historyData.map((data) {
            return DataRow(cells: [
              DataCell(
                Text(data['date']!,
                    style: GoogleFonts.ramabhadra(fontSize: 12.0)),
              ),
              DataCell(
                Text(data['time']!,
                    style: GoogleFonts.ramabhadra(fontSize: 12.0)),
              ),
              DataCell(
                Text(data['value']!,
                    style: GoogleFonts.ramabhadra(fontSize: 12.0)),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

class Historydata2 extends StatelessWidget {
  final List<Map<String, String>> historyData;

  Historydata2({
    required this.historyData,
    required int crossAxisCount,
    required double childAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 460.0,
      height: 250.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(
              label:
                  Text('Date', style: GoogleFonts.ramabhadra(fontSize: 12.0)),
            ),
            DataColumn(
              label:
                  Text('Times', style: GoogleFonts.ramabhadra(fontSize: 12.0)),
            ),
            DataColumn(
              label:
                  Text('Values', style: GoogleFonts.ramabhadra(fontSize: 12.0)),
            ),
          ],
          rows: historyData.map((data) {
            return DataRow(cells: [
              DataCell(
                Text(data['date']!,
                    style: GoogleFonts.ramabhadra(fontSize: 12.0)),
              ),
              DataCell(
                Text(data['time']!,
                    style: GoogleFonts.ramabhadra(fontSize: 12.0)),
              ),
              DataCell(
                Text(data['value']!,
                    style: GoogleFonts.ramabhadra(fontSize: 12.0)),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

// class Historydata2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 460.0,
//       height: 300.0,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: DataTable(
//           columns: [
//             DataColumn(label: Text('Date')),
//             DataColumn(label: Text('Times')),
//             DataColumn(label: Text('Values')),
//           ],
//           rows: [
//             DataRow(cells: [
//               DataCell(Text('2023-11-08')),
//               DataCell(Text('12:50')),
//               DataCell(Text('1.24 Litter')),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('2023-11-08')),
//               DataCell(Text('08:12')),
//               DataCell(Text('1.8 Litter')),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('2023-11-08')),
//               DataCell(Text('09:15')),
//               DataCell(Text('3.80 Litter')),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('2023-11-08')),
//               DataCell(Text('9:12')),
//               DataCell(Text('1.22 Litter')),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('2023-11-08')),
//               DataCell(Text('12:12')),
//               DataCell(Text('2.40 Litter')),
//             ]),
//             // Add more rows as needed but keep it limited to 5 rows
//           ],
//         ),
//       ),
//     );
//   }
// }
