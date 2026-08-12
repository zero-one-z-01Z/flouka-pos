import 'package:flutter/material.dart';

/// Flouka Vendeur design tokens (teal / cream / gold).
abstract class AppColor {
  // Brand
  static Color primaryColor = const Color(0xff0E3B2E);
  static Color secondaryColor = const Color(0xff14261F);
  static Color backgroundColor = const Color(0xffFCFAF3);
  static Color tertiaryColor = const Color(0xffB3A98F);

  static const Color sidebar = Color(0xff0E3B2E);
  static const Color sidebarAccent = Color(0xff14523E);
  static const Color gold = Color(0xffF2C14E);
  static const Color brandNavy = Color(0xff0E3B2E);

  static const Color ink = Color(0xff14261F);
  static const Color textPrimary = Color(0xff1D2A25);
  static const Color textSecondary = Color(0xff6B7671);
  static const Color textMuted = Color(0xff6B7671);
  static const Color textSubtle = Color(0xff8A938E);
  static const Color textFaint = Color(0xffC9C2B4);

  static const Color canvas = Color(0xffF4F0E6);
  static const Color surface = Color(0xffFCFAF3);
  static const Color surfaceElevated = Color(0xffFBF7F0);

  static const Color hairline = Color(0xffE3DCCB);
  static const Color hairlineSoft = Color(0xffEDE9E2);
  static const Color rowDivider = Color(0xffEDE9E2);

  /// Selected nav on teal rail (cream pill).
  static const Color navSelected = Color(0xffF2C14E);
  static const Color navTint = Color(0xffE1EFE9);
  static const Color selectedRowTint = Color(0xffFDF0DC);

  static const List<Color> avatarBgs = [
    Color(0xffE1EFE9),
    Color(0xffFDF0DC),
    Color(0xffF0CFC9),
    Color(0xffDCE9E4),
    Color(0xffFBE6E4),
    Color(0xffF1EDE5),
  ];

  static const List<Color> avatarFgs = [
    Color(0xff0A4E43),
    Color(0xff9A6B12),
    Color(0xff8E2A20),
    Color(0xff0F6B5C),
    Color(0xffB03225),
    Color(0xff7A5510),
  ];
}
