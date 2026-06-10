import 'package:flutter/material.dart';

class NavigationEntity {
  final String title;
  final String svgImage;
  final VoidCallback onTap;

  NavigationEntity({required this.title, required this.svgImage, required this.onTap});
}
