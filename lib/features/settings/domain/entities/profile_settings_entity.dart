import 'package:flutter/painting.dart';

class ProfileSettingsEntity {
  final String text;
  final VoidCallback onTap;
  final Color? color;

  ProfileSettingsEntity({
    required this.text,
    required this.onTap,
    this.color,
  });
}
