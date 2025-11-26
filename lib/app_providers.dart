import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/language/presentation/provider/language_provider.dart';
import 'features/splash/provider/splash_provider.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({super.key, required this.child, required this.language});
  final Widget child;
  final LanguageProvider language;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => language),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
      ],
      child: child,
    );
  }
}
