import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
}

List<CloudStorageInfo> demoMyFiles = [
  CloudStorageInfo(
    id: 4,
    title: "Tank2 : Degreasing",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank01.svg",
    totalStorage: "(3-2) 6700 liter",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 5,
    title: "Tank5 : Acid Picking No.1",
    numOfFiles: "2 Times/day",
    svgSrc: "assets/icons/tank3.svg",
    totalStorage: "(3-5) 5000 liter",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 8,
    title: "Tank8 : Surface condition",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank6.svg",
    totalStorage: "(3-8) 5100 liter",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 9,
    title: "Tank9 : Phosphate",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank3.svg",
    totalStorage: "(3-9) 5100 liter",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 10,
    title: "Tank10 : Phosphate",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank3.svg",
    totalStorage: "(3-10) 5100 liter",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 13,
    title: "Tank13 : Lubricant",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank4.svg",
    totalStorage: "(3-13) 5100 liter",
    color: Color.fromARGB(255, 127, 138, 152),
    percentage: 99,
    color2: Colors.transparent, // Initialize color2 to a default value
  ),
  CloudStorageInfo(
    id: 14,
    title: "Tank14 : Lubricant",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank4.svg",
    totalStorage: "(3-14) 5100 liter",
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
