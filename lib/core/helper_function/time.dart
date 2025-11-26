import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'convert.dart';
import 'helper_function.dart';

Future<String?> selectTime(String? time) async {
  TimeOfDay selectedTime;
  if (time != null) {
    selectedTime = TimeOfDay(
      hour: convertStringToInt(time.split(':').first),
      minute: convertStringToInt(time.split(':').last),
    );
  } else {
    selectedTime = TimeOfDay.now();
  }

  TimeOfDay? pickedTime = await showTimePicker(
    context: Constants.globalContext(),
    initialTime: selectedTime,
  );

  if (pickedTime != null && pickedTime != selectedTime) {
    // print(pickedTime);
    // setState(() {
    //   _selectedTime = pickedTime;
    // });
  }
  if (pickedTime == null) {
    return null;
  }
  return _formatTime(pickedTime);
}

String _formatTime(TimeOfDay time) {
  // Format the time as a string
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

Future<String?> pickTime() async {
  String? from = await selectTime(null);
  return from;
}

Future<String?> pickTimeRange(String? time) async {
  if (time == null) {
    String? from = await selectTime(null);
    if (from == null) {
      return null;
    } else {
      await delay(500);
      String? to = await selectTime(null);
      if (to == null) {
        return null;
      } else {
        return '$from $to';
      }
    }
  } else {
    String? from = await selectTime(time.split(' ').first);
    if (from == null) {
      return null;
    } else {
      await delay(500);
      String? to = await selectTime(time.split(' ').last);
      if (to == null) {
        return null;
      } else {
        return '$from $to';
      }
    }
  }
}
