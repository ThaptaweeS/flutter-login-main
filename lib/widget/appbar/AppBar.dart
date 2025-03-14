import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:newmaster/bloc/BlocEvent/ChangePageEvent.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/page/page2-data/manual-process-user.dart';

import '../../bloc/BlocEvent/LoginEvent.dart';
import '../../mainBody.dart';

String pageactive = '';

class App_Bar extends StatefulWidget {
  App_Bar({Key? key}) : super(key: key);

  @override
  _App_BarState createState() => _App_BarState();
}

class _App_BarState extends State<App_Bar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      // color: Color.fromRGBO(255, 255, 255, 0.353),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Logo2(),
          Logo1(),
          Pump9ac(),
          Pump10ac(),
          Pump10pb(),
          Spacer(),
          Spacer(),
          Pack_topright_bar(),
        ],
      ),
    );
  }
}

class Logo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: InkWell(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Container(
          height: 40,
          width: 50,
          color: Color.fromRGBO(255, 255, 255, 0),
        ),
      ),
    );
  }
}

class Pump9ac extends StatefulWidget {
  @override
  _Pump9acState createState() => _Pump9acState();
}

class _Pump9acState extends State<Pump9ac> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isRunning = false; // สถานะจาก PLC (true หมุน, false หยุด)

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // เรียกใช้ฟังก์ชันดึงข้อมูลจาก API
    fetchPlcStatus();
  }

  Future<void> fetchPlcStatus() async {
    const url = 'http://127.0.0.1:1882/status9ac'; // URL ของ API ของคุณ
    try {
      // ส่งคำขอ GET ไปยัง API
      final response = await http.get(Uri.parse(url));

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // แปลงข้อมูล JSON ที่ได้จาก API
        final data = json.decode(response.body);

        // อัปเดตสถานะ `isRunning` จากค่าที่ได้รับ
        setState(() {
          // ตรวจสอบว่าข้อมูลใน API เป็น `true` หรือ `false`
          isRunning = data['status'] == true;

          // ควบคุมการหมุนของไอคอนตามสถานะ
          if (isRunning) {
            _controller.repeat(); // เริ่มหมุนถ้าสถานะเป็น true
          } else {
            _controller.stop(); // หยุดหมุนถ้าสถานะเป็น false
          }
        });
      } else {
        // print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // print('Error fetching data: $e');
    }

    // เรียกใช้ซ้ำทุก 1 วินาที
    await Future.delayed(Duration(seconds: 2), fetchPlcStatus);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: isRunning
                    ? _controller.value * 2 * math.pi
                    : 0, // หมุนถ้าสถานะเป็น true
                child: child,
              );
            },
            child: Icon(
              Icons.support_rounded,
              color: isRunning
                  ? const Color.fromARGB(255, 0, 255, 8)
                  : const Color.fromARGB(
                      255, 247, 247, 247), // สีเขียวถ้า true, สีแดงถ้า false
              size: 24.0,
            ),
          ),
          SizedBox(width: 8.0),
          Text(
            'AC-131\n(PUMP M-55)',
            style: GoogleFonts.ramabhadra(fontSize: 8.0, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class Pump10ac extends StatefulWidget {
  @override
  _Pump10acState createState() => _Pump10acState();
}

class _Pump10acState extends State<Pump10ac>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isRunning = false; // สถานะจาก PLC (true หมุน, false หยุด)

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // เรียกใช้ฟังก์ชันดึงข้อมูลจาก API
    fetchPlcStatus();
  }

  Future<void> fetchPlcStatus() async {
    const url = 'http://127.0.0.1:1882/status10ac'; // URL ของ API ของคุณ
    try {
      // ส่งคำขอ GET ไปยัง API
      final response = await http.get(Uri.parse(url));

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // แปลงข้อมูล JSON ที่ได้จาก API
        final data = json.decode(response.body);

        // อัปเดตสถานะ `isRunning` จากค่าที่ได้รับ
        setState(() {
          // ตรวจสอบว่าข้อมูลใน API เป็น `true` หรือ `false`
          isRunning = data['status'] == true;

          // ควบคุมการหมุนของไอคอนตามสถานะ
          if (isRunning) {
            _controller.repeat(); // เริ่มหมุนถ้าสถานะเป็น true
          } else {
            _controller.stop(); // หยุดหมุนถ้าสถานะเป็น false
          }
        });
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // print('Error fetching data: $e');
    }

    // เรียกใช้ซ้ำทุก 1 วินาที
    await Future.delayed(Duration(seconds: 2), fetchPlcStatus);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: isRunning
                    ? _controller.value * 2 * math.pi
                    : 0, // หมุนถ้าสถานะเป็น true
                child: child,
              );
            },
            child: Icon(
              Icons.support_rounded,
              color: isRunning
                  ? const Color.fromARGB(255, 0, 255, 8)
                  : const Color.fromARGB(
                      255, 247, 247, 247), // สีเขียวถ้า true, สีแดงถ้า false
              size: 24.0,
            ),
          ),
          SizedBox(width: 8.0), // Add spacing between the icon and text
          Text(
            'AC-131\n(PUMP M-56)',
            style: GoogleFonts.ramabhadra(fontSize: 8.0, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class Pump10pb extends StatefulWidget {
  @override
  _Pump10pbState createState() => _Pump10pbState();
}

class _Pump10pbState extends State<Pump10pb>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isRunning = false; // สถานะจาก PLC (true หมุน, false หยุด)

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // เรียกใช้ฟังก์ชันดึงข้อมูลจาก API
    fetchPlcStatus();
  }

  Future<void> fetchPlcStatus() async {
    const url = 'http://127.0.0.1:1882/status10pb'; // URL ของ API ของคุณ
    try {
      // ส่งคำขอ GET ไปยัง API
      final response = await http.get(Uri.parse(url));

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // แปลงข้อมูล JSON ที่ได้จาก API
        final data = json.decode(response.body);

        // อัปเดตสถานะ `isRunning` จากค่าที่ได้รับ
        setState(() {
          // ตรวจสอบว่าข้อมูลใน API เป็น `true` หรือ `false`
          isRunning = data['status'] == true;

          // ควบคุมการหมุนของไอคอนตามสถานะ
          if (isRunning) {
            _controller.repeat(); // เริ่มหมุนถ้าสถานะเป็น true
          } else {
            _controller.stop(); // หยุดหมุนถ้าสถานะเป็น false
          }
        });
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // print('Error fetching data: $e');
    }

    // เรียกใช้ซ้ำทุก 1 วินาที
    await Future.delayed(Duration(seconds: 2), fetchPlcStatus);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: isRunning
                    ? _controller.value * 2 * math.pi
                    : 0, // หมุนถ้าสถานะเป็น true
                child: child,
              );
            },
            child: Icon(
              Icons.support_rounded,
              color: isRunning
                  ? const Color.fromARGB(255, 0, 255, 8)
                  : const Color.fromARGB(
                      255, 247, 247, 247), // สีเขียวถ้า true, สีแดงถ้า false
              size: 24.0,
            ),
          ),
          SizedBox(width: 8.0), // Add spacing between the icon and text
          Text(
            'PB-181XR\n(PUMP M-23)',
            style: GoogleFonts.ramabhadra(fontSize: 8.0, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

//============================================================
class Logo1 extends StatelessWidget {
  const Logo1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1),
      child: Container(
        // color: Color.fromRGBO(0, 0, 0, 0),
        child: Text(
          "Chemical Control Monitoring",
          style: GoogleFonts.ramabhadra(
            color: Colors.white,
            fontSize: 20,
            // fontWeight: FontWeight.w400,
            // fontStyle: FontStyle.normal,
            // letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}

class Pack_topright_bar extends StatelessWidget {
  const Pack_topright_bar();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        width: 360, // เพิ่มขนาดเพื่อรองรับไอคอนใหม่
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconNew(), // ไอคอนใหม่
            IconBell(), // Icon Bell
            Time_(), // เวลา
            IconProfile(), // Icon Profile
          ],
        ),
      ),
    );
  }
}

class IconNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ตรวจสอบว่าเป็นวันจันทร์หรือไม่
    bool isMonday = DateTime.now().weekday == DateTime.monday;

    return IconButton(
      onPressed: isMonday
          ? () {
              // ฟังก์ชันเมื่อกดไอคอน
              print("New Icon Clicked");
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Surface Condition',
                        style: GoogleFonts.ramabhadra(color: Colors.black)),
                    content: Text(
                        'คุณต้องการสั่ง Make up ประจำวันจันทร์หรือไม่',
                        style: GoogleFonts.ramabhadra(color: Colors.black)),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              // Call the API and await response
                              await _callFeedAPI('Makeup8', '0', '0', '07.00');

                              // Add delay to ensure API is completely processed before refreshing data
                              await Future.delayed(
                                  const Duration(milliseconds: 500));

                              // Fetch new data and refresh the table
                              await fetchDataFromAPI();

                              // Close the dialog only after refreshing the data
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                Icon(Icons.double_arrow_outlined),
                                SizedBox(width: 5),
                                Text('Make up'),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            }
          : null, // ถ้าไม่ใช่วันจันทร์ ปุ่มจะไม่สามารถกดได้
      icon: Icon(Icons.info_outline, color: Colors.white),
      tooltip: "Surface Condition Make up",
    );
  }

  Future<void> _callFeedAPI(
      String endpoint, String no, String no2, String value) async {
    // URL of your Node-RED endpoint
    final url = 'http://127.0.0.1:1882/$endpoint';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'TAI': no, // Unique ID or number
          'pH': no2,
          'Range': value, // Signal or parameter to trigger
        },
      );

      if (response.statusCode == 200) {
        // If API call is successful
        print('API call successful: No: $no, Value: $value');
      } else {
        // If API call fails
        print('Failed to call API: StatusCode ${response.statusCode}');
      }
    } catch (error) {
      print('Error calling API: $error');
    }
  }

  Future<void> fetchDataFromAPI() async {
    final url = 'http://127.0.0.1:1882/manual-feed';

    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Data fetched successfully');
        // Process data if needed
      } else {
        print('Failed to fetch data');
      }
    } catch (error) {
      // print('Error fetching data: $error');
    }
  }
}

class IconBell extends StatefulWidget {
  const IconBell({Key? key}) : super(key: key);

  @override
  _IconBellState createState() => _IconBellState();
}

class _IconBellState extends State<IconBell> {
  bool hasData = false; // Assuming initially no data

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget is initialized
    Timer.periodic(Duration(minutes: 3), (timer) {
      fetchData(); // Fetch data every 3 minutes
    });
  }

  Future<void> fetchData() async {
    try {
      // Make a GET request to the API
      final response =
          // await http.post(Uri.parse('http://127.0.0.1:1882/notify'));
          await http.post(Uri.parse('http://127.0.0.1:1882/manual-feed-user'));
      if (response.statusCode == 200) {
        // Parse the response body
        final jsonData = jsonDecode(response.body);
        // Check if data is received
        setState(() {
          hasData = jsonData.isNotEmpty;
        });
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 4),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('แจ้งเตือน',
                        style: GoogleFonts.ramabhadra(color: Colors.black)),
                    content: Text('ได้รับข้อมูลเคมีที่ต้องเติมเพิ่มจาก QC',
                        style: GoogleFonts.ramabhadra(color: Colors.black)),
                    backgroundColor: Colors.white,
                    actions: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // Align buttons to the right
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              CuPage = ManualfeedUser();
                              MainBodyContext.read<ChangePage_Bloc>()
                                  .add(ChangePage_nodrower());
                              Navigator.of(context).pop();
                              print('Go');
                            },
                            child: Row(
                              children: [
                                Icon(Icons.double_arrow_outlined,
                                    color: Colors.black),
                                SizedBox(
                                    width:
                                        5), // Add some spacing between the icon and the text
                                Text('Go to',
                                    style: GoogleFonts.ramabhadra(
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                          const SizedBox(
                              width: 8), // Add some spacing between the buttons
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.grey),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close',
                                style: GoogleFonts.ramabhadra(
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            icon: hasData
                ? Tooltip(
                    message: 'แจ้งเตือน\nคุณมีคำสั่งเติมสารเคมีใหม่จาก QC',
                    child: Image.asset("assets/icons/icon-notifications2.png"),
                  )
                : Tooltip(
                    message: 'ไม่มีข้อมูลใหม่',
                    child: Image.asset("assets/icons/icon-notifications.png"),
                  ),
          ),
          SizedBox(width: 3),
          Text(
            USERDATA.NAME,
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class IconProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        LoginContext.read<Login_Bloc>().add(Logout());
      },
      child: Icon(Icons.logout),
    );
  }
}

class Time_ extends StatefulWidget {
  Time_({Key? key}) : super(key: key);

  @override
  _Time_State createState() => _Time_State();
}

class _Time_State extends State<Time_> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        DateTime now = DateTime.now();
        return Center(
          child: Text(
            DateFormat('MMM dd, yyyy hh:mm a').format(now),
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
          ),
        );
      },
    );
  }
}
