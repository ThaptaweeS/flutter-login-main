import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/constants.dart';
import 'package:newmaster/presentation/samples/line/line_chart_sample2.dart';
import 'package:newmaster/presentation/samples/line/line_chart_sample3.dart';
import 'package:newmaster/responsive.dart';

List<HistoryChartModel> output = [];
String test = "";

class Chart11 extends StatelessWidget {
  Chart11({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "F.AI. Chart (Point)",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        // SizedBox(height: defaultPadding),
        Responsive(
          mobile: LineChartSample2(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: LineChartSample2(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          desktop: LineChartSample2(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            crossAxisCount: _size.width < 800 ? 2 : 4,
          ),
        ),
      ],
    );
  }
}

class Chart12 extends StatelessWidget {
  Chart12({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Temp.(°C)",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: LineChartSample2(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: LineChartSample2(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          desktop: LineChartSample2(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            crossAxisCount: _size.width < 800 ? 2 : 4,
          ),
        ),
      ],
    );
  }
}

class Chart13 extends StatefulWidget {
  Chart13({
    Key? key,
  }) : super(key: key);

  @override
  _Chart13State createState() => _Chart13State();
}

class _Chart13State extends State<Chart13> {
  Future<List<Map<String, dynamic>>> fetchDataFromAPI() async {
    final response =
        await http.post(Uri.parse('http://172.23.10.51:1111/tank2aftercheck'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<Map<String, dynamic>> data =
          responseData.cast<Map<String, dynamic>>();

      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchDataFromAPI(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Map<String, dynamic>> input = snapshot.data!;
          List<HistoryChartModel> output = [];
          for (var i = 0; i < input.length; i++) {
            output.add(HistoryChartModel(
              id: input[i]["id"] ?? "",
              custFull: input[i]["CustFull"] ?? "",
              sampleName: input[i]["SampleName"] ?? "",
              samplingDate:
                  "${input[i]["date"] ?? ""}t${input[i]["time"] ?? ""}",
              stdMax: input[i]["StdMax"] ?? "0",
              stdMin: input[i]["StdMin"] ?? "0",
              resultApprove: input[i]["value"] ?? "",
              resultApproveUnit: input[i]["ResultApproveUnit"] ?? "",
              position: input[i]["Position"] ?? "",
            ));
          }
          final Size _size = MediaQuery.of(context).size;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Temp.(°C) Chart",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Responsive(
                mobile: LineChartSample22(
                  crossAxisCount: _size.width < 650 ? 2 : 4,
                  childAspectRatio:
                      _size.width < 650 && _size.width > 350 ? 1.3 : 1,
                  historyChartData: output,
                ),
                tablet: LineChartSample22(
                  crossAxisCount: _size.width < 650 ? 2 : 4,
                  childAspectRatio:
                      _size.width < 650 && _size.width > 350 ? 1.3 : 1,
                  historyChartData: output,
                ),
                desktop: LineChartSample22(
                  childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
                  crossAxisCount: _size.width < 800 ? 2 : 4,
                  historyChartData: output,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class Chart21 extends StatelessWidget {
  Chart21({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "FA Feed Chart",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        // SizedBox(height: defaultPadding),
        Responsive(
          mobile: LineChartSample3(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: LineChartSample3(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          desktop: LineChartSample3(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            crossAxisCount: _size.width < 800 ? 2 : 4,
          ),
        ),
      ],
    );
  }
}

class Chart22 extends StatelessWidget {
  Chart22({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "AC Feed Chart",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        // SizedBox(height: defaultPadding),
        Responsive(
          mobile: LineChartSample3(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: LineChartSample3(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          desktop: LineChartSample3(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            crossAxisCount: _size.width < 800 ? 2 : 4,
          ),
        ),
      ],
    );
  }
}
