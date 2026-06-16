// ignore_for_file: unused_import

import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flouka_pos/features/products/presentation/views/add_product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../core/constants/constants.dart';
import '../../../core/helper_function/api.dart';
import '../../../core/helper_function/helper_function.dart';
import '../../home/presentation/views/home_view.dart';
import '../../products/presentation/views/add_variant_view.dart';

class SplashProvider extends ChangeNotifier {
  // void startApp() async {
  //   await Future.wait([delay(500)]);
  //   AuthProvider authProvider = Provider.of(
  //     Constants.globalContext(),
  //     listen: false,
  //   );
  //   bool isFirstTime = !(sharedPreferences.getBool('onBoarding') ?? false);
  //   String? isLoggedIn = sharedPreferences.getString('token');
  //   // if (!isFirstTime) {
  //   // if (isFirstTime) {
  //   authProvider.goToLoginView();
  //   // navP(const AddAttributesView());
  //   // }else{
  //   // Provider.of<NavBarProvider>(Constants.globalContext(), listen: false,).currentIndex = 0;
  //   // }
  // }

  void startApp(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Use the context passed directly from the widget tree — avoids a null-check
    // crash on navState.currentContext which may not be mounted yet at splash time.
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final token = sharedPreferences.getString('token');

    /// No token → Login
    if (token == null || token.isEmpty) {
    authProvider.goToUserTypePage();
    return;
    }

    //
    try {
      await authProvider.getProfile();
    } catch (_) {
      await sharedPreferences.remove('token');
      authProvider.goToLoginView();
    }
  }
}
