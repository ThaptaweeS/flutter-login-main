
// import 'package:newmaster/responsive.dart';
// import 'package:flutter/material.dart';
// import 'package:newmaster/models/MyFiles.dart';
// import '../../../constants.dart';
// import 'file_info_card.dart';

// class Chart0 extends StatelessWidget {
//   const Chart0({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "My Files",
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//             ElevatedButton.icon(
//               style: TextButton.styleFrom(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: defaultPadding * 1.5,
//                   vertical:
//                       defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
//                 ),
//               ),
//               onPressed: () {},
//               icon: Icon(Icons.add),
//               label: Text("Add New"),
//             ),
//           ],
//         ),
//         SizedBox(height: defaultPadding),
//         Responsive(
//           mobile: Chart0GridView(
//             crossAxisCount: _size.width < 650 ? 2 : 4,
//             childAspectRatio: _size.width < 650 ? 1.3 : 1,
//           ),
//           tablet: Chart0GridView(),
//           desktop: Chart0GridView(
//             childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class Chart0GridView extends StatelessWidget {
//   const Chart0GridView({
//     Key? key,
//     this.crossAxisCount = 4,
//     this.childAspectRatio = 1,
//   }) : super(key: key);

//   final int crossAxisCount;
//   final double childAspectRatio;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: demoMyFiles.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossAxisCount,
//         crossAxisSpacing: defaultPadding,
//         mainAxisSpacing: defaultPadding,
//         childAspectRatio: childAspectRatio,
//       ),
//       itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
//     );
//   }
// }
