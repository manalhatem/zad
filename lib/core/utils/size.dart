import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zad/main.dart';

double width() {
  return MediaQuery.of(navigatorKey.currentContext!).size.width;
}

double height() {
  return MediaQuery.of(navigatorKey.currentContext!).size.height;
}

class AppFonts {
  static double t8 = 8.sp;
  static double t10 = 10.sp;
  static double t12 = 12.sp;
  static double t14 = 13.sp;
  static double t16 = 15.sp;
  static double t18 = 17.sp;
  static double t40 = 40.sp;
  static double t20 = 20.sp;

}

class AppRadius {
  static double r4 = 4.r;
  static double r8 = 8.r;
  static double r11 = 11.r;
  static double r10 = 10.r;
  static double r16 = 16.r;
  static double r17 = 17.r;
  static double r20 = 20.r;
  static double r25 = 25.r;
  static double r34 = 34.r;
  static double r40 = 40.r;
  static double r55 = 55.r;

}
