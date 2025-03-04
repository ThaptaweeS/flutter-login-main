// import 'dart:convert';

// import 'package:dartx/dartx.dart';
// import 'package:equatable/equatable.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;

// List<FlSpot> Chart_data5 = [];

// abstract class Tank5Event extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class FetchTank5Data extends Tank5Event {} // ✅ ตรวจสอบว่ามี event นี้

// // 🔥 States
// abstract class Tank5State extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class Tank5Loading extends Tank5State {}

// class Tank5Loaded extends Tank5State {
//   final List<Map<String, dynamic>> data;

//   Tank5Loaded(this.data);

//   @override
//   List<Object> get props => [data];

//   @override
//   String toString() => 'Tank5Loaded(data: $data)'; // ✅ Debug ข้อมูลได้ง่ายขึ้น
// }

// class Tank5Error extends Tank5State {
//   final String message;
//   Tank5Error(this.message);

//   @override
//   List<Object> get props => [message];

//   @override
//   String toString() => 'Tank5Error(message: $message)'; // ✅ Debug ง่ายขึ้น
// }

// class Tank5Initial extends Tank5State {}

// class Tank5Bloc extends Bloc<Tank5Event, Tank5State> {
//   Tank5Bloc() : super(Tank5Initial()) {
//     on<FetchTank5Data>(_onFetchTank5Data);
//   }

//   Future<void> _onFetchTank5Data(
//       FetchTank5Data event, Emitter<Tank5State> emit) async {
//     emit(Tank5Loading());
//     try {
//       final response = await http.get(
//         Uri.parse("http://172.23.10.51:1111/tank5-feui"),
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
//           Chart_data5.add(FlSpot(i.toDouble(), Buff));
//           // Chart_data.add(FlSpot(dateInDays, Buff));
//           print(Chart_data5);
//         }
//         emit(Tank5Loaded(parsedData));
//       } else {
//         emit(Tank5Error("Failed to load data: ${response.statusCode}"));
//       }
//     } catch (e) {
//       emit(Tank5Error("Error: $e"));
//     }
//   }
// }
