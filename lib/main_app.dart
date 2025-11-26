import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'core/config/app_theme.dart';
import 'core/constants/constants.dart';
import 'features/language/domain/entities/app_localizations.dart';
import 'features/language/presentation/provider/language_provider.dart';
import 'features/splash/views/splash_view.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, lang, _) {
        return Sizer(
          builder: (context, orientation, deviceType) {
            Constants.isTablet = (deviceType == ScreenType.tablet);
            return AnnotatedRegion(
              value: barColor(),
              child: MaterialApp(
                title: 'flouka POS',
                debugShowCheckedModeBanner: false,
                navigatorObservers: [routeObserver],
                navigatorKey: Constants.navState,
                locale: lang.appLocal,
                supportedLocales: LanguageProvider.languages,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: defaultTheme,
                home: const SplashView(),
                builder: (context, child) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: MediaQuery(
                      data: MediaQuery.of(
                        context,
                      ).copyWith(textScaler: const TextScaler.linear(1.0)),
                      child: Container(
                        color: Colors.white,
                        width: 100.w,
                        height: 100.h,
                        child: child!,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
