import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LineGaugeTank extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final double sp;
  final String Label;
  final String Unit;
  final bool isRadialGauge;
  final bool isPhScale;
  final bool isFalScale;
  final bool isTempScale;
  final bool isConScale;
  final bool isFeScale;
  final bool isTalScale;
  final bool isTa9Scale;
  final bool isFa9Scale;
  final bool isTa10Scale;
  final bool isFa10Scale;
  final bool isAR910Scale;
  final bool isAC910Scale;
  final bool isTemp910Scale;
  final bool isCon13Scale;
  final bool isCon14Scale;
  final bool isFa1314Scale;
  final bool isTemp13Scale;
  final bool isTemp14Scale;
  final bool showThreshold;

  const LineGaugeTank({
    Key? key,
    required this.value,
    required this.min,
    required this.max,
    required this.sp,
    required this.Label,
    required this.Unit,
    this.isRadialGauge = false,
    this.isPhScale = false,
    this.isFalScale = false,
    this.isTempScale = false,
    this.isConScale = false,
    this.isFeScale = false,
    this.isTalScale = false,
    this.isTa9Scale = false,
    this.isTa10Scale = false,
    this.isFa9Scale = false,
    this.isFa10Scale = false,
    this.isAR910Scale = false,
    this.isAC910Scale = false,
    this.isTemp910Scale = false,
    this.isCon13Scale = false,
    this.isCon14Scale = false,
    this.isFa1314Scale = false,
    this.isTemp13Scale = false,
    this.isTemp14Scale = false,
    this.showThreshold = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 100,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: isRadialGauge ? _getLinearGauge1() : _getLinearGauge(),
      ),
    );
  }

  Widget _getLinearGauge1() {
    double gaugeMin = min; // ✅ ถ้าเป็น pH ให้ใช้ช่วง 0-14
    double gaugeMax = max;
    double gaugesp = sp;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              '${Label}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            Text(
              ' ${value.toStringAsFixed(1)} ${Unit}',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SfLinearGauge(
          minimum: gaugeMin,
          maximum: gaugeMax,
          maximumLabels: 2,
          orientation: LinearGaugeOrientation.horizontal,
          animateAxis: true,
          majorTickStyle: LinearTickStyle(length: 5, thickness: 1),
          axisLabelStyle: TextStyle(fontSize: 10.0, color: Colors.black),
          axisTrackStyle: LinearAxisTrackStyle(
            color: Colors.transparent,
            edgeStyle: LinearEdgeStyle.bothCurve,
            thickness: 10.0,
            borderColor: Colors.grey.shade300,
          ),
          ranges: getGaugeRanges(),
          markerPointers: <LinearMarkerPointer>[
            LinearWidgetPointer(
              value: value,
              position: LinearElementPosition.inside,
              child: Transform.rotate(
                angle: -3.141,
                child: CustomPaint(
                  painter: TrianglePainter(),
                  size: Size(10, 10),
                ),
              ),
            ),
            if (showThreshold)
              LinearWidgetPointer(
                value: sp,
                position: LinearElementPosition.cross,
                child: Container(
                  width: 2,
                  height: 10,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ],
    );
  }

  List<LinearGaugeRange> getGaugeRanges() {
    if (isPhScale) {
      return [
        redRange(4, 8.5),
        greenRange(8.5, 9.5),
        redRange2(9.5, 14),
      ];
    } else if (isFalScale) {
      return [
        redRange(25, 30),
        greenRange(30, 40),
        redRange2(40, 45),
      ];
    } else if (isTempScale) {
      return [
        redRange(40, 55),
        greenRange(55, 75),
        redRange2(75, 95),
      ];
    } else if (isConScale) {
      return [
        redRange(0, 10),
        greenRange(10, 15),
        redRange2(15, 25),
      ];
    } else if (isFeScale) {
      return [
        greenRange(0, 80),
        redRange2(80, 100),
      ];
    } else if (isTalScale) {
      return [
        redRange(0, 2),
        greenRange(2, 8),
        redRange2(8, 10),
      ];
    } else if (isTa9Scale) {
      return [
        redRange(20, 26),
        greenRange(26, 30),
        redRange2(30, 40),
      ];
    } else if (isFa9Scale) {
      return [
        redRange(0, 4),
        greenRange(4, 4.7),
        redRange2(4.7, 6),
      ];
    } else if (isTa10Scale) {
      return [
        redRange(20, 30),
        greenRange(30, 36),
        redRange2(36, 40),
      ];
    } else if (isFa10Scale) {
      return [
        redRange(0, 4.8),
        greenRange(4.8, 6.5),
        redRange2(6.5, 10),
      ];
    } else if (isAR910Scale) {
      return [
        redRange(0, 5.5),
        greenRange(5.5, 7.5),
        redRange2(7.5, 10),
      ];
    } else if (isAC910Scale) {
      return [
        redRange(0, 1),
        greenRange(1, 3),
        redRange2(3, 4),
      ];
    } else if (isTemp910Scale) {
      return [
        redRange(60, 70),
        greenRange(70, 80),
        redRange2(80, 100),
      ];
    } else if (isCon13Scale) {
      return [
        redRange(0, 1),
        greenRange(1, 2.5),
        redRange2(2.5, 3),
      ];
    } else if (isCon14Scale) {
      return [
        redRange(1, 2),
        greenRange(2, 2.5),
        redRange2(2.5, 3),
      ];
    } else if (isFa1314Scale) {
      return [
        redRange(-2, -1),
        greenRange(-1, 1),
        redRange2(1, 2),
      ];
    } else if (isTemp13Scale) {
      return [
        redRange(70, 75),
        greenRange(75, 85),
        redRange2(85, 90),
      ];
    } else if (isTemp14Scale) {
      return [
        redRange(65, 70),
        greenRange(70, 80),
        redRange2(80, 85),
      ];
    }

    return [];
  }

// ฟังก์ชันช่วยสร้างช่วงสีแดง
  LinearGaugeRange redRange(double start, double end) {
    return LinearGaugeRange(
      startValue: start,
      endValue: end,
      color: Colors.redAccent,
      startWidth: 5,
      endWidth: 5,
      position: LinearElementPosition.cross,
      edgeStyle: LinearEdgeStyle.startCurve,
    );
  }

  LinearGaugeRange redRange2(double start, double end) {
    return LinearGaugeRange(
      startValue: start,
      endValue: end,
      color: Colors.redAccent,
      startWidth: 5,
      endWidth: 5,
      position: LinearElementPosition.cross,
      edgeStyle: LinearEdgeStyle.endCurve,
    );
  }

// ฟังก์ชันช่วยสร้างช่วงสีเขียว
  LinearGaugeRange greenRange(double start, double end) {
    return LinearGaugeRange(
      startValue: start,
      endValue: end,
      color: Colors.greenAccent,
      startWidth: 5,
      endWidth: 5,
      position: LinearElementPosition.cross,
    );
  }

  Widget _getLinearGauge() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('${Label}',
                style: const TextStyle(fontSize: 12, color: Colors.black)),
            Text('${value.toStringAsFixed(1)} ${Unit}',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ],
        ),
        const SizedBox(height: 10),
        SfLinearGauge(
          minimum: min,
          maximum: max,
          maximumLabels: 2,
          orientation: LinearGaugeOrientation.horizontal,
          animateAxis: true,
          majorTickStyle: const LinearTickStyle(length: 5, thickness: 1),
          axisLabelStyle: const TextStyle(fontSize: 10.0, color: Colors.black),
          axisTrackStyle: LinearAxisTrackStyle(
            color: Colors.black,
            edgeStyle: LinearEdgeStyle.endCurve,
            thickness: 10.0,
            borderColor: Colors.grey.shade300,
          ),
          barPointers: [
            LinearBarPointer(
              edgeStyle: LinearEdgeStyle.endCurve,
              enableAnimation: true,
              value: value,
              thickness: 10,
              color: Colors.blueAccent,
            ),
          ],
        ),
      ],
    );
  }
}

// void main() => runApp(
//       const MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: LineGaugeTank(
//           value: 35.0,
//           min: 25.0,
//           max: 45.0,
//           sp: 65,
//           Label: "Tank Pressure",
//           Unit: "Pt.",
//           isRadialGauge: true,
//         ),
//       ),
//     );

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.black;
    final Path path = Path()
      ..moveTo(0, 0) // จุดซ้ายบน (เปลี่ยนจากซ้ายล่าง)
      ..lineTo(size.width, 0) // จุดขวาบน (เปลี่ยนจากขวาล่าง)
      ..lineTo(size.width / 2, size.height) // จุดล่างสุด (เป็นยอดลูกศร)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;
}
