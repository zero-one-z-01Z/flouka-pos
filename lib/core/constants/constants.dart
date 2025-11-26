import 'package:flutter/material.dart';

class Constants {
  static const String baseUri = "https://raval.zeroonez.com/";
  static const String domain = '${baseUri}api/';
  //! for navigation
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static bool isTablet = false;

  static const String webSocketLink =
      'wss://raval.zeroonez.com/app/d6jhrfdqa5ssnhnfoymoraval?protocol=7&client=js&version=8.4.0&flash=false ';

  static BuildContext globalContext() {
    return navState.currentContext!;
  }

  static InputDecoration inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade200,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    );
  }
}
