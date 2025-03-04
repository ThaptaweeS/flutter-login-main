// import 'dart:convert';

// import 'package:dartx/dartx.dart';
// import 'package:equatable/equatable.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;

// List<FlSpot> Chart_data8 = [];

// abstract class Tank8Event extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class FetchTank8Data extends Tank8Event {} // ✅ ตรวจสอบว่ามี event นี้

// // 🔥 States
// abstract class Tank8State extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class Tank8Loading extends Tank8State {}

// class Tank8Loaded extends Tank8State {
//   final List<Map<String, dynamic>> data;

//   Tank8Loaded(this.data);

//   @override
//   List<Object> get props => [data];

//   @override
//   String toString() => 'Tank8Loaded(data: $data)'; // ✅ Debug ข้อมูลได้ง่ายขึ้น
// }

// class Tank8Error extends Tank8State {
//   final String message;
//   Tank8Error(this.message);

//   @override
//   List<Object> get props => [message];

//   @override
//   String toString() => 'Tank8Error(message: $message)'; // ✅ Debug ง่ายขึ้น
// }

// class Tank8Initial extends Tank8State {}

// class Tank8Bloc extends Bloc<Tank8Event, Tank8State> {
//   Tank8Bloc() : super(Tank8Initial()) {
//     on<FetchTank8Data>(_onFetchTank8Data);
//   }

//   Future<void> _onFetchTank8Data(
//       FetchTank8Data event, Emitter<Tank8State> emit) async {
//     emit(Tank8Loading());
//     try {
//       final response = await http.get(
//         Uri.parse("http://172.23.10.51:1111/tank8-talui"),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> rawData = jsonDecode(response.body);
//         final List<Map<String, dynamic>> parsedData =
//             rawData.map((e) => Map<String, dynamic>.from(e)).toList();
//         print("API Response: $parsedData");
//         for (var i = 0; i < parsedData.length; i++) {
//           double Buff = parsedData[i]['value'].toString().toDouble();
//           // var dateString = parsedData[i]['date'];
//           // var parts = dateString.split('-');
//           // int day = int.parse(parts[0]);
//           // int month = int.parse(parts[1]);
//           // DateTime date = DateTime(2025, month, day);
//           // double dateInDays =
//           //     date.difference(DateTime(date.year, 1, 1)).inDays.toDouble();
//           Chart_data8.add(FlSpot(i.toDouble(), Buff));
//           // Chart_data.add(FlSpot(dateInDays, Buff));
//           print(Chart_data8);
//         }
//         emit(Tank8Loaded(parsedData));
//       } else {
//         emit(Tank8Error("Failed to load data: ${response.statusCode}"));
//       }
//     } catch (e) {
//       emit(Tank8Error("Error: $e"));
//     }
//   }
// }
