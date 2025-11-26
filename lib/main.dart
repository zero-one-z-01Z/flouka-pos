// ignore_for_file: unused_import

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'app_providers.dart';
import 'core/config/app_color.dart';
import 'core/helper_function/api.dart';
import 'core/helper_function/notifications.dart';
import 'core/helper_function/prefs.dart';
import 'core/models/local_notifications.dart';
import 'features/language/presentation/provider/language_provider.dart';
import 'firebase_options.dart';
import 'main_app.dart';
import 'injection_container.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  if (event.notification != null) {
    appNotifications(
      event.notification!,
      click: true,
      fromWhereClicked: 3,
      payload: event.data,
    );
  }
}

Future<void> localMessagingBackgroundHandler(NotificationResponse response) async {
  clickNoti(response.payload!);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  HttpOverrides.global = MyHttpOverrides();


  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await notificationsFirebase();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await NotificationLocalClass.init();

  await startSharedPref();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.bottom],
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryColor,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await ApiHandel.getInstance.init();

  final language = LanguageProvider();
  await language.fetchLocale();

  runApp(MyApp(language: language));
}

class MyApp extends StatelessWidget {
  final LanguageProvider language;

  const MyApp({required this.language, super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(language: language, child: const MainApp());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) =>
          true;
  }
}
