// ignore_for_file: unused_import

import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../core/constants/constants.dart';
import '../../../core/helper_function/helper_function.dart';

class SplashProvider extends ChangeNotifier {
  void startApp() async {
    await Future.wait([delay(500)]);
    AuthProvider authProvider = Provider.of(
      Constants.globalContext(),
      listen: false,
    );
    bool isFirstTime = !(sharedPreferences.getBool('onBoarding') ?? false);
    String? isLoggedIn = sharedPreferences.getString('token');
    // if (!isFirstTime) {
    // if (isFirstTime) {
    authProvider.goToLoginView();

    // }else{
    // Provider.of<NavBarProvider>(Constants.globalContext(), listen: false,).currentIndex = 0;
    // }
  }
}
