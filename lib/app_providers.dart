import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/category/presentation/providers/category_provider.dart';
import 'features/home/presentation/providers/home_provider.dart';
import 'features/home/presentation/providers/overview_provider.dart';
import 'features/language/presentation/provider/language_provider.dart';
import 'features/orders/presentation/providers/orders_provider.dart';
import 'features/splash/provider/splash_provider.dart';
import 'injection_container.dart';

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
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => OverviewProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider(sl.get())),
      ],
      child: child,
    );
  }
}
