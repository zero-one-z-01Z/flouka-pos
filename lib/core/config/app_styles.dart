import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

abstract class TextStyleClass {
  static TextStyle headStyle({Color? color}) {
    return TextStyle(color: color ?? Colors.black, fontSize: 20.sp);
  }

  static TextStyle semiHeadStyle({Color? color}) {
    return TextStyle(color: color ?? Colors.black, fontSize: 18.sp);
  }

  static TextStyle normalStyle({Color? color}) {
    return TextStyle(color: color ?? Colors.black, fontSize: 16.sp);
  }

  static TextStyle smallStyle({Color? color}) {
    return TextStyle(color: color ?? Colors.black, fontSize: 14.sp);
  }

  static TextStyle buttonStyle({Color? color}) {
    return TextStyle(color: color ?? Colors.black, fontSize: 16.sp);
  }

  static TextStyle textFieldStyle({Color? color}) {
    return TextStyle(color: color ?? Colors.black, fontSize: 14.sp);
  }

  static TextStyle captionStyle({Color? color}) {
    return TextStyle(color: color ?? Colors.black, fontSize: 13.sp);
  }
}
