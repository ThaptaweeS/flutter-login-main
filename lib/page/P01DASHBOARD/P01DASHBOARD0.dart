// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:newmaster/components/file_info_card.dart';
// import 'package:newmaster/data/global.dart';

// import '../../constants.dart';
// import '../../models/MyFiles.dart';

// late BuildContext MainBodyContext;

// class P1DASHBOARDMAIN0 extends StatefulWidget {
//   const P1DASHBOARDMAIN0({super.key});
//   @override
//   State<P1DASHBOARDMAIN0> createState() => _P1DASHBOARDMAIN0State();
// }

// class _P1DASHBOARDMAIN0State extends State<P1DASHBOARDMAIN0> {
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(Duration(seconds: 5), (timer) {
//       fetchStatusAndUpdateColors();
//       setState(() {});
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
//       void _toggleVisibility(int id) {
//         setState(() {
//           visibilityStates[id] = !visibilityStates[id]!;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     fetchStatusAndUpdateColors();

//     // Filter out hidden items
//     List<int> visibleKeys =
//         visibilityStates.keys.where((key) => visibilityStates[key]!).toList();

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: const Text('Tank Status Monitoring'),
//           // actions: [
//           //   IconButton(
//           //     icon: Icon(Icons.settings),
//           //     onPressed: () => _showSettingsDialog(context),
//           //   ),
//           // ],
//         ),
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.white, Colors.blue[100]!],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               int crossAxisCount = (constraints.maxWidth / 200)
//                   .floor(); // Adjust the item width as needed
//               return SingleChildScrollView(
//                 padding: const EdgeInsets.all(defaultPadding),
//                 child: Column(
//                   children: [
//                     const MyFilesHeader(),
//                     const SizedBox(height: defaultPadding),
//                     GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: visibleKeys.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: crossAxisCount,
//                         crossAxisSpacing: defaultPadding,
//                         mainAxisSpacing: defaultPadding,
//                         childAspectRatio:
//                             1, // Adjust the aspect ratio as needed
//                       ),
//                       itemBuilder: (context, index) {
//                         int id = visibleKeys[index];
//                         return FileInfoCard(
//                           info: demoMyFiles[id - 1],
//                           // onTap: () => _navigateToTank(id),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   void fetchStatusAndUpdateColors() {
//     // Dummy implementation
//   }

//   void _showSettingsDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Toggle Tanks Visibility',
//               style: TextStyle(color: Colors.black)),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 for (var id in visibilityStates.keys)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Tank $id', style: TextStyle(color: Colors.black)),
//                       Switch(
//                         value: visibilityStates[id]!,
//                         onChanged: (bool value) {
//                           _toggleVisibility(id);
//                           Navigator.of(context).pop();
//                           _showSettingsDialog(context); // Refresh dialog
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

// class MyFilesHeader extends StatelessWidget {
//   const MyFilesHeader();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Text(
//               "Select Tank",
//               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                     color: Colors.black,
//                   ),
//             ),
//             const SizedBox(width: 25),
//             const CircleAvatar(
//               backgroundColor: Colors.green,
//               radius: 10,
//             ),
//             const SizedBox(width: 5),
//             const Text(
//               "Pass",
//               style: TextStyle(
//                 fontSize: 11,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(width: 15),
//             const CircleAvatar(
//               backgroundColor: Colors.yellow,
//               radius: 10,
//             ),
//             const SizedBox(width: 5),
//             const Text(
//               "Waiting Check",
//               style: TextStyle(
//                 fontSize: 11,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(width: 15),
//             const CircleAvatar(
//               backgroundColor: Colors.red,
//               radius: 10,
//             ),
//             const SizedBox(width: 5),
//             const Text(
//               "NG Value",
//               style: TextStyle(
//                 fontSize: 11,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
