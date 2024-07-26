import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/page0.dart';
import '../../page/page01.dart';
import '../../widget/menu/side_menu.dart';
import '../cubit/NotificationEvent.dart';
//-------------------------------------------------

abstract class ChangePage_Event {}

class ChangePage extends ChangePage_Event {}

class ChangePage_nodrower extends ChangePage_Event {}

class ChangePage_Bloc extends Bloc<ChangePage_Event, Widget> {
  ChangePage_Bloc() : super(_getInitialPage()) {
    on<ChangePage>((event, emit) {
      return _ChangePage_Function(state, emit);
    });
    on<ChangePage_nodrower>((event, emit) {
      return _ChangePage_Function_no_drower(state, emit);
    });
  }

  static Widget _getInitialPage() {
    if (USERDATA.UserLV >= 2) {
      return Page01body();
    } else {
      return Page01body();
    }
  }

  Future<void> _ChangePage_Function(Widget toAdd, Emitter<Widget> emit) async {
    Widget output = Page0();

    if (USERDATA.UserLV >= CuPageLV) {
    } else {
      BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
          "Error", "No have permission", enumNotificationlist.Error);
    }

    Navigator.pop(MenuContext);
    emit(CuPage);
  }

  Future<void> _ChangePage_Function_no_drower(
      Widget toAdd, Emitter<Widget> emit) async {
    Widget output = Page0();

    if (USERDATA.UserLV >= CuPageLV) {
    } else {
      CuPage = Page0();
      BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
          "Error", "No have permission", enumNotificationlist.Error);
    }

    emit(CuPage);
  }
}
