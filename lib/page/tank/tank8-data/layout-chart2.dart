import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:newmaster/responsive.dart';

import 'line_chart_sample8-3.dart';
import 'line_chart_sample8-4.dart';

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

class Chart134 extends StatefulWidget {
  Chart134({
    Key? key,
  }) : super(key: key);

  @override
  _Chart134State createState() => _Chart134State();
}

class _Chart134State extends State<Chart134> {
  Future<List<Map<String, dynamic>>> fetchDataFromAPI() async {
    final response =
        await http.post(Uri.parse('http://172.23.10.51:1111/tank9-AR'));
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "A.R.(Point) Chart",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14, // Set your desired font size here
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Responsive(
                mobile: LineChartSample32(
                  crossAxisCount: _size.width < 650 ? 2 : 4,
                  childAspectRatio:
                      _size.width < 650 && _size.width > 350 ? 1.3 : 1,
                  historyChartData: output,
                ),
                tablet: LineChartSample32(
                  crossAxisCount: _size.width < 650 ? 2 : 4,
                  childAspectRatio:
                      _size.width < 650 && _size.width > 350 ? 1.3 : 1,
                  historyChartData: output,
                ),
                desktop: LineChartSample32(
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

class Chart135 extends StatefulWidget {
  Chart135({
    Key? key,
  }) : super(key: key);

  @override
  _Chart135State createState() => _Chart135State();
}

class _Chart135State extends State<Chart135> {
  Future<List<Map<String, dynamic>>> fetchDataFromAPI() async {
    final response =
        await http.post(Uri.parse('http://172.23.10.51:1111/tank9-AC'));
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("A.C. (Point) Chart",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 14,
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

class Chart221 extends StatelessWidget {
  Chart221({
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
            Text("Feed Chart",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14,
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
      Uri.parse('http://172.23.10.51:1111/chem-feed2'),
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
          displayName: 'FC-4360(kg/day)',
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
        charts.SeriesLegend(),
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
            color: charts.ColorUtil.fromDartColor(Colors.white),
          ),
        ),
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(Colors.white),
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


class Chart136 extends StatefulWidget {
  Chart136({
    Key? key,
  }) : super(key: key);

  @override
  _Chart136State createState() => _Chart136State();
}

class _Chart136State extends State<Chart136> {
  Future<List<Map<String, dynamic>>> fetchDataFromAPI() async {
    final response =
        await http.post(Uri.parse('http://172.23.10.51:1111/tank9-temp'));
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Temp.(°C) Chart",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14, // Set your desired font size here
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Responsive(
                mobile: LineChartSample33(
                  crossAxisCount: _size.width < 650 ? 2 : 4,
                  childAspectRatio:
                      _size.width < 650 && _size.width > 350 ? 1.3 : 1,
                  historyChartData: output,
                ),
                tablet: LineChartSample33(
                  crossAxisCount: _size.width < 650 ? 2 : 4,
                  childAspectRatio:
                      _size.width < 650 && _size.width > 350 ? 1.3 : 1,
                  historyChartData: output,
                ),
                desktop: LineChartSample33(
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
