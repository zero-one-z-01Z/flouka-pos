// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
Future startSharedPref() async {
  SharedPreferences.resetStatic();
  sharedPreferences = await SharedPreferences.getInstance();
}
