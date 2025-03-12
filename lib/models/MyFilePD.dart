// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:newmaster/models/MyFiles.dart';

// // Model class for CloudStorageInfoPD
// class CloudStorageInfoPD {
//   final String? tank, title, totalStorage, numOfFiles;

//   final int? percentage, id;
//   Color? color, color2;
//   double? FCValues,
//       HCLValues,
//       PLZValues,
//       PB3650Values,
//       AC9131Values,
//       PB181XValues,
//       AC10131Values,
//       LUB4618Values,
//       NT134055Values,
//       LUB235Values,
//       NT144055Values;

//   CloudStorageInfoPD({
//     this.tank,
//     this.title,
//     this.totalStorage,
//     this.numOfFiles,
//     this.percentage,
//     this.color,
//     this.id,
//     this.color2,
//     this.FCValues,
//     this.HCLValues,
//     this.PLZValues,
//     this.PB3650Values,
//     this.AC9131Values,
//     this.PB181XValues,
//     this.AC10131Values,
//     this.LUB4618Values,
//     this.NT134055Values,
//     this.LUB235Values,
//     this.NT144055Values,
//   });
// }

// // Demo data for multiple graphs
// List<CloudStorageInfoPD> demoMyFiles1 = [
//   // CloudStorageInfoPD(
//   //   id: 1,
//   //   tank: " ยังไม่เปิดการใช้งาน",
//   //   title: "",
//   //   totalStorage: "Tank1",
//   //   color: Colors.grey,
//   //   percentage: 99,
//   //   color2: Colors.transparent,
//   // ),
//   CloudStorageInfoPD(
//     id: 2,
//     tank: "Tank2 (3-2)",
//     title: "Degreasing",
//     numOfFiles: "4 Times/day",
//     // svgSrc: "assets/icons/tank01.svg",
//     totalStorage: "(3-2) FC-4360",
//     color: Colors.grey,
//     percentage: 99,
//     color2: Colors.transparent,
//   ),
//   // CloudStorageInfoPD(
//   //   id: 3,
//   //   tank: "Tank3 (3-3)",
//   //   title: " ยังไม่เปิดการใช้งาน",
//   //   totalStorage: "Tank3",
//   //   color: Colors.grey,
//   //   percentage: 99,
//   //   color2: Colors.transparent,
//   // ),
//   // CloudStorageInfoPD(
//   //   id: 4,
//   //   tank: "Tank4 (3-4)",
//   //   title: "ยังไม่เปิดการใช้งาน",
//   //   totalStorage: "Tank4",
//   //   color: Colors.grey,
//   //   percentage: 99,
//   //   color2: Colors.transparent,
//   // ),
//   CloudStorageInfoPD(
//     id: 5,
//     tank: "Tank5 (3-5)",
//     title: "Acid picking No.1",
//     numOfFiles: "2 Times/day",
//     // svgSrc: "assets/icons/tank3.svg",
//     totalStorage: "(3-5) HCl",
//     color: Colors.grey,
//     percentage: 99,
//     color2: Colors.transparent,
//   ),
//   // CloudStorageInfoPD(
//   //   id: 6,
//   //   tank: "Tank6 (3-6)",
//   //   title: " ยังไม่เปิดการใช้งาน",
//   //   totalStorage: "Tank6",
//   //   color: Colors.grey,
//   //   percentage: 99,
//   //   color2: Colors.transparent,
//   // ),
//   // CloudStorageInfoPD(
//   //   id: 7,
//   //   tank: "Tank7 (3-7)",
//   //   title: " ยังไม่เปิดการใช้งาน",
//   //   totalStorage: "Tank7",
//   //   color: Colors.grey,
//   //   percentage: 99,
//   //   color2: Colors.transparent,
//   // ),
//   CloudStorageInfoPD(
//     id: 8,
//     tank: "Tank8 (3-8)",
//     title: "Surface condition",
//     numOfFiles: "4 Times/day",
//     // svgSrc: "assets/icons/tank6.svg",
//     totalStorage: "(3-8) PL-ZN",
//     color: Colors.grey,
//     percentage: 99,
//     color2: Colors.transparent,
//   ),
//   CloudStorageInfoPD(
//     id: 9,
//     tank: "Tank9 (3-9)",
//     title: "Phosphate",
//     numOfFiles: "4 Times/day",
//     // svgSrc: "assets/icons/tank3.svg",
//     totalStorage: "(3-9) PB-3650X",
//     color: Colors.grey,
//     percentage: 99,
//     color2: Colors.transparent,
//   ),
//   CloudStorageInfoPD(
//     id: 10,
//     tank: "Tank10 (3-10)",
//     title: "Phosphate",
//     numOfFiles: "4 Times/day",
//     // svgSrc: "assets/icons/tank3.svg",
//     totalStorage: "(3-10) PB-181X",
//     color: Colors.grey,
//     percentage: 99,
//     color2: Colors.transparent,
//   ),
//   // CloudStorageInfoPD(
//   //   id: 11,
//   //   tank: "Tank11 (3-11)",
//   //   title: " ยังไม่เปิดการใช้งาน",
//   //   totalStorage: "Tank11",
//   //   color: Colors.grey,
//   //   percentage: 99,
//   //   color2: Colors.transparent,
//   // ),
//   // CloudStorageInfoPD(
//   //   id: 12,
//   //   tank: "Tank12 (3-12)",
//   //   title: " ยังไม่เปิดการใช้งาน",
//   //   totalStorage: "Tank12",
//   //   color: Colors.grey,
//   //   percentage: 99,
//   //   color2: Colors.transparent,
//   // ),
//   CloudStorageInfoPD(
//     id: 13,
//     tank: "Tank13 (3-13)",
//     title: "Lubricant",
//     numOfFiles: "4 Times/day",
//     // svgSrc: "assets/icons/tank4.svg",
//     totalStorage: "(3-13) LUB-4618",
//     color: Colors.grey,
//     percentage: 99,
//     color2: Colors.transparent,
//   ),
//   CloudStorageInfoPD(
//     id: 14,
//     tank: "Tank14 (3-14)",
//     title: "Lubricant",
//     numOfFiles: "4 Times/day",
//     // svgSrc: "assets/icons/tank4.svg",
//     totalStorage: "(3-14) LUB-235T",
//     color: Colors.grey,
//     percentage: 99,
//     color2: Colors.transparent,
//   ),
// ];

// Future<void> fetchStatusAndUpdateColors() async {
//   try {
//     final response = await http.post(
//       Uri.parse('http://127.0.0.1:1882/status'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{}),
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);

//       for (var item in data) {
//         int id = item['id'];
//         int color = item['color'];

//         CloudStorageInfo? cloudStorageInfo;

//         for (var storageInfo in demoMyFiles) {
//           if (storageInfo.id == id) {
//             cloudStorageInfo = storageInfo;
//             break;
//           }
//         }

//         if (cloudStorageInfo != null) {
//           switch (color) {
//             case 0:
//               cloudStorageInfo.color2 = Color.fromARGB(255, 255, 28, 28);
//               break;
//             case 1:
//               cloudStorageInfo.color2 = Color.fromARGB(255, 229, 156, 0);
//               break;
//             case 2:
//               cloudStorageInfo.color2 = Color.fromARGB(255, 28, 168, 61);
//               break;
//             default:
//               cloudStorageInfo.color2 = Colors.transparent;
//           }

//           if (id == 2) {
//             final responseFAL =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank2-fal'));
//             final responseTemp =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank2-temp'));
//             if (responseFAL.statusCode == 200 &&
//                 responseTemp.statusCode == 200) {
//               final List<dynamic> responseDataFAL =
//                   json.decode(responseFAL.body);
//               final List<dynamic> responseDataTemp =
//                   json.decode(responseTemp.body);

//               cloudStorageInfo.falValue =
//                   double.parse(responseDataFAL.last['value'] ?? '0');
//               cloudStorageInfo.tempValue =
//                   double.parse(responseDataTemp.last['value'] ?? '0');
//             } else {
//               throw Exception('Failed to fetch Tank 2 data');
//             }
//           }

//           if (id == 5) {
//             final responseFE =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank5-fe'));
//             final responseCON =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank5-con'));
//             if (responseFE.statusCode == 200 && responseCON.statusCode == 200) {
//               final List<dynamic> responseDataFE = json.decode(responseFE.body);
//               final List<dynamic> responseDataCON =
//                   json.decode(responseCON.body);

//               cloudStorageInfo.feValue =
//                   double.parse(responseDataFE.last['value'] ?? '0');
//               cloudStorageInfo.conValue =
//                   double.parse(responseDataCON.last['value'] ?? '0');
//             } else {
//               throw Exception('Failed to fetch Tank 5 data');
//             }
//           }

//           if (id == 8) {
//             final responseTAL =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank8-tal'));
//             final responsePH =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank8-ph'));
//             if (responseTAL.statusCode == 200 && responsePH.statusCode == 200) {
//               final List<dynamic> responseDataTAL =
//                   json.decode(responseTAL.body);
//               final List<dynamic> responseDataPH = json.decode(responsePH.body);

//               cloudStorageInfo.talValue =
//                   double.parse(responseDataTAL.last['value'] ?? '0');
//               cloudStorageInfo.phValue =
//                   double.parse(responseDataPH.last['value'] ?? '0');
//             } else {
//               throw Exception('Failed to fetch Tank 8 data');
//             }
//           }

//           if (id == 9) {
//             final responseTA =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank9-TA'));
//             final responseFA =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank9-FA'));
//             final responseAR =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank9-AR'));
//             final responseAC =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank9-AC'));
//             final responseTemp =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank9-temp'));
//             if (responseTA.statusCode == 200 &&
//                 responseFA.statusCode == 200 &&
//                 responseAR.statusCode == 200 &&
//                 responseAC.statusCode == 200 &&
//                 responseTemp.statusCode == 200) {
//               final List<dynamic> responseDataTA = json.decode(responseTA.body);
//               final List<dynamic> responseDataFA = json.decode(responseFA.body);
//               final List<dynamic> responseDataAR = json.decode(responseAR.body);
//               final List<dynamic> responseDataAC = json.decode(responseAC.body);
//               final List<dynamic> responseDataTemp =
//                   json.decode(responseTemp.body);

//               cloudStorageInfo.taValue =
//                   double.parse(responseDataTA.last['value'] ?? '0');
//               cloudStorageInfo.faValue =
//                   double.parse(responseDataFA.last['value'] ?? '0');
//               cloudStorageInfo.arValue =
//                   double.parse(responseDataAR.last['value'] ?? '0');
//               cloudStorageInfo.acValue =
//                   double.parse(responseDataAC.last['value'] ?? '0');
//               cloudStorageInfo.tank9tempValue =
//                   double.parse(responseDataTemp.last['value'] ?? '0');
//             } else {
//               throw Exception('Failed to fetch Tank 9 data');
//             }
//           }

//           if (id == 10) {
//             final responseTA =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank10-TA'));
//             final responseFA =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank10-FA'));
//             final responseAR =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank10-AR'));
//             final responseAC =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank10-AC'));
//             final responseTemp = await http
//                 .post(Uri.parse('http://127.0.0.1:1882/tank10-rtemp'));
//             if (responseTA.statusCode == 200 &&
//                 responseFA.statusCode == 200 &&
//                 responseAR.statusCode == 200 &&
//                 responseAC.statusCode == 200 &&
//                 responseTemp.statusCode == 200) {
//               final List<dynamic> responseDataTA = json.decode(responseTA.body);
//               final List<dynamic> responseDataFA = json.decode(responseFA.body);
//               final List<dynamic> responseDataAR = json.decode(responseAR.body);
//               final List<dynamic> responseDataAC = json.decode(responseAC.body);
//               final Map<String, dynamic> responseDataTemp =
//                   json.decode(responseTemp.body);
//               cloudStorageInfo.taValue10 =
//                   double.parse(responseDataTA.last['value'] ?? '0');
//               cloudStorageInfo.faValue10 =
//                   double.parse(responseDataFA.last['value'] ?? '0');
//               cloudStorageInfo.arValue10 =
//                   double.parse(responseDataAR.last['value'] ?? '0');
//               cloudStorageInfo.acValue10 =
//                   double.parse(responseDataAC.last['value'] ?? '0');
//               cloudStorageInfo.acValue =
//                   double.parse(responseDataAC.last['value'] ?? '0');
//               cloudStorageInfo.tank10tempValue = double.tryParse(
//                       responseDataTemp['value']?.toString() ?? '0') ??
//                   0.0;
//               print('Temp Value: ${cloudStorageInfo.tank10tempValue}');
//             } else {
//               throw Exception('Failed to fetch Tank 10 data');
//             }
//           }
//           if (id == 13) {
//             final responseCON =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank13-con'));
//             final responseFA =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank13-FA'));
//             final responseTemp =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank13-temp'));
//             if (responseCON.statusCode == 200 &&
//                 responseFA.statusCode == 200 &&
//                 responseTemp.statusCode == 200) {
//               final List<dynamic> responseDataCON =
//                   json.decode(responseCON.body);
//               final List<dynamic> responseDataFA = json.decode(responseFA.body);
//               final List<dynamic> responseDataTemp =
//                   json.decode(responseTemp.body);
//               cloudStorageInfo.conValue13 =
//                   double.parse(responseDataCON.last['value'] ?? '0');
//               cloudStorageInfo.faValue13 =
//                   double.parse(responseDataFA.last['value'] ?? '0');
//               cloudStorageInfo.tank13TempValue =
//                   double.parse(responseDataTemp.last['value'] ?? '0');
//             } else {
//               throw Exception('Failed to fetch Tank 13 data');
//             }
//           }

//           if (id == 14) {
//             final responseCON =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank14-con'));
//             final responseFA =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank14-FA'));
//             final responseTemp =
//                 await http.post(Uri.parse('http://127.0.0.1:1882/tank14-temp'));
//             if (responseCON.statusCode == 200 &&
//                 responseFA.statusCode == 200 &&
//                 responseTemp.statusCode == 200) {
//               final List<dynamic> responseDataCON =
//                   json.decode(responseCON.body);
//               final List<dynamic> responseDataFA = json.decode(responseFA.body);
//               final List<dynamic> responseDataTemp =
//                   json.decode(responseTemp.body);
//               cloudStorageInfo.conValue14 =
//                   double.parse(responseDataCON.last['value'] ?? '0');
//               cloudStorageInfo.faValue14 =
//                   double.parse(responseDataFA.last['value'] ?? '0');
//               cloudStorageInfo.tank14TempValue =
//                   double.parse(responseDataTemp.last['value'] ?? '0');
//             } else {
//               throw Exception('Failed to fetch Tank 14 data');
//             }
//           }
//         } else {
//           print('CloudStorageInfo with ID $id not found');
//         }
//       }
//     } else {
//       print('Failed to fetch data: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
