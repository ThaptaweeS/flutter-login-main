import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage, numOfFiles;
  final int? percentage, id;
  Color? color, color2;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
    this.id,
    this.color2,
  });

  get statusColor => null;
}

List<CloudStorageInfo> demoMyFiles = [
  CloudStorageInfo(
    id: 1,
    title: " ยังไม่เปิดการใช้งาน",
    // numOfFiles: "4 Times/day",
    // svgSrc: "assets/icons/tank3.svg",
    totalStorage: "Tank1",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 2,
    title: " Tank2 : Degreasing",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank01.svg",
    totalStorage: "(3-2) FC-4360",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 3,
    title: " ยังไม่เปิดการใช้งาน",
    // numOfFiles: "4 Times/day",
    // svgSrc: "assets/icons/tank3.svg",
    totalStorage: "Tank3",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 4,
    title: "ยังไม่เปิดการใช้งาน",
    // numOfFiles: "4 Times/day",
    // svgSrc: "assets/icons/tank01.svg",
    totalStorage: "Tank4",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 5,
    title: "Tank5 : Acid Picking No.1",
    numOfFiles: "2 Times/day",
    svgSrc: "assets/icons/tank3.svg",
    totalStorage: "(3-5) HCl 35 %",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 6,
    title: " ยังไม่เปิดการใช้งาน",
    // numOfFiles: "4 Times/day",
    // svgSrc: "assets/icons/tank3.svg",
    totalStorage: "Tank6",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 7,
    title: " ยังไม่เปิดการใช้งาน",
    // numOfFiles: "4 Times/day",
    // svgSrc: "assets/icons/tank3.svg",
    totalStorage: "Tank7",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 8,
    title: "Tank8 : Surface condition",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank6.svg",
    totalStorage: "(3-8) PL-ZN",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 9,
    title: "Tank9 : Phosphate",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank3.svg",
    totalStorage: "(3-9) PB-3650XM",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 10,
    title: "Tank10 : Phosphate",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank3.svg",
    totalStorage: "(3-10) PB-181X(M)",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 11,
    title: " ยังไม่เปิดการใช้งาน",
    // numOfFiles: "4 Times/day",
    // svgSrc: "assets/icons/tank3.svg",
    totalStorage: "Tank11",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 12,
    title: " ยังไม่เปิดการใช้งาน",
    // numOfFiles: "4 Times/day",
    // svgSrc: "assets/icons/tank3.svg",
    totalStorage: "Tank12",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 13,
    title: "Tank13 : Lubricant",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank4.svg",
    totalStorage: "(3-13) LUB-4618",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 14,
    title: "Tank14 : Lubricant",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank4.svg",
    totalStorage: "(3-14) LUB-235",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
];

Future<void> fetchStatusAndUpdateColors() async {
  try {
    final response = await http.post(
      Uri.parse('http://172.23.10.51:1111/status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{}),
    );

    if (response.statusCode == 200) {
      // Decode the response body
      List<dynamic> data = jsonDecode(response.body);

      for (var item in data) {
        int id = item['id'];
        int color = item['color'];

        // Initialize cloudStorageInfo to null before the loop
        CloudStorageInfo? cloudStorageInfo;

        // Find the corresponding CloudStorageInfo object and update color2 based on status
        for (var storageInfo in demoMyFiles) {
          if (storageInfo.id == id) {
            cloudStorageInfo = storageInfo;
            break; // Exit the loop once the object is found
          }
        }

        if (cloudStorageInfo != null) {
          switch (color) {
            case 0:
              cloudStorageInfo.color2 = Color.fromARGB(255, 255, 28, 28);
              break;
            case 1:
              cloudStorageInfo.color2 = Color.fromARGB(255, 229, 156, 0);
              break;
            case 2:
              cloudStorageInfo.color2 = Color.fromARGB(255, 28, 168, 61);
              break;
            default:
              cloudStorageInfo.color2 = Colors.transparent;
          }
        } else {
          // Handle case where CloudStorageInfo object is not found
          print('CloudStorageInfo with ID $id not found');
        }
      }
    } else {
      // Handle error response
      print('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    // Handle network error
    print('Error: $e');
  }
}

class MyFile {
  final String title;
  final String svgSrc;
  final int numOfFiles;
  final double percentage;
  final Color color;

  MyFile({
    required this.title,
    required this.svgSrc,
    required this.numOfFiles,
    required this.percentage,
    required this.color,
  });
}
