// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:newmaster/components/file_info_card.dart';
// import 'package:newmaster/constants.dart';
// import 'package:newmaster/data/global.dart';
// import 'package:newmaster/page/P3TANKMASTER/P3TANKMASTERvar.dart';
// import 'package:newmaster/page/tank/tank1-backup.dart';
// import 'package:newmaster/page/tank/tank10-data/tank10.dart';
// import 'package:newmaster/page/tank/tank11.dart';
// import 'package:newmaster/page/tank/tank12.dart';
// import 'package:newmaster/page/tank/tank13-data/tank13.dart';
// import 'package:newmaster/page/tank/tank14-data/tank14.dart';
// import 'package:newmaster/page/tank/tank3.dart';
// import 'package:newmaster/page/tank/tank4.dart';
// import 'package:newmaster/page/tank/tank5-data/tank5.dart';
// import 'package:newmaster/page/tank/tank6.dart';
// import 'package:newmaster/page/tank/tank7.dart';
// import 'package:newmaster/page/tank/tank8-data/tank8.dart';
// import 'package:newmaster/page/tank/tank9-data/tank9.dart';

// import '../../bloc/BlocEvent/ChangePageEvent.dart';
// import '../../mainBody.dart';
// import '../../models/MyFiles.dart';

// class P1DASHBOARDMAIN extends StatefulWidget {
//   const P1DASHBOARDMAIN({super.key});

//   @override
//   State<P1DASHBOARDMAIN> createState() => _P1DASHBOARDMAINState();
// }

// class _P1DASHBOARDMAINState extends State<P1DASHBOARDMAIN> {
//   late Timer _timer;
//   double falValue = 0;
//   double tempValue = 0;
//   double feValue = 0;
//   double conValue = 0;

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(Duration(seconds: 5), (timer) {
//       // print('Timer...'); // ตรวจสอบว่า Timer ทำงานจริง
//       setState(() {
//         fetchStatusAndUpdateColors() {}
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   void _toggleVisibility(int id) {
//     setState(() {
//       visibilityStates[id] = !visibilityStates[id]!;
//     });
//   }

//   void _navigateToTank(int id) {
//     print("Inside _navigateToTank for Tank $id"); // Debugging statement
//     switch (id) {
//       // case 1:
//       //   CuPage = Tank1();
//       //   P3TANKMASTERvar.SelectPage = 3;
//       //   MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//       //   break;
//       case 2:
//         CuPage = Tank1();
//         P3TANKMASTERvar.SelectPage = 3;
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//         break;
//       case 3:
//         CuPage = Tank3();
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//         break;
//       case 4:
//         CuPage = Tank4();
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//         break;
//       case 5:
//         CuPage = Tank5();
//         P3TANKMASTERvar.SelectPage = 4;
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//         break;
//       case 6:
//         CuPage = Tank6();
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//         break;
//       case 7:
//         CuPage = Tank7();
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//         break;
//       case 8:
//         CuPage = Tank8();
//         P3TANKMASTERvar.SelectPage = 7;
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//         break;
//       case 9:
//         CuPage = Tank9();
//         P3TANKMASTERvar.SelectPage = 8;
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//         break;
//       case 10:
//         CuPage = Tank10();
//         P3TANKMASTERvar.SelectPage = 9;
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//         break;
//       case 11:
//         CuPage = Tank11();
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//         break;
//       case 12:
//         CuPage = Tank12();
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//         break;
//       case 13:
//         CuPage = Tank13();
//         P3TANKMASTERvar.SelectPage = 12;
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//         break;
//       case 14:
//         CuPage = Tank14();
//         P3TANKMASTERvar.SelectPage = 13;
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//         break;
//       default:
//         CuPage = P1DASHBOARDMAIN();
//         MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     fetchStatusAndUpdateColors();

//     // Filter out hidden items
//     List<int> visibleKeys =
//         visibilityStates.keys.where((key) => visibilityStates[key]!).toList();

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.indigo[50],
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment:
//                 CrossAxisAlignment.baseline, // ใช้ Baseline เดียวกัน
//             textBaseline: TextBaseline
//                 .alphabetic, // ต้องเพิ่มสำหรับให้ align ด้วย baseline
//             children: [
//               Text(
//                 'DASHBOARD',
//                 style: GoogleFonts.ramabhadra(
//                   fontSize: 40,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(width: 20),
//               Row(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 // crossAxisAlignment: CrossAxisAlignment.end,
//                 // textBaseline: TextBaseline.alphabetic,
//                 children: [
//                   // Text(
//                   //   "Select Tank",
//                   //   style: GoogleFonts.ramabhadra(
//                   //     fontSize: 20,
//                   //     color: Colors.black,
//                   //   ),
//                   // ),
//                   const SizedBox(width: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.green,
//                         radius: 10,
//                       ),
//                       const SizedBox(width: 5),
//                       Text(
//                         "Pass",
//                         style: GoogleFonts.ramabhadra(
//                           fontSize: 11,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(width: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const CircleAvatar(
//                         backgroundColor: Colors.yellow,
//                         radius: 10,
//                       ),
//                       const SizedBox(width: 5),
//                       Text(
//                         "Waiting Check",
//                         style: GoogleFonts.ramabhadra(
//                           fontSize: 11,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(width: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const CircleAvatar(
//                         backgroundColor: Colors.red,
//                         radius: 10,
//                       ),
//                       const SizedBox(width: 5),
//                       Text(
//                         "NG Value",
//                         style: GoogleFonts.ramabhadra(
//                           fontSize: 11,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.visibility),
//               onPressed: () => _showSettingsDialog(context),
//             ),
//           ],
//         ),
//         body: Stack(
//           children: [
//             Positioned.fill(
//               child: Container(
//                 color: Colors.indigo[50],
//               ),
//             ),
//             Positioned.fill(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: LayoutBuilder(
//                       builder: (context, constraints) {
//                         int crossAxisCount =
//                             (constraints.maxWidth / 200).floor();
//                         double cardWidth =
//                             constraints.maxWidth / crossAxisCount -
//                                 defaultPadding;
//                         double cardHeight = 600;

//                         return SingleChildScrollView(
//                           padding: const EdgeInsets.all(defaultPadding),
//                           child: Column(
//                             children: [
//                               const SizedBox(height: defaultPadding),
//                               GridView.builder(
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: visibleKeys.length,
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: crossAxisCount,
//                                   crossAxisSpacing: defaultPadding,
//                                   mainAxisSpacing: defaultPadding,
//                                   childAspectRatio: cardWidth / cardHeight,
//                                 ),
//                                 itemBuilder: (context, index) {
//                                   int id = visibleKeys[index];
//                                   return HoverableCard(
//                                     onTap: () => _navigateToTank(id),
//                                     child: FileInfoCard(
//                                       info: demoMyFiles[id - 1],
//                                       onTap: () => _navigateToTank(id),
//                                       width: cardWidth,
//                                       height: cardHeight,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showSettingsDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Tanks Visibility',
//               style: GoogleFonts.ramabhadra(color: Colors.black)),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 for (var id in visibilityStates.keys)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Tank $id',
//                           style: GoogleFonts.ramabhadra(color: Colors.black)),
//                       Switch(
//                         value: visibilityStates[id]!,
//                         onChanged: (bool value) {
//                           _toggleVisibility(id);
//                           Navigator.of(context).pop();
//                           _showSettingsDialog(context);
//                         },
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class HoverableCard extends StatefulWidget {
//   final Widget child;
//   final VoidCallback onTap;

//   const HoverableCard({
//     Key? key,
//     required this.child,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   _HoverableCardState createState() => _HoverableCardState();
// }

// class _HoverableCardState extends State<HoverableCard> {
//   bool _isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() => _isHovered = false),
//       child: GestureDetector(
//         onTap: () {
//           print("Card tapped");
//           widget.onTap();
//         },
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 50),
//           curve: Curves.easeInOut,
//           transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: _isHovered
//                 ? [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 15,
//                       offset: Offset(0, 10),
//                     ),
//                   ]
//                 : [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//           ),
//           child: widget.child,
//         ),
//       ),
//     );
//   }
// }
