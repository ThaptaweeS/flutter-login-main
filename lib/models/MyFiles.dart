import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CloudStorageInfo {
  final String? svgSrc, tank, title, totalStorage, numOfFiles;
  final int? percentage, id;
  Color? color, color2;
  double? falValue,
      tempValue,
      feValue,
      conValue,
      talValue,
      phValue,
      taValue,
      faValue,
      arValue,
      acValue,
      tank9tempValue,
      taValue10,
      faValue10,
      arValue10,
      acValue10,
      tank10tempValue,
      conValue13,
      faValue13,
      tank13TempValue,
      conValue14,
      faValue14,
      tank14TempValue,
      FC4360value,
      HCIValue,
      PLZValue,
      pb3650Value,
      ac9Value;

  CloudStorageInfo({
    this.svgSrc,
    this.tank,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
    this.id,
    this.color2,
    this.falValue,
    this.tempValue,
    this.feValue,
    this.conValue,
    this.talValue,
    this.phValue,
    this.taValue,
    this.faValue,
    this.arValue,
    this.acValue,
    this.tank9tempValue,
    this.taValue10,
    this.faValue10,
    this.arValue10,
    this.acValue10,
    this.tank10tempValue,
    this.conValue13,
    this.faValue13,
    this.tank13TempValue,
    this.conValue14,
    this.faValue14,
    this.tank14TempValue,
    this.FC4360value,
    this.HCIValue,
    this.PLZValue,
    this.pb3650Value,
    this.ac9Value,
  });

  get statusColor => null;
}

List<CloudStorageInfo> demoMyFiles = [
  CloudStorageInfo(
    id: 1,
    tank: " ยังไม่เปิดการใช้งาน",
    title: "",
    totalStorage: "Tank1",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
  CloudStorageInfo(
    id: 2,
    tank: "Tank2 (3-2)",
    title: "Degreasing",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank01.svg",
    totalStorage: "(3-2) FC-4360",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
  CloudStorageInfo(
    id: 3,
    tank: "Tank3 (3-3)",
    title: " ยังไม่เปิดการใช้งาน",
    totalStorage: "Tank3",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
  CloudStorageInfo(
    id: 4,
    tank: "Tank4 (3-4)",
    title: "ยังไม่เปิดการใช้งาน",
    totalStorage: "Tank4",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
  CloudStorageInfo(
    id: 5,
    tank: "Tank5 (3-5)",
    title: "Acid picking No.1",
    numOfFiles: "2 Times/day",
    svgSrc: "assets/icons/tank3.svg",
    totalStorage: "(3-5) HCl",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
  CloudStorageInfo(
    id: 6,
    tank: "Tank6 (3-6)",
    title: " ยังไม่เปิดการใช้งาน",
    totalStorage: "Tank6",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
  CloudStorageInfo(
    id: 7,
    tank: "Tank7 (3-7)",
    title: " ยังไม่เปิดการใช้งาน",
    totalStorage: "Tank7",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
  CloudStorageInfo(
    id: 8,
    tank: "Tank8 (3-8)",
    title: "Surface condition",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank6.svg",
    totalStorage: "(3-8) PL-ZN",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
  CloudStorageInfo(
    id: 9,
    tank: "Tank9 (3-9)",
    title: "Phosphate",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank3.svg",
    totalStorage: "(3-9) PB-3650X",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
  CloudStorageInfo(
    id: 10,
    tank: "Tank10 (3-10)",
    title: "Phosphate",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank3.svg",
    totalStorage: "(3-10) PB-181X",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
  CloudStorageInfo(
    id: 11,
    tank: "Tank11 (3-11)",
    title: " ยังไม่เปิดการใช้งาน",
    totalStorage: "Tank11",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
  CloudStorageInfo(
    id: 12,
    tank: "Tank12 (3-12)",
    title: " ยังไม่เปิดการใช้งาน",
    totalStorage: "Tank12",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
  CloudStorageInfo(
    id: 13,
    tank: "Tank13 (3-13)",
    title: "Lubricant",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank4.svg",
    totalStorage: "(3-13) LUB-4618",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
  CloudStorageInfo(
    id: 14,
    tank: "Tank14 (3-14)",
    title: "Lubricant",
    numOfFiles: "4 Times/day",
    svgSrc: "assets/icons/tank4.svg",
    totalStorage: "(3-14) LUB-235T",
    color: Colors.grey,
    percentage: 99,
    color2: Colors.transparent,
  ),
];

Future<void> fetchStatusAndUpdateColors() async {
  try {
    // print('Fetching API...');
    final response = await http.post(
      Uri.parse('http://172.23.10.51:1111/status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{}),
    );
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      for (var item in data) {
        int id = item['id'];
        int color = item['color'];

        CloudStorageInfo? cloudStorageInfo;

        for (var storageInfo in demoMyFiles) {
          if (storageInfo.id == id) {
            cloudStorageInfo = storageInfo;
            break;
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

          if (id == 2) {
            final responses = await Future.wait([
              http.post(Uri.parse('http://172.23.10.51:1111/tank2-falui')),
              http.post(Uri.parse('http://172.23.10.51:1111/tank2-rtemp')),
              http.post(Uri.parse('http://172.23.10.51:1111/chem-feed2')),
            ]);

            if (responses.every((res) => res.statusCode == 200)) {
              // print('Response body: ${response.body}');
              final responseDataFAL = json.decode(responses[0].body);
              final responseDataTemp = json.decode(responses[1].body);
              final responseDataFC4360 = json.decode(responses[2].body);
              cloudStorageInfo.falValue =
                  double.tryParse(responses[0].body.toString()) ?? 0.0;

              cloudStorageInfo.tempValue = double.tryParse(
                      responseDataTemp['value']?.toString() ?? '0') ??
                  0.0;
              cloudStorageInfo.FC4360value =
                  (responseDataFC4360.last['value'] ?? 0).toDouble();
              // print('FAL Value: ${cloudStorageInfo.falValue}');
              // print('Temp Value: ${cloudStorageInfo.tempValue}');
              // print('FC4360 Value: ${cloudStorageInfo.FC4360value}');
            } else {
              throw Exception('Failed to fetch Tank 2 data');
            }
          }
          if (id == 5) {
            final responseFE = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank5-feui'));

            final responseCON = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank5-conui'));
            final responseHCI = await http
                .post(Uri.parse('http://172.23.10.51:1111/chem-feed5'));
            if (responseFE.statusCode == 200 &&
                responseCON.statusCode == 200 &&
                responseHCI.statusCode == 200) {
              final responseDataFE = json.decode(responseFE.body);
              final responseDataCON = json.decode(responseCON.body);
              final List<dynamic> responseDataHCI =
                  json.decode(responseHCI.body);

              cloudStorageInfo.feValue =
                  double.tryParse(responseFE.body.toString()) ?? 0.0;
              cloudStorageInfo.conValue =
                  double.tryParse(responseDataCON.toString()) ?? 0.0;
              cloudStorageInfo.HCIValue =
                  (responseDataHCI.last['value'] ?? 0).toDouble();
            } else {
              throw Exception('Failed to fetch Tank 5 data');
            }
          }

          if (id == 8) {
            final responseTAL = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank8-talui'));
            final responsePH = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank8-phui'));
            final responsePLZ = await http
                .post(Uri.parse('http://172.23.10.51:1111/chem-feed8'));
            if (responseTAL.statusCode == 200 && responsePH.statusCode == 200) {
              final responseDataTAL = json.decode(responseTAL.body);
              final responseDataPH = json.decode(responsePH.body);
              final List<dynamic> responseDataPLZ =
                  json.decode(responsePLZ.body);

              cloudStorageInfo.talValue =
                  double.tryParse(responseDataTAL.toString()) ?? 0.0;
              cloudStorageInfo.phValue =
                  double.tryParse(responseDataPH.toString()) ?? 0.0;
              cloudStorageInfo.PLZValue =
                  (responseDataPLZ.last['value'] ?? 0).toDouble();
            } else {
              throw Exception('Failed to fetch Tank 8 data');
            }
          }

          if (id == 9) {
            final responseTA = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank9-TAui'));
            final responseFA = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank9-FAui'));
            final responseAR = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank9-ARui'));
            final responseAC = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank9-ACui'));
            final responseTemp = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank9-rtemp'));
            final responseAC131 = await http
                .post(Uri.parse('http://172.23.10.51:1111/chem-feed92'));
            final responsePB3650 = await http
                .post(Uri.parse('http://172.23.10.51:1111/chem-feed91'));
            if (responseTA.statusCode == 200 &&
                responseFA.statusCode == 200 &&
                responseAR.statusCode == 200 &&
                responseAC.statusCode == 200 &&
                responseTemp.statusCode == 200 &&
                responsePB3650.statusCode == 200 &&
                responseAC131.statusCode == 200) {
              final responseDataTA = json.decode(responseTA.body);
              final responseDataFA = json.decode(responseFA.body);
              final responseDataAR = json.decode(responseAR.body);
              final responseDataAC = json.decode(responseAC.body);
              final Map<String, dynamic> responseDataTemp =
                  json.decode(responseTemp.body);
              final List<dynamic> responseDataPB3650 =
                  json.decode(responsePB3650.body);
              final List<dynamic> responseDataAC131 =
                  json.decode(responseAC131.body);

              cloudStorageInfo.taValue =
                  double.tryParse(responseDataTA.toString()) ?? 0.0;
              cloudStorageInfo.faValue =
                  double.tryParse(responseDataFA.toString()) ?? 0.0;
              cloudStorageInfo.arValue =
                  double.tryParse(responseDataAR.toString()) ?? 0.0;
              cloudStorageInfo.acValue =
                  double.tryParse(responseDataAC.toString()) ?? 0.0;
              cloudStorageInfo.tank9tempValue = double.tryParse(
                      responseDataTemp['value']?.toString() ?? '0') ??
                  0.0;
              cloudStorageInfo.pb3650Value =
                  (responseDataPB3650.last['value'] ?? 0).toDouble();
              cloudStorageInfo.ac9Value =
                  (responseDataAC131.last['value'] ?? 0).toDouble();
            } else {
              throw Exception('Failed to fetch Tank 9 data');
            }
          }

          if (id == 10) {
            final responseTA = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank10-TAui'));
            final responseFA = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank10-FAui'));
            final responseAR = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank10-ARui'));
            final responseAC = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank10-ACui'));
            final responseTemp = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank10-rtemp'));
            if (responseTA.statusCode == 200 &&
                responseFA.statusCode == 200 &&
                responseAR.statusCode == 200 &&
                responseAC.statusCode == 200 &&
                responseTemp.statusCode == 200) {
              final responseDataTA = json.decode(responseTA.body);
              final responseDataFA = json.decode(responseFA.body);
              final responseDataAR = json.decode(responseAR.body);
              final responseDataAC = json.decode(responseAC.body);
              final Map<String, dynamic> responseDataTemp =
                  json.decode(responseTemp.body);
              cloudStorageInfo.taValue10 =
                  double.tryParse(responseDataTA.toString()) ?? 0.0;

              cloudStorageInfo.faValue10 =
                  double.tryParse(responseDataFA.toString()) ?? 0.0;
              cloudStorageInfo.arValue10 =
                  double.tryParse(responseDataAR.toString()) ?? 0.0;
              cloudStorageInfo.acValue10 =
                  double.tryParse(responseDataAC.toString()) ?? 0.0;

              cloudStorageInfo.tank10tempValue = double.tryParse(
                      responseDataTemp['value']?.toString() ?? '0') ??
                  0.0;
              // print('Temp Value: ${cloudStorageInfo.tank10tempValue}');
            } else {
              throw Exception('Failed to fetch Tank 10 data');
            }
          }

          if (id == 13) {
            final responseCON = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank13-conui'));
            final responseFA = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank13-FAui'));
            final responseTemp = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank13-rtemp'));
            if (responseCON.statusCode == 200 &&
                responseFA.statusCode == 200 &&
                responseTemp.statusCode == 200) {
              final responseDataCON = json.decode(responseCON.body);
              final responseDataFA = json.decode(responseFA.body);
              final Map<String, dynamic> responseDataTemp =
                  json.decode(responseTemp.body);
              cloudStorageInfo.conValue13 =
                  double.tryParse(responseDataCON.toString()) ?? 0.0;
              cloudStorageInfo.faValue13 =
                  double.tryParse(responseDataFA.toString()) ?? 0.0;
              cloudStorageInfo.tank13TempValue = double.tryParse(
                      responseDataTemp['value']?.toString() ?? '0') ??
                  0.0;
            } else {
              throw Exception('Failed to fetch Tank 13 data');
            }
          }

          if (id == 14) {
            final responseCON = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank14-conui'));
            final responseFA = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank14-FAui'));
            final responseTemp = await http
                .post(Uri.parse('http://172.23.10.51:1111/tank14-rtemp'));
            if (responseCON.statusCode == 200 &&
                responseFA.statusCode == 200 &&
                responseTemp.statusCode == 200) {
              final responseDataCON = json.decode(responseCON.body);
              final responseDataFA = json.decode(responseFA.body);
              final Map<String, dynamic> responseDataTemp =
                  json.decode(responseTemp.body);
              cloudStorageInfo.conValue14 =
                  double.tryParse(responseDataCON.toString()) ?? 0.0;
              cloudStorageInfo.faValue14 =
                  double.tryParse(responseDataCON.toString()) ?? 0.0;
              cloudStorageInfo.tank14TempValue = double.tryParse(
                      responseDataTemp['value']?.toString() ?? '0') ??
                  0.0;
            } else {
              throw Exception('Failed to fetch Tank 14 data');
            }
          }
        } else {
          print('CloudStorageInfo with ID $id not found');
        }
      }
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
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
