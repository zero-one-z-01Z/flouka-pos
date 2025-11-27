import 'package:flutter/material.dart';

class InfoCardEntity {
  final String title;
  final String subtitle;
  final String svgImage;
  final Color backgroundColor;
  final Color svgBackgroundColor;

  InfoCardEntity({
    required this.title,
    required this.subtitle,
    required this.svgImage,
    required this.backgroundColor,
    required this.svgBackgroundColor,
  });
}
