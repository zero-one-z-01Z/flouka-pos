import 'package:flutter/material.dart';

abstract class AppColor {
  static Color primaryColor = const Color(0xff00A8E1);
  static Color secondaryColor = const Color(0xff2d2c2c);
  static Color backgroundColor = const Color(0xffFFFFFF);
  static Color tertiaryColor = const Color(0xffAEB1C1);

  // Redesign 1a tokens
  static const Color brandNavy = Color(0xff121F38);
  static const Color ink = Color(0xff0B1220);
  static const Color textPrimary = Color(0xff0B1220);
  static const Color textSecondary = Color(0xff475467);
  static const Color textMuted = Color(0xff667085);
  static const Color textSubtle = Color(0xff8A94A6);
  static const Color textFaint = Color(0xff98A2B3);
  static const Color canvas = Color(0xffF4F6FA);
  static const Color surface = Color(0xffFFFFFF);
  static const Color hairline = Color(0xffE7ECF3);
  static const Color hairlineSoft = Color(0xffEEF1F6);
  static const Color rowDivider = Color(0xffF4F6FA);
  static const Color navSelected = Color(0xff00A8E1);
  static const Color navTint = Color(0xffE6F6FD);
  static const Color selectedRowTint = Color(0xffF2FBFE);

  static const List<Color> avatarBgs = [
    Color(0xffE6F6FD),
    Color(0xffFFF3DF),
    Color(0xffEDEFFB),
    Color(0xffEAF6ED),
    Color(0xffFCEDEC),
    Color(0xffF1EDF8),
  ];

  static const List<Color> avatarFgs = [
    Color(0xff0089B8),
    Color(0xffB5810F),
    Color(0xff3B4CB8),
    Color(0xff2F7D45),
    Color(0xffB03329),
    Color(0xff6B4E9E),
  ];
}
