// import 'dart:convert';

// import 'package:dartx/dartx.dart';
// import 'package:equatable/equatable.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;

// List<FlSpot> Chart_data2 = [];

// abstract class Tank2Event extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class FetchTank2Data extends Tank2Event {} // ✅ ตรวจสอบว่ามี event นี้

// // 🔥 States
// abstract class Tank2State extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class Tank2Loading extends Tank2State {}

// class Tank2Loaded extends Tank2State {
//   final List<Map<String, dynamic>> data;

//   Tank2Loaded(this.data);

//   @override
//   List<Object> get props => [data];

//   @override
//   String toString() => 'Tank2Loaded(data: $data)'; // ✅ Debug ข้อมูลได้ง่ายขึ้น
// }

// class Tank2Error extends Tank2State {
//   final String message;
//   Tank2Error(this.message);

//   @override
//   List<Object> get props => [message];

//   @override
//   String toString() => 'Tank2Error(message: $message)'; // ✅ Debug ง่ายขึ้น
// }

// class Tank2Initial extends Tank2State {}

// class Tank2Bloc extends Bloc<Tank2Event, Tank2State> {
//   Tank2Bloc() : super(Tank2Initial()) {
//     on<FetchTank2Data>(_onFetchTank2Data);
//   }

//   Future<void> _onFetchTank2Data(
//       FetchTank2Data event, Emitter<Tank2State> emit) async {
//     emit(Tank2Loading());
//     try {
//       final response = await http.get(
//         Uri.parse("http://127.0.0.1:1882/tank2-falui"),
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
//           Chart_data2.add(FlSpot(i.toDouble(), Buff));
//           // Chart_data.add(FlSpot(dateInDays, Buff));
//           print(Chart_data2);
//         }
//         emit(Tank2Loaded(parsedData));
//       } else {
//         emit(Tank2Error("Failed to load data: ${response.statusCode}"));
//       }
//     } catch (e) {
//       emit(Tank2Error("Error: $e"));
//     }
//   }
// }
