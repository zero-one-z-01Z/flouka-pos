import 'dart:io';

import 'package:flutter/foundation.dart' show kReleaseMode;

/// In release builds, use system certificate validation.
/// Debug/profile may bypass for local/staging HTTPS experiments.
void applyHttpOverrides() {
  if (kReleaseMode) return;
  HttpOverrides.global = _DevHttpOverrides();
}

class _DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) =>
          true;
  }
}
