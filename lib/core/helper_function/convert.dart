import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';
import 'package:time_machine/time_machine.dart' as time;

//Jan 1, 2024 12:00 AM
String convertDateTimeToString(DateTime dateTime) {
  return DateFormat(
    'MMM d, y hh:mm a',
    Provider.of<LanguageProvider>(
      Constants.globalContext(),
      listen: false,
    ).appLocal.languageCode,
  ).format(dateTime);
}

//1 Jan, 2024 12:00 AM
String convertDateTimeToStringDMY(DateTime dateTime) {
  return DateFormat(
    'd MMM y \n hh:mm a',
    Provider.of<LanguageProvider>(
      Constants.globalContext(),
      listen: false,
    ).appLocal.languageCode,
  ).format(dateTime);
}

String convertDateToTime(DateTime dateTime) {
  return DateFormat(
    'hh:mm a',
    Provider.of<LanguageProvider>(
      Constants.globalContext(),
      listen: false,
    ).appLocal.languageCode,
  ).format(dateTime);
}

//2:00
String convertDateToStringHM(DateTime dateTime) {
  return DateFormat('h:mma', 'en').format(dateTime);
}

//2:00:00
String convertDateToStringHMS(DateTime dateTime) {
  return DateFormat('HH:mm:ss', 'en').format(dateTime);
}

//2024-04-15
String convertDateToStringYMD(DateTime dateTime) {
  return DateFormat('yyyy-M-d', 'en').format(dateTime);
}

String checkDateIfNull(dynamic dateTime) {
  return dateTime == "null" || dateTime == null
      ? ""
      : DateFormat(
          'MMM d, y hh:mm a',
          Provider.of<LanguageProvider>(
            Constants.globalContext(),
            listen: false,
          ).appLocal.languageCode,
        ).format(dateTime);
}

//31-3-2024
String convertDateToStringDMY(DateTime dateTime) {
  // Extract the date components
  final day = dateTime.day.toString().padLeft(2, '0');
  final month = dateTime.month.toString().padLeft(2, '0');
  final year = dateTime.year.toString();

  // Concatenate the components with the desired format
  return '$day-$month-$year';
}

// sunday
String getDayNameFromDate(DateTime dateTime) {
  return DateFormat(
    'EEEE',
    Provider.of<LanguageProvider>(
      Constants.globalContext(),
      listen: false,
    ).appLocal.languageCode,
  ).format(dateTime);
}

//Apr 15, 2024
String convertDateToString(DateTime dateTime) {
  return DateFormat(
    'MMM d, y',
    Provider.of<LanguageProvider>(
      Constants.globalContext(),
      listen: false,
    ).appLocal.languageCode,
  ).format(dateTime);
}

// 15 Apr 2024
String convertDateToStringDMMMY(DateTime dateTime) {
  return DateFormat(
    'd MMM y',
    Provider.of<LanguageProvider>(
      Constants.globalContext(),
      listen: false,
    ).appLocal.languageCode,
  ).format(dateTime);
}

DateTime? convertStringToDateTime(String? dateString) {
  if (dateString == null || dateString.isEmpty) return null;

  try {
    return DateFormat(
      'MMM d, y hh:mm a',
      Provider.of<LanguageProvider>(
        Constants.globalContext(),
        listen: false,
      ).appLocal.languageCode,
    ).parse(dateString);
  } catch (_) {
    try {
      return DateFormat('yyyy-M-d').parse(dateString);
    } catch (_) {
      try {
        return DateFormat('dd-MM-yyyy').parse(dateString);
      } catch (_) {
        return null;
      }
    }
  }
}

int convertStringToInt(dynamic value) {
  if (value == null) {
    return 0;
  } else if (value is int) {
    return value;
  } else if (int.tryParse(value) != null) {
    return int.parse(value);
  }
  return 0;
}

num? convertDataToNum(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is num) {
    return value;
  } else if (num.tryParse(value) != null) {
    return num.parse(value);
  }
  return 0;
}

double convertDataToDouble(dynamic value) {
  if (value == null) {
    return 0;
  } else if (value is int) {
    return value.toDouble();
  } else if (value is String) {
    return double.parse(value);
  } else {
    return value;
  }
}

String convertMapToString(Map data) {
  String msg = '';
  data.forEach((key, value) {
    if (value is List) {
      msg += value.join('\n');
      msg += "\n";
    } else if (value is String) {
      msg += "$value\n";
    }
  });
  if (msg.endsWith('\n')) {
    msg = msg.substring(0, msg.length - 1);
  }
  return msg;
}

bool convertDataToBool(dynamic data) {
  if (data == null) {
    return false;
  } else if (data is num) {
    return data == 1;
  } else if (data is String) {
    if (int.tryParse(data) == null) {
      return data == 'yes';
    }
    return convertStringToInt(data) == 1;
  } else {
    return data;
  }
}

String formatTimeOfDay(TimeOfDay tod) {
  final hour = tod.hour.toString().padLeft(2, '0');
  final minute = tod.minute.toString().padLeft(2, '0');
  return "$hour:$minute";
}

Map convertStringToMap(String data) {
  String jsonString = data
      .replaceAll('{', '{"')
      .replaceAll('}', '"}')
      .replaceAll('=', '":"')
      .replaceAll(', ', '","');
  return jsonDecode(jsonString);
}

String convertSecToMin(int sec) {
  int minutes = sec ~/ 60;
  int seconds = sec % 60;

  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}

String getTimeNumber(int year, int month, int day, int h, int m, int s) {
  if (year != 0) {
    return '$year';
  } else if (month != 0) {
    return '$month';
  } else if (day != 0) {
    return '$day';
  } else if (h != 0) {
    return '$h';
  } else if (m != 0) {
    return '$m';
  } else if (s != 0) {
    return '$s';
  }
  return '';
}

String getTimeChar(int year, int month, int day, int h, int m, int s) {
  if (year != 0) {
    return LanguageProvider.translate('time', 'year');
  } else if (month != 0) {
    return LanguageProvider.translate('time', 'month');
  } else if (day != 0) {
    return LanguageProvider.translate('time', 'day');
  } else if (h != 0) {
    return LanguageProvider.translate('time', 'hour');
  } else if (m != 0) {
    return LanguageProvider.translate('time', 'minute');
  } else if (s != 0) {
    return LanguageProvider.translate('time', 'sec');
  }
  return '';
}

String getMediaType(String url) {
  if (url.endsWith('.mp4') || url.endsWith('.avi') || url.endsWith('.mov')) {
    return 'video';
  } else if (url.endsWith('.jpg') || url.endsWith('.png') || url.endsWith('.gif')) {
    return 'image';
  } else if (url.endsWith('.mp3') || url.endsWith('.wav')) {
    return 'audio';
  } else {
    // Default to unknown type or handle other types as needed
    return url;
  }
}

String getDiffTime(DateTime dateTime) {
  DateTime now = DateTime.now();
  time.LocalDate a = time.LocalDate.dateTime(dateTime);
  time.LocalDate b = time.LocalDate.dateTime(now);

  time.Period diff = b.periodSince(a);
  int years = diff.years;
  // years = now.year-noti.year;
  int month = 0;
  if (years == 0) {
    // month = now.month-noti.month;
    month = diff.months;
  }
  int days = 0;
  if (years == 0 && month == 0) {
    days = diff.days;
  }
  int hours = 0;
  if (days == 0 && years == 0 && month == 0) {
    hours = now.hour - dateTime.hour;
  }
  int min = 0;
  if (hours == 0 && days == 0 && years == 0 && month == 0) {
    min = now.minute - dateTime.minute;
  }
  int sec = 0;
  if (min == 0 && hours == 0 && days == 0 && years == 0 && month == 0) {
    sec = now.second + 10 - dateTime.second;
  }
  return '${LanguageProvider.translate('global', 'ago')} ${getTimeNumber(years, month, days, hours, min, sec)} ${getTimeChar(years, month, days, hours, min, sec)}';
}

double convertRgbToHue(int color) {
  int red = (color >> 16) & 0xff;
  int green = (color >> 8) & 0xff;
  int blue = color & 0xff;

  double r = red / 255.0;
  double g = green / 255.0;
  double b = blue / 255.0;

  double max = r > g ? (r > b ? r : b) : (g > b ? g : b);
  double min = r < g ? (r < b ? r : b) : (g < b ? g : b);

  double hue;
  // double saturation;
  // double lightness = (max + min) / 2.0;

  if (max == min) {
    hue = 0.0; // achromatic
  } else {
    double d = max - min;
    // saturation = lightness > 0.5 ? d / (2.0 - max - min) : d / (max + min);
    if (max == r) {
      hue = (g - b) / d + (g < b ? 6.0 : 0.0);
    } else if (max == g) {
      hue = (b - r) / d + 2.0;
    } else {
      hue = (r - g) / d + 4.0;
    }
    hue /= 6.0;
  }

  // Scale hue to the range [0, 360]
  return hue * 360.0;
}

String formatNumber(num number) {
  if (number >= 1000000) {
    double result = number / 1000000;
    return '${result.toStringAsFixed(1)}M';
  } else if (number >= 1000) {
    double result = number / 1000;
    return '${result.toStringAsFixed(1)}K';
  } else {
    return number.toString();
  }
}

String formatTimeToAm(DateTime dateTime) {
  final timeFormatter = DateFormat(
    'h:mm a',
    Provider.of<LanguageProvider>(
      Constants.globalContext(),
      listen: false,
    ).appLocal.languageCode,
  );
  return timeFormatter.format(dateTime);
}

Color hexToColor(String code) {
  code = code.replaceAll('#', '');

  if (code.contains('0xff')) {
    code = code.split('0xff').last.replaceAll(')', '');
  }

  if (code.length == 6) {
    code = 'FF$code';
  }

  try {
    return Color(int.parse(code, radix: 16));
  } catch (e) {
    return Colors.grey;
  }
}

int convertToSeconds(String time) {
  List<String> parts = time.split(':');
  int minutes = int.parse(parts[0]);
  int seconds = int.parse(parts[1]);
  return (minutes * 60) + seconds;
}

bool convertStringToBool({required String data}) {
  if (data == "true") {
    return true;
  }
  return false;
}

String formatPrice(num price) {
  if (price > 1000000) {
    String priceFormatted = (price / 1000000).toStringAsFixed(1);
    if (priceFormatted.endsWith(".0")) {
      priceFormatted = priceFormatted.substring(0, priceFormatted.length - 2);
    }
    return "$priceFormatted${LanguageProvider.translate('global', 'million')}";
  } else {
    final formatter = NumberFormat("#,##0.00");
    String priceFormatted = formatter.format(price);
    if (priceFormatted.endsWith(".00")) {
      priceFormatted = priceFormatted.substring(0, priceFormatted.length - 3);
    }
    return priceFormatted;
  }
}
