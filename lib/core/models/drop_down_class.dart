import 'package:flutter/material.dart';

abstract class DropDownClass<T> {
  String displayedName();
  String? titleName();
  bool require();
  Widget? displayedWidget();
  String displayedOptionName(T type);
  Widget? displayedOptionWidget(T type);
  Future onTap(T? data);
  List<T> list();
  T? selected();
  dynamic value();
}
