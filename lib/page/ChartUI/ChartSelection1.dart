// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:newmaster/bloc/BlocEvent/tank2_bloc.dart';
// import 'package:newmaster/presentation/widgets/%E0%B8%B5linechart1.dart';

// class ChartSelectionScreen1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => Tank2Bloc()..add(FetchTank2Data()),
//       child: ChartSelectionView(),
//     );
//   }
// }

// class ChartSelectionView extends StatefulWidget {
//   @override
//   _ChartSelectionViewState createState() => _ChartSelectionViewState();
// }

// class _ChartSelectionViewState extends State<ChartSelectionView> {
//   String selectedChart = 'Chart FAL_Tank2';

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 1000,
//       height: 205,
//       decoration: BoxDecoration(
//         color: Color(0xFF1E73BE),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 SizedBox(width: 10),
//                 Text("Chart Selection",
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white)),
//                 SizedBox(width: 10),
//                 DropdownButton<String>(
//                   value: selectedChart,
//                   dropdownColor: Colors.white,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedChart = newValue!;
//                     });
//                   },
//                   items: <String>['Chart FAL_Tank2', 'Temp_Tank2', 'Chart 3']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value,
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontFamily: 'Ramabhadra',
//                               fontSize: 16)),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),

//             SizedBox(height: 1),

//             // 🔹 Chart แสดงข้อมูล
//             BlocBuilder<Tank2Bloc, Tank2State>(
//               builder: (context, state) {
//                 if (state is Tank2Loading) {
//                   return CircularProgressIndicator();
//                 } else if (state is Tank2Loaded) {
//                   var chartData = state.data;

//                   if (chartData.isEmpty) {
//                     return Text("No data available");
//                   }

//                   return Container(
//                     height: 150,
//                     child: selectedChart == 'Chart FAL_Tank2'
//                         ? LineChart1()
//                         : Container(),
//                   );
//                 } else if (state is Tank2Error) {
//                   return Text("Error: ${state.message}");
//                 } else {
//                   return Container();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
