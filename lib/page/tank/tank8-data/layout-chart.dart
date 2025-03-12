import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newmaster/page/tank/tank8-data/line_chart_sample8-2.dart';
import 'package:newmaster/page/tank/tank8-data/line_chart_sample8.dart';
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

class Chart133 extends StatefulWidget {
  Chart133({
    Key? key,
  }) : super(key: key);

  @override
  _Chart133State createState() => _Chart133State();
}

class _Chart133State extends State<Chart133> {
  Future<List<Map<String, dynamic>>> fetchDataFromAPI() async {
    final response =
        await http.post(Uri.parse('http://127.0.0.1:1882/tank8-ph'));
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
                  "${input[i]["date"] ?? ""} 0${input[i]["range"] ?? ""}:00",
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "pH Chart",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
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
        await http.post(Uri.parse('http://127.0.0.1:1882/tank8-tal'));
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
          List<HistoryChartModel2> output = [];
          for (var i = 0; i < input.length; i++) {
            output.add(HistoryChartModel2(
              id: input[i]["id"] ?? "",
              custFull: input[i]["CustFull"] ?? "",
              sampleName: input[i]["SampleName"] ?? "",
              samplingDate:
                  "${input[i]["date"] ?? ""} 0${input[i]["range"] ?? ""}:00",
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("T.Al.(Point) Chart",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 20,
                            color: Colors.black,
                          )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Responsive(
                mobile: LineChartSample23(
                  crossAxisCount: _size.width < 650 ? 2 : 4,
                  childAspectRatio:
                      _size.width < 650 && _size.width > 350 ? 1.3 : 1,
                  historyChartData: output,
                ),
                tablet: LineChartSample23(
                  crossAxisCount: _size.width < 650 ? 2 : 4,
                  childAspectRatio:
                      _size.width < 650 && _size.width > 350 ? 1.3 : 1,
                  historyChartData: output,
                ),
                desktop: LineChartSample23(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Feed Chart",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 20,
                      color: Colors.black,
                    )),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height *
              0.6, // Specify the height here
          child: BarChartBody(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
        ),
      ],
    );
  }
}

class BarChartBody extends StatefulWidget {
  const BarChartBody(
      {Key? key, required int crossAxisCount, required num childAspectRatio})
      : super(key: key);

  @override
  _BarChartBodyState createState() => _BarChartBodyState();
}

class _BarChartBodyState extends State<BarChartBody> {
  List<ChartData> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:1882/chem-feed8'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{}),
    );

    if (response.statusCode == 200) {
      setState(() {
        Iterable list = json.decode(response.body);
        data = list.map((model) => ChartData.fromJson(model)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: data.isEmpty ? CircularProgressIndicator() : SimpleBarChart(data),
    );
  }
}

int calculateRotationAngle(int numberOfBars) {
  if (numberOfBars > 10) return -90; // หมุน 90 องศาสำหรับข้อมูลจำนวนมาก
  if (numberOfBars > 5) return -45; // หมุน 45 องศา
  return 0; // ข้อมูลน้อยไม่ต้องหมุน
}

class SimpleBarChart extends StatelessWidget {
  final List<ChartData> data;

  SimpleBarChart(this.data);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      [
        charts.Series<ChartData, String>(
          id: 'Value',
          domainFn: (ChartData sales, _) => sales.date,
          measureFn: (ChartData sales, _) => sales.value,
          data: data,
          displayName: 'PL-ZN(kg/day)',
          colorFn: (ChartData sales, _) {
            if (sales.value <= 20) {
              return charts.ColorUtil.fromDartColor(
                  Color.fromARGB(255, 43, 119, 182));
            } else {
              return charts.ColorUtil.fromDartColor(
                  Color.fromARGB(255, 43, 119, 182));
            }
          },
        )
      ],
      animate: true,
      behaviors: [
        charts.SeriesLegend(
          entryTextStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(Colors.black),
          ),
        ),
        charts.LinePointHighlighter(
          showHorizontalFollowLine:
              charts.LinePointHighlighterFollowLineType.none,
          showVerticalFollowLine:
              charts.LinePointHighlighterFollowLineType.nearest,
        ),
        charts.RangeAnnotation([
          for (var i = 0; i < 100; i += 4)
            charts.LineAnnotationSegment(
              20,
              charts.RangeAnnotationAxisType.measure,
              color: charts.ColorUtil.fromDartColor(Colors.green),
              strokeWidthPx: 4.0,
              dashPattern: [2, 2],
            )
        ]),
      ],
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(Colors.black),
          ),
        ),
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: calculateRotationAngle(data.length),
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(Colors.black),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String date;
  final double value;
  final String lot;

  ChartData({required this.date, required this.value, required this.lot});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      date: json['date'],
      value: json['value'], // Parse value as double directly
      lot: json['lot'],
    );
  }
}
