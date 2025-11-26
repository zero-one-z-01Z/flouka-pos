import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'app_color.dart';

ThemeData defaultTheme = ThemeData(
  useMaterial3: false,
  primaryColor: AppColor.primaryColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
  ),
  unselectedWidgetColor: Colors.white,
  scaffoldBackgroundColor: AppColor.backgroundColor,
  checkboxTheme: checkboxThemeData,
  dividerColor: Colors.transparent,
  radioTheme: radioThemeData,
  appBarTheme: appBarTheme,
  fontFamily: "Lato",
  splashColor: Colors.transparent,
);

AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: const Color(0xffeffbff),
  toolbarHeight: 56,
  centerTitle: true,
  foregroundColor: AppColor.primaryColor,
  elevation: 0,
  iconTheme: const IconThemeData(color: Colors.black),
  systemOverlayStyle: barColor(),
  titleTextStyle: TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,
    fontSize: 16.sp,
    color: Colors.black,
  ),
);

EdgeInsets globalPadding = EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h);

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
  side: const BorderSide(width: 1.5, color: Colors.white),
  fillColor: WidgetStateProperty.all(Colors.white),
  checkColor: WidgetStateProperty.all(AppColor.primaryColor),
  overlayColor: WidgetStateProperty.all(
    AppColor.primaryColor.withValues(alpha: 0.1),
  ),
  visualDensity: VisualDensity.compact,
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
);

RadioThemeData radioThemeData = RadioThemeData(
  fillColor: WidgetStateProperty.all(AppColor.primaryColor),
);

TabBarTheme tabBarTheme = TabBarTheme(
  labelColor: AppColor.primaryColor,
  indicatorSize: TabBarIndicatorSize.label,
  unselectedLabelColor: Colors.grey,
);

SystemUiOverlayStyle barColor() {
  if (Platform.isAndroid) {
    return const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    );
  }
  return SystemUiOverlayStyle.dark;
}

SystemUiOverlayStyle lightBarColor() {
  if (Platform.isAndroid) {
    return const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    );
  }
  return SystemUiOverlayStyle.light;
}
