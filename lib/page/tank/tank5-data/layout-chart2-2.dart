import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:newmaster/responsive.dart';
import 'package:newmaster/page/tank/tank5-data/line_chart_sample5-2.dart';
import 'package:newmaster/page/tank/tank5-data/line_chart_sample5.dart';


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
class Chart25 extends StatelessWidget {
  Chart25({
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
      Uri.parse('http://172.23.10.51:1111/chem-feed92'),
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
          displayName: 'AC-131(kg/day)',
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



