// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:newmaster/bloc/BlocEvent/tank5_bloc.dart';
// import 'package:newmaster/presentation/widgets/linechart2.dart';

// class ChartSelectionScreen2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => Tank5Bloc()..add(FetchTank5Data()),
//       child: ChartSelectionView2(),
//     );
//   }
// }

// class ChartSelectionView2 extends StatefulWidget {
//   @override
//   _ChartSelectionView2State createState() => _ChartSelectionView2State();
// }

// class _ChartSelectionView2State extends State<ChartSelectionView2> {
//   String selectedChart = 'Chart FAL_Tank2';

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
//           crossAxisAlignment: CrossAxisAlignment.center, // จัดชิดซ้าย
//           children: [
//             SizedBox(width: 10),
//             Row(
//               children: [
//                 SizedBox(width: 10),
//                 Text(
//                   "Chart Selection",
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 SizedBox(width: 10),
//                 // DropdownButton<String>(
//                 //   value: selectedChart,
//                 //   dropdownColor: Colors.white,
//                 //   onChanged: (String? newValue) {
//                 //     setState(() {
//                 //       selectedChart = newValue!;
//                 //     });
//                 //   },
//                 //   items: <String>['Tank2_FA.I.', 'Tank2_Temp', 'Chart 3']
//                 //       .map<DropdownMenuItem<String>>((String value) {
//                 //     return DropdownMenuItem<String>(
//                 //         value: value,
//                 //         child: Text(
//                 //           value,
//                 //           style: TextStyle(
//                 //             color: Colors.black,
//                 //           )..merge(GoogleFonts.ramabhadra()),
//                 //         ));
//                 //   }).toList(),
//                 // ),
//               ],
//             ),

//             SizedBox(height: 1),

//             // 🔹 Chart แสดงข้อมูล
//             BlocBuilder<Tank5Bloc, Tank5State>(
//               builder: (context, state) {
//                 if (state is Tank5Loading) {
//                   return CircularProgressIndicator();
//                 } else if (state is Tank5Loaded) {
//                   var chartData = state.data;

//                   if (chartData.isEmpty) {
//                     return Text("No data available");
//                   }

//                   return Container(
//                     height: 150,
//                     child: selectedChart == 'Chart FAL_Tank2'
//                         ? LineChart2()
//                         : Container(),
//                   );
//                 } else if (state is Tank5Error) {
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
