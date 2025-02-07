// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:newmaster/constants.dart';
// import 'package:newmaster/models/MyFilePD.dart';

// class FileInfoCardPD extends StatefulWidget {
//   final CloudStorageInfoPD info;
//   final Function(String)? tapping;

//   final double width;
//   final double height;

//   FileInfoCardPD({
//     Key? key,
//     this.tapping,
//     required this.info,
//     required this.width,
//     required this.height,
//   }) : super(key: key);

//   _FileInfoCardPDState createState() => _FileInfoCardPDState();
// }

// class _FileInfoCardPDState extends State<FileInfoCardPD> {
//   late Timer timer;
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Container(
//         padding: const EdgeInsets.all(defaultPadding),
//         height: widget.height,
//         width: widget.width,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey,
//               offset: Offset(2, 1),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(defaultPadding * 0.55),
//                   height: 100,
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: widget.info.color?.withOpacity(0.1) ??
//                         Colors.transparent,
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: defaultPadding),
//             Text(
//               widget.info.tank ?? '',
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: GoogleFonts.ramabhadra(
//                 fontSize: 16,
//                 // fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             Text(
//               widget.info.title ?? '',
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: GoogleFonts.ramabhadra(
//                 fontSize: 16,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: defaultPadding / 2),
//             Text(
//               widget.info.totalStorage ?? '',
//               style: GoogleFonts.ramabhadra(
//                 fontSize: 14,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: defaultPadding),
//           ],
//         ),
//       ),
//     );
//   }
// }
