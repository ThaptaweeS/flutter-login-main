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
      tank14TempValue;

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
    print('Fetching API...');
    final response = await http.post(
      Uri.parse('http://172.23.10.51:1111/status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{}),
    );

    // print('Response Status: ${response.statusCode}');
    // print('Response Body: ${response.body}');

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      List<dynamic> data;
      try {
        data = jsonDecode(response.body);
      } catch (e) {
        print('JSON Decode Error: $e');
        return;
      }

      for (var item in data) {
        int id = item['id'];
        int color = item['color'];

        CloudStorageInfo? cloudStorageInfo = demoMyFiles.firstWhere(
          (storageInfo) => storageInfo.id == id,
          orElse: () => CloudStorageInfo(id: -1), // Placeholder object
        );

        if (cloudStorageInfo.id != -1) {
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
            try {
              final responses = await Future.wait([
                http.post(Uri.parse('http://172.23.10.51:1111/tank2-falvalue')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank2-rtemp')),
              ]);

              // for (int i = 0; i < responses.length; i++) {
              // print('Tank2 Response $i Status: ${responses[i].statusCode}');
              // print('Tank2 Response $i Body: ${responses[i].body}');
              // }
              if (responses[0].body.isNotEmpty) {
                try {
                  final responseDataFAL = jsonDecode(responses[0].body);
                  // print('T2FAL: ${responseDataFAL['value']}');

                  cloudStorageInfo.falValue =
                      double.tryParse(responseDataFAL['value'].toString()) ??
                          0.0;
                  // print('Tank2 FAL: ${cloudStorageInfo.falValue}');
                } catch (e) {
                  print('Error parsing JSON for FAL: $e');
                }
              }

              if (responses[1].body.isNotEmpty) {
                try {
                  final responseDataTemp = jsonDecode(responses[1].body);
                  // print('T2TEMP: ${responseDataTemp['value']}');
                  cloudStorageInfo.tempValue =
                      double.tryParse(responseDataTemp['value'].toString()) ??
                          0.0;
                  // print('Tank2 Temp: ${cloudStorageInfo.tempValue}');
                } catch (e) {
                  print('Error parsing JSON for Temp: $e');
                }
              }
            } catch (e) {
              print('Error in second API calls: $e');
            }
          }
          if (id == 5) {
            try {
              final responses = await Future.wait([
                http.post(Uri.parse('http://172.23.10.51:1111/tank5-fevalue')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank5-convalue')),
              ]);

              // for (int i = 0; i < responses.length; i++) {
              // print('Tank 5 Response $i Status: ${responses[i].statusCode}');
              // print('Tank 5 Response $i Body: ${responses[i].body}');
              // }

              if (responses[0].body.isNotEmpty) {
                try {
                  final responseDataFE = jsonDecode(responses[0].body);

                  cloudStorageInfo.feValue =
                      double.tryParse(responseDataFE['value'].toString()) ??
                          0.0;
                } catch (e) {
                  print('Error parsing JSON for FE: $e');
                }
              }
              if (responses[1].body.isNotEmpty) {
                try {
                  if (responses[1].body.isNotEmpty) {
                    final responseDataCON = jsonDecode(responses[1].body);
                    cloudStorageInfo.conValue =
                        double.tryParse(responseDataCON['value'].toString()) ??
                            0.0;
                  }
                } catch (e) {
                  print('Error parsing JSON for CON: $e');
                }
              }
            } catch (e) {
              print('Error in second API calls for Tank 5: $e');
            }
          }
          if (id == 8) {
            try {
              final responses = await Future.wait([
                http.post(Uri.parse('http://172.23.10.51:1111/tank8-talvalue')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank8-phui')),
              ]);

              // for (int i = 0; i < responses.length; i++) {
              //   print('Tank 8 Response $i Status: ${responses[i].statusCode}');
              //   print('Tank 8 Response $i Body: ${responses[i].body}');
              // }

              try {
                final responseDataTAL = jsonDecode(responses[0].body);
                if (responseDataTAL.containsKey('value')) {
                  cloudStorageInfo.talValue =
                      double.tryParse(responseDataTAL['value'].toString()) ??
                          0.0;
                } else {
                  print('Warning: Missing "value" key in TAL response');
                }
              } catch (e) {
                print('Error parsing JSON for TAL: $e');
              }
              try {
                final responseDataPH = jsonDecode(responses[1].body);
                if (responseDataPH.containsKey('value')) {
                  cloudStorageInfo.phValue =
                      double.tryParse(responseDataPH['value'].toString()) ??
                          0.0;
                  // print('Tank 8 PH: ${cloudStorageInfo.phValue}');
                } else {
                  print('Warning: Missing "value" key in PH response');
                }
              } catch (e) {
                print('Error parsing JSON for PH: $e');
              }
            } catch (e) {
              print('Error in second API calls for Tank 8: $e');
            }
          }
          if (id == 9) {
            try {
              final responses = await Future.wait([
                http.post(Uri.parse('http://172.23.10.51:1111/tank9-TAui')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank9-FAui')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank9-ARui')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank9-ACui')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank9-rtemp')),
              ]);

              // for (int i = 0; i < responses.length; i++) {
              //   print('Tank 9 Response $i Status: ${responses[i].statusCode}');
              //   print('Tank 9 Response $i Body: ${responses[i].body}');
              // }
              // print('Tank 9 Response 0: ${responses[0].body}');
              // print('Tank 9 Response 1: ${responses[1].body}');
              // print('Tank 9 Response 2: ${responses[2].body}');
              // print('Tank 9 Response 3: ${responses[3].body}');
              // print('Tank 9 Response 4: ${responses[4].body}');
              if (responses[0].body.isNotEmpty) {
                try {
                  final responseDataTA = jsonDecode(responses[0].body);
                  // print('Parsed TA Data: $responseDataTA');

                  cloudStorageInfo.taValue =
                      double.tryParse(responseDataTA['value'].toString()) ??
                          0.0;
                  // print('Tank 9 TA after parsing: ${cloudStorageInfo.taValue}');
                } catch (e) {
                  print('Error parsing JSON for FAL: $e');
                }
              } else {
                print('Error: tank9-talvalue returned an empty response');
              }
              if (responses[1].body.isNotEmpty) {
                try {
                  final responseFA = jsonDecode(responses[1].body);
                  cloudStorageInfo.faValue =
                      double.tryParse(responseFA['value'].toString()) ?? 0.0;
                  print('Tank 9 FA: ${cloudStorageInfo.faValue}');
                } catch (e) {
                  print('Error parsing JSON for FAL: $e');
                }
              } else {
                print('Error: tank9-falvalue returned an empty response');
              }
              if (responses[2].body.isNotEmpty) {
                try {
                  final responseAR = jsonDecode(responses[2].body);
                  cloudStorageInfo.arValue =
                      double.tryParse(responseAR['value'].toString()) ?? 0.0;
                  print('Tank 9 AR: ${cloudStorageInfo.arValue}');
                } catch (e) {
                  print('Error parsing JSON for FAL: $e');
                }
              } else {
                print('Error: tank9-falvalue returned an empty response');
              }
              if (responses[3].body.isNotEmpty) {
                try {
                  final responseAC = jsonDecode(responses[3].body);
                  cloudStorageInfo.acValue =
                      double.tryParse(responseAC['value'].toString()) ?? 0.0;
                  print('Tank 9 AC: ${cloudStorageInfo.acValue}');
                } catch (e) {
                  print('Error parsing JSON for FAL: $e');
                }
              } else {
                print('Error: tank9-AcValue returned an empty response');
              }
              if (responses[4].body.isNotEmpty) {
                try {
                  final responseTemp = jsonDecode(responses[4].body);
                  cloudStorageInfo.tank9tempValue =
                      double.tryParse(responseTemp['value'].toString()) ?? 0.0;
                  print('Tank 9 Temp: ${cloudStorageInfo.tank9tempValue}');
                } catch (e) {
                  print('Error parsing JSON for Temp;: $e');
                }
              } else {
                print('Error: One of the responses is empty or invalid JSON');
              }
            } catch (e) {
              print('Error in second API calls: $e');
            }
          }
          if (id == 10) {
            try {
              final responses = await Future.wait([
                http.post(Uri.parse('http://172.23.10.51:1111/tank10-TAui')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank10-FAui')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank10-ARui')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank10-ACui')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank10-rtemp')),
              ]);

              for (int i = 0; i < responses.length; i++) {
                // print('Tank 10 Response $i Status: ${responses[i].statusCode}');
                // print('Tank 10 Response $i Body: ${responses[i].body}');
              }

              if (responses[0].body.isNotEmpty) {
                try {
                  final responseDataTA = jsonDecode(responses[0].body);
                  // print('Parsed TA Data: $responseDataTA');

                  cloudStorageInfo.taValue10 =
                      double.tryParse(responseDataTA['value'].toString()) ??
                          0.0;
                  // print('Tank 9 TA after parsing: ${cloudStorageInfo.taValue}');
                } catch (e) {
                  print('Error parsing JSON for FAL: $e');
                }
              } else {
                print('Error: tank10-talvalue returned an empty response');
              }
              if (responses[1].body.isNotEmpty) {
                try {
                  final responseFA = jsonDecode(responses[1].body);
                  cloudStorageInfo.faValue10 =
                      double.tryParse(responseFA['value'].toString()) ?? 0.0;
                  print('Tank 10 FA: ${cloudStorageInfo.faValue}');
                } catch (e) {
                  print('Error parsing JSON for FAL: $e');
                }
              } else {
                print('Error: tank10-falvalue returned an empty response');
              }
              if (responses[2].body.isNotEmpty) {
                try {
                  final responseAR = jsonDecode(responses[2].body);
                  cloudStorageInfo.arValue10 =
                      double.tryParse(responseAR['value'].toString()) ?? 0.0;
                  print('Tank 10 AR: ${cloudStorageInfo.arValue}');
                } catch (e) {
                  print('Error parsing JSON for FAL: $e');
                }
              } else {
                print('Error: tank9-falvalue returned an empty response');
              }
              if (responses[3].body.isNotEmpty) {
                try {
                  final responseAC = jsonDecode(responses[3].body);
                  cloudStorageInfo.acValue10 =
                      double.tryParse(responseAC['value'].toString()) ?? 0.0;
                  print('Tank 10 AC: ${cloudStorageInfo.acValue10}');
                } catch (e) {
                  print('Error parsing JSON for FAL: $e');
                }
              } else {
                print('Error: tank9-AcValue returned an empty response');
              }
              if (responses[4].body.isNotEmpty) {
                try {
                  final responseTemp = jsonDecode(responses[4].body);
                  cloudStorageInfo.tank10tempValue =
                      double.tryParse(responseTemp['value'].toString()) ?? 0.0;
                  print('Tank 10 Temp: ${cloudStorageInfo.tank10tempValue}');
                } catch (e) {
                  print('Error parsing JSON for Temp;: $e');
                }
              } else {
                print('Error: One of the responses is empty or invalid JSON');
              }
            } catch (e) {
              print('Error in second API calls: $e');
            }
          }
          if (id == 13) {
            try {
              final responses = await Future.wait([
                http.post(Uri.parse('http://172.23.10.51:1111/tank13-conui')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank13-FAui')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank13-rtemp')),
              ]);

              // for (int i = 0; i < responses.length; i++) {
              // print('Tank 13 Response $i Status: ${responses[i].statusCode}');
              // print('Tank 13 Response $i Body: ${responses[i].body}');
              // }

              if (responses[0].body.isNotEmpty) {
                try {
                  final responseDataCON = jsonDecode(responses[0].body);
                  cloudStorageInfo.conValue13 =
                      double.tryParse(responseDataCON['value'].toString()) ??
                          0.0;
                } catch (e) {
                  print('Error parsing response JSON: $e');
                }
              } else {
                print('Error: One of the responses is empty or invalid JSON');
              }
              if (responses[1].body.isNotEmpty) {
                try {
                  final responseDataFA = jsonDecode(responses[1].body);
                  cloudStorageInfo.faValue13 =
                      double.tryParse(responseDataFA['value'].toString()) ??
                          0.0;
                } catch (e) {
                  print('Error parsing response JSON: $e');
                }
              } else {
                print('Error: One of the responses is empty or invalid JSON');
              }
              if (responses[2].body.isNotEmpty) {
                try {
                  final responseDataTemp = jsonDecode(responses[2].body);
                  cloudStorageInfo.tank13TempValue =
                      double.tryParse(responseDataTemp['value'].toString()) ??
                          0.0;
                } catch (e) {
                  print('Error parsing response JSON: $e');
                }
              } else {
                print('Error: One of the responses is empty or invalid JSON');
              }
            } catch (e) {
              print('Error in second API calls for Tank 13: $e');
            }
          }
          if (id == 14) {
            try {
              final responses = await Future.wait([
                http.post(Uri.parse('http://172.23.10.51:1111/tank14-conui')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank14-FAui')),
                http.post(Uri.parse('http://172.23.10.51:1111/tank14-rtemp')),
              ]);

              // for (int i = 0; i < responses.length; i++) {
              //   print('Tank 14 Response $i Status: ${responses[i].statusCode}');
              //   print('Tank 14 Response $i Body: ${responses[i].body}');
              // }

              if (responses[0].body.isNotEmpty) {
                try {
                  final responseDataCON = jsonDecode(responses[0].body);
                  cloudStorageInfo.conValue14 =
                      double.tryParse(responseDataCON['value'].toString()) ??
                          0.0;
                } catch (e) {
                  print('Error parsing response JSON: $e');
                }
              } else {
                print('Error: One of the responses is empty or invalid JSON');
              }
              if (responses[1].body.isNotEmpty) {
                try {
                  final responseDataFA = jsonDecode(responses[1].body);
                  cloudStorageInfo.faValue14 =
                      double.tryParse(responseDataFA['value'].toString()) ??
                          0.0;
                } catch (e) {
                  print('Error parsing response JSON: $e');
                }
              } else {
                print('Error: One of the responses is empty or invalid JSON');
              }
              if (responses[2].body.isNotEmpty) {
                try {
                  final responseDataTemp = jsonDecode(responses[2].body);
                  cloudStorageInfo.tank14TempValue =
                      double.tryParse(responseDataTemp['value'].toString()) ??
                          0.0;
                } catch (e) {
                  print('Error parsing response JSON: $e');
                }
              } else {
                print('Error: One of the responses is empty or invalid JSON');
              }
            } catch (e) {
              print('Error in second API calls for Tank 14: $e');
            }
          }
        }
      }
    } else {
      print('Error: API returned ${response.statusCode} or empty body');
    }
  } catch (e) {
    print('Error in fetchStatusAndUpdateColors: $e');
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
