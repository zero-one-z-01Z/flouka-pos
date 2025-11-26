import 'package:flutter/material.dart';

class TextFieldModel {
  String? image, label, hint, titleText;
  final String key;
  TextInputType? textInputType;
  TextEditingController controller;
  bool next, obscureText, readOnly;
  bool? isLabel;
  String? Function(String?)? validator;
  Widget? suffix, prefix, title;
  void Function()? onTap;
  double? width;
  int? min, max;
  String? editTextString;
  EdgeInsets? contentPadding;
  List<Widget>? titleWidgets;

  TextFieldModel({
    this.image,
    required this.key,
    this.label,
    this.isLabel,
    this.hint = "",
    this.textInputType,
    this.readOnly = false,
    required this.controller,
    this.next = true,
    this.validator,
    this.editTextString,
    this.onTap,
    this.suffix,
    this.prefix,
    this.title,
    this.titleText,
    this.min,
    this.max,
    this.width,
    this.contentPadding,
    this.obscureText = false,
    this.titleWidgets,
  });
}
