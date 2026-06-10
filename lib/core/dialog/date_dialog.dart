import 'package:flutter/material.dart';
import '../config/app_color.dart';
import '../constants/constants.dart';
Future<DateTime?> selectDate({DateTime? dateTime,DateTime? lastDate,DateTime? firstDate}) async {
  final DateTime? picked = await showDatePicker(
    context: Constants.globalContext(),
    initialDate: dateTime??DateTime.now(),
    firstDate: firstDate??DateTime.now(),
    lastDate: lastDate??DateTime.now().add(Duration(days: 365)),
    builder: (BuildContext context, child) {
      return Theme(
        data: Theme.of(context).copyWith(  // override MaterialApp ThemeData
          colorScheme: ColorScheme.light(
            primary: AppColor.primaryColor,  //header and selced day background color
            onPrimary: Colors.white, // titles and
            onSurface: Colors.black, // Month days , years
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColor.primaryColor, // ok , cancel    buttons
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  return picked;
}

Future<TimeOfDay?> selectTime({TimeOfDay? time}) async {
  TimeOfDay _selectedTime = time??TimeOfDay.now();
  final TimeOfDay? picked = await showTimePicker(
    context: Constants.globalContext(),
    initialTime: _selectedTime,
    builder: (BuildContext context, child) {
      return Theme(
        data: Theme.of(context).copyWith(  // override MaterialApp ThemeData
          colorScheme: ColorScheme.light(
            primary: AppColor.primaryColor,  //header and selced day background color
            onPrimary: Colors.white, // titles and
            onSurface: Colors.black, // Month days , years
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColor.primaryColor, // ok , cancel    buttons
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  return picked;
}

