import 'dart:ui';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void changeStatusBarColor(Color color, bool whiteForegroundEnabled) async {
  await FlutterStatusbarcolor.setStatusBarColor(color);
  FlutterStatusbarcolor.setStatusBarWhiteForeground(whiteForegroundEnabled);
}
