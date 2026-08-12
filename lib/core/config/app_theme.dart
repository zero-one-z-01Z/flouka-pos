import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'app_color.dart';

String get _displayFont => GoogleFonts.bricolageGrotesque().fontFamily ?? 'Cairo';
String get _bodyFont => GoogleFonts.lato().fontFamily ?? 'Cairo';

ThemeData defaultTheme = ThemeData(
  useMaterial3: false,
  primaryColor: AppColor.primaryColor,
  colorScheme: ColorScheme.light(
    primary: AppColor.primaryColor,
    secondary: AppColor.gold,
    surface: AppColor.surface,
    onPrimary: Colors.white,
    onSecondary: AppColor.ink,
    onSurface: AppColor.ink,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
  ),
  unselectedWidgetColor: Colors.white,
  scaffoldBackgroundColor: AppColor.canvas,
  checkboxTheme: checkboxThemeData,
  dividerColor: Colors.transparent,
  radioTheme: radioThemeData,
  appBarTheme: appBarTheme,
  fontFamily: _bodyFont,
  textTheme: GoogleFonts.latoTextTheme().apply(
    bodyColor: AppColor.ink,
    displayColor: AppColor.ink,
  ),
  splashColor: Colors.transparent,
);

AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: Colors.transparent,
  toolbarHeight: 56,
  centerTitle: true,
  foregroundColor: AppColor.primaryColor,
  elevation: 0,
  iconTheme: const IconThemeData(color: AppColor.ink),
  systemOverlayStyle: barColor(),
  titleTextStyle: GoogleFonts.bricolageGrotesque(
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
    color: AppColor.ink,
  ),
);

EdgeInsets globalPadding = EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h);

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
  side: const BorderSide(width: 1.5, color: AppColor.hairline),
  fillColor: WidgetStateProperty.all(AppColor.gold),
  checkColor: WidgetStateProperty.all(AppColor.ink),
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
  unselectedLabelColor: AppColor.textMuted,
);

bool get _isAndroidNative =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

SystemUiOverlayStyle barColor() {
  if (_isAndroidNative) {
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
  if (_isAndroidNative) {
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

/// Display headline style (Bricolage).
TextStyle vendeurDisplay({
  double fontSize = 18,
  FontWeight fontWeight = FontWeight.w700,
  Color color = AppColor.ink,
}) =>
    GoogleFonts.bricolageGrotesque(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: -0.02 * fontSize,
    );

TextStyle vendeurBody({
  double fontSize = 13,
  FontWeight fontWeight = FontWeight.w400,
  Color color = AppColor.ink,
}) =>
    GoogleFonts.lato(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
