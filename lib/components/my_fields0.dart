// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:newmaster/constants.dart';
// import 'package:newmaster/models/MyFiles.dart';
// import 'package:newmaster/responsive.dart';

// import 'file_info_card.dart';

// class MyFiles extends StatefulWidget {
//   MyFiles({
//     Key? key,
//     this.taptaptap,
//   }) : super(key: key);
//   Function(CloudStorageInfo)? taptaptap;

//   @override
//   _MyFilesState createState() => _MyFilesState();
// }

// class _MyFilesState extends State<MyFiles> {
//   late CloudStorageInfo? _selectedFileInfo;
//   late List<Map<String, dynamic>> tableData = [];
//   late Timer _timer; // Timer variable

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromAPI();

//     // Start timer to fetch data every 5 minutes
//     _timer =
//         Timer.periodic(Duration(seconds: 5), (Timer t) => fetchDataFromAPI());
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _timer
//         .cancel(); // Cancel timer when the widget is disposed to prevent memory leaks
//   }

//   // Fetch data from API
//   Future<void> fetchDataFromAPI() async {
//     final url = 'http://127.0.0.1:1882/manual-feed-user';
//     try {
//       final response = await http.post(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = json.decode(response.body);
//         // Check if new data is fetched
//         bool newDataFetched =
//             tableData.isNotEmpty && responseData.length > tableData.length;

//         setState(() {
//           tableData = responseData.cast<Map<String, dynamic>>();
//           // Initialize showDetails list with false for each row
//         });

//         if (newDataFetched) {
//           // Show the popup for 10 seconds if new data is fetched
//           _showPopupForTenSeconds();
//         }
//       } else {
//         throw Exception('Failed to fetch data');
//       }
//     } catch (error) {
//       print('Error: $error');
//     }
//   }

//   void _showPopupForTenSeconds() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('แจ้งเตือน'),
//           content: Text('ได้รับข้อมูลเคมีที่ต้องเติมเพิ่ม'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('ยืนยัน'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   "Select Tank",
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 SizedBox(width: 25), // Add spacing between text and icons
//                 CircleAvatar(
//                   backgroundColor:
//                       Colors.green, // Customize the color of the circle icon
//                   radius: 10, // Customize the size of the circle icon
//                 ),
//                 SizedBox(width: 5),
//                 Text(
//                   "Pass",
//                   style: GoogleFonts.ramabhadra(
//                     fontSize: 11, // Set the desired font size here
//                     // You can also customize other text properties here if needed
//                   ),
//                 ),
//                 SizedBox(width: 15), // Add spacing between circle icons
//                 CircleAvatar(
//                   backgroundColor:
//                       Colors.yellow, // Customize the color of the circle icon
//                   radius: 10, // Customize the size of the circle icon
//                 ),
//                 SizedBox(width: 5),
//                 Text(
//                   "Waiting Check",
//                   style: GoogleFonts.ramabhadra(
//                     fontSize: 11, // Set the desired font size here
//                     // You can also customize other text properties here if needed
//                   ),
//                 ),
//                 SizedBox(width: 15),
//                 CircleAvatar(
//                   backgroundColor:
//                       Colors.red, // Customize the color of the circle icon
//                   radius: 10, // Customize the size of the circle icon
//                 ),
//                 SizedBox(width: 5),
//                 Text(
//                   "NG Value",
//                   style: GoogleFonts.ramabhadra(
//                     fontSize: 11, // Set the desired font size here
//                     // You can also customize other text properties here if needed
//                   ),
//                 )
//                 // Add more CircleAvatar widgets as needed
//               ],
//             ),
//           ],
//         ),
//         SizedBox(height: defaultPadding),
//         Responsive(
//           mobile: FileInfoCardGridView(
//             taptap: widget.taptaptap,
//             crossAxisCount: _size.width < 650 ? 2 : 4,
//             childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
//           ),
//           tablet: FileInfoCardGridView(
//             taptap: widget.taptaptap,
//           ),
//           desktop: FileInfoCardGridView(
//             taptap: widget.taptaptap,
//             childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class FileInfoCardGridView extends StatelessWidget {
//   FileInfoCardGridView({
//     Key? key,
//     this.crossAxisCount = 5,
//     this.childAspectRatio = 1,
//     this.taptap,
//   }) : super(key: key);

//   final int crossAxisCount;
//   final double childAspectRatio;
//   Function(CloudStorageInfo)? taptap;

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
//       itemBuilder: (context, index) {
//         return FileInfoCardGridView(
//           info: demoMyFiles[index],
//           tapping: (v) {
//             if (taptap != null) {
//               taptap!(demoMyFiles[index]);
//             }
//           },
//         );
//       },
//     );
//   }

//   void _showPopup(BuildContext context, CloudStorageInfo fileInfo) {
//     // You can modify this function to customize the popup as needed
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('แจ้งเตือน'),
//           content: Text('ได้รับข้อมูลเคมีที่ต้องเติมเพิ่ม'),
//         );
//       },
//     );
//   }
// }
