import 'package:flutter/material.dart';

import '../page/page0.dart';

String token = '';
String name = '';
Widget CuPage = const Page0();
int CuPageLV = 0;

bool themedark = false;

class USERDATA {
  static int UserLV = 0;
  static String NAME = '';
  static String ID = '';
}

class logindata {
  static bool isControl = false;
  static String userID = '';
  static String userPASS = '';
}

Map<int, bool> visibilityStates = {
  1: false,
  2: true,
  3: false,
  4: false,
  5: true,
  6: false,
  7: false,
  8: true,
  9: true,
  10: true,
  11: false,
  12: false,
  13: true,
  14: true,
};

class feedData {
  static String ac9feedQuantity = '';
  static String ac10feedQuantity = '';
  static String pb10feedQuantity = '';
}
