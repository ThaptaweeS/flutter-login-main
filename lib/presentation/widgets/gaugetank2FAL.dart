import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Represents the GaugeApp class
class GaugeApp extends StatelessWidget {
  final bool isRadialGauge; // ตัวแปรกำหนดประเภทเกจ
  final double value;
  final String falLabel = 'F.Al. :';
  GaugeApp({Key? key, required this.value, this.isRadialGauge = false})
      : super(key: key); // Constructor กำหนดค่าเริ่มต้น

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Expanded(
        child: Container(
          width: 300,
          height: 80,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black26,
            //     offset: Offset(3, 5),
            //     blurRadius: 5,
            //   ),
            // ],
          ),
          child: _getLinearGauge(),
        ),
      ),
    );
  }

  Widget _getRadialGauge() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          // labelsPosition: ElementsPosition.inside,
          centerY: 0.4,
          minimum: 25,
          maximum: 45,
          startAngle: 180,
          endAngle: 0,
          interval: 10, // กำหนดให้แสดงทุกๆ 10 หน่วย
          radiusFactor: 1, // ลดขนาด Gauge เพื่อให้มีพื้นที่สำหรับตัวเลข
          labelOffset: 10, // ขยับ Label ออกห่างจากเส้น
          canRotateLabels: true, // ให้ Label หมุนอัตโนมัติ
          showLastLabel: true, // แสดง Label ตัวสุดท้าย (100)
          labelFormat: '{value}', // เพิ่ม % หลังตัวเลข
          axisLabelStyle: GaugeTextStyle(fontSize: 12, color: Colors.black),
          canScaleToFit: true,

          ranges: <GaugeRange>[
            GaugeRange(
                startValue: 25,
                endValue: 30,
                color: Colors.red,
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 30,
                endValue: 40,
                color: Colors.green,
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 40,
                endValue: 45,
                color: Colors.red,
                startWidth: 10,
                endWidth: 10),
          ],
          pointers: <GaugePointer>[
            MarkerPointer(
              value: this.value,
              markerType: MarkerType.triangle,
              color: Colors.black,
              markerWidth: 10,
              markerHeight: 15,
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              horizontalAlignment: GaugeAlignment.center,
              verticalAlignment: GaugeAlignment.center,
              angle: 130,
              widget: Container(
                child: Text(
                  '${this.value.toStringAsFixed(1)} Pt. ', // ✅ แสดงค่าปัจจุบัน
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              // angle: 180,
              positionFactor: 0.0,
            )
          ],
        ),
      ],
    );
  }

  Widget _getLinearGauge() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              '${falLabel}',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              ' ${value.toStringAsFixed(1)} Pt.',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        SizedBox(height: 10),
        SfLinearGauge(
          minimum: 25.0,
          maximum: 45.0,
          maximumLabels: 2,
          orientation: LinearGaugeOrientation.horizontal,
          animateAxis: true,
          majorTickStyle: LinearTickStyle(length: 5, thickness: 1),
          axisLabelStyle: TextStyle(fontSize: 10.0, color: Colors.black),
          axisTrackStyle: LinearAxisTrackStyle(
            color: Colors.cyan.shade700,
            edgeStyle: LinearEdgeStyle.bothCurve,
            thickness: 10.0,
            borderColor: Colors.grey.shade300,
          ),
          ranges: [
            const LinearGaugeRange(
                startValue: 25,
                endValue: 30,
                color: Colors.red,
                position: LinearElementPosition.cross,
                edgeStyle: LinearEdgeStyle.startCurve,
                startWidth: 10,
                endWidth: 10),
            const LinearGaugeRange(
                startValue: 30,
                endValue: 40,
                color: Colors.green,
                position: LinearElementPosition.cross,
                edgeStyle: LinearEdgeStyle.bothFlat,
                startWidth: 10,
                endWidth: 10),
            const LinearGaugeRange(
                startValue: 40,
                endValue: 45,
                color: Colors.red,
                position: LinearElementPosition.cross,
                edgeStyle: LinearEdgeStyle.endCurve,
                startWidth: 10,
                endWidth: 10),
          ],
          // barPointers: [
          //   LinearBarPointer(
          //     edgeStyle: LinearEdgeStyle.bothFlat,
          //     enableAnimation: true,
          //     value: value,
          //     thickness: 8,
          //     color: Colors.redAccent,
          //   ),
          // ],
          markerPointers: <LinearMarkerPointer>[
            LinearWidgetPointer(
              value: value, // ปรับค่าตามที่ต้องการให้ลูกศรชี้
              position: LinearElementPosition.inside,
              child: Transform.rotate(
                angle: -3.141,
                child: CustomPaint(
                  painter: TrianglePainter(),
                  size: Size(10, 10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

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

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GaugeApp(
          value: 35.7,
          isRadialGauge: true), // เปลี่ยนเป็น false ถ้าต้องการ Linear Gauge
    ));
