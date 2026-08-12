import 'package:flutter/foundation.dart' show kDebugMode, kReleaseMode;
import 'package:flutter/material.dart';

class Constants {
  /// Release → HTTPS public API. Debug → staging (seed vendor).
  static const String _stagingBase = 'http://72.60.191.26:3102/';
  static const String _prodBase = 'https://api.flouka.app/';

  /// Override with `--dart-define=FLOUKA_API_BASE=http://72.60.191.26:3102/`
  /// for store-review simulation against staging (release/profile builds).
  static String get baseUri {
    const override = String.fromEnvironment('FLOUKA_API_BASE');
    if (override.isNotEmpty) return override;
    return kReleaseMode ? _prodBase : _stagingBase;
  }

  static String get domain => '${baseUri}api/';

  /// Debug-only seed auto-login. Always off in release/profile.
  static bool get autoLoginForTesting => kDebugMode && !kReleaseMode;

  static const String testVendorPhone = '21610000001';
  static const String testVendorPassword = 'FloukaSeed1!';

  //! for navigation
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static bool isTablet = false;

  /// Persistent sidebar below this width becomes a drawer (phone / narrow web).
  static const double shellBreakpoint = 800;

  static bool isCompactShell(BuildContext context) =>
      MediaQuery.sizeOf(context).width < shellBreakpoint;

  static const String webSocketLink =
      'wss://flouka.app/app/d6jhrf3qa5ssnhnfoymoflouka?protocol=7&client=js&version=8.4.0&flash=false';

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
