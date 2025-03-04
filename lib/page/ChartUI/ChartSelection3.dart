// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:newmaster/presentation/widgets/linechart3.dart';

// import '../../bloc/BlocEvent/tank8_bloc.dart';

// class ChartSelectionScreen3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => Tank8Bloc()..add(FetchTank8Data()),
//       child: ChartSelectionView3(),
//     );
//   }
// }

// class ChartSelectionView3 extends StatefulWidget {
//   @override
//   _ChartSelectionView3State createState() => _ChartSelectionView3State();
// }

// class _ChartSelectionView3State extends State<ChartSelectionView3> {
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
//               ],
//             ),
//             SizedBox(height: 1),
//             BlocBuilder<Tank8Bloc, Tank8State>(
//               builder: (context, state) {
//                 if (state is Tank8Loading) {
//                   return CircularProgressIndicator();
//                 } else if (state is Tank8Loaded) {
//                   var chartData = state.data;

//                   if (chartData.isEmpty) {
//                     return Text("No data available");
//                   }
//                   return Container(
//                     height: 150,
//                     child: selectedChart == 'Chart FAL_Tank2'
//                         ? LineChart3()
//                         : Container(),
//                   );
//                 } else if (state is Tank8Error) {
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
