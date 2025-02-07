import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PumpToTankLayout extends StatefulWidget {
  @override
  _PumpToTankLayoutState createState() => _PumpToTankLayoutState();
}

class _PumpToTankLayoutState extends State<PumpToTankLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _pumpController;
  double feedActual = 0.0; // Current level in the tank
  double feedTarget = 100.0; // Target level for the tank
  bool isPumping = false;

  @override
  void initState() {
    super.initState();
    _pumpController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _pumpController.dispose();
    super.dispose();
  }

  void startPump() {
    setState(() {
      isPumping = true;
      _pumpController.repeat();
    });

    // Simulate the feed increasing
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (!isPumping || feedActual >= feedTarget) {
        timer.cancel();
      } else {
        setState(() {
          feedActual += 2;
        });
      }
    });
  }

  void stopPump() {
    setState(() {
      isPumping = false;
      _pumpController.stop();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pump to Tank Animation"),
      ),
      backgroundColor: Colors.indigo[50],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pump Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Pump Motor
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _pumpController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _pumpController.value * 2 * math.pi,
                          child: Icon(
                            Icons.settings,
                            size: 100,
                            color: isPumping ? Colors.green : Colors.grey,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: isPumping ? null : startPump,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text("Start"),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: isPumping ? stopPump : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text("Stop"),
                        ),
                      ],
                    ),
                  ],
                ),
                // Pipe Section
                Container(
                  width: 50,
                  height: 20,
                  color: Colors.grey,
                ),
                // Tank Section
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: 100,
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 100,
                      height: (feedActual / feedTarget) * 300,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            // Add Descriptive Text
            Text(
              "Pump transferring water to tank",
              style: GoogleFonts.ramabhadra(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
