import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
// import 'package:tamkeen/core/constants/assets.gen.dart';
import '../../../../core/helper_function/helper_function.dart';
import 'package:flutter/material.dart';
import '../../../core/config/app_theme.dart';
import '../../../core/widgets/logo_widget.dart';
import '../provider/splash_provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await delay(100);
      Provider.of<SplashProvider>(context, listen: false).startApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: barColor(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LogoWidget(isWhite: true, fit: BoxFit.fitWidth, width: 40.w)],
          ),
        ),
      ),
    );
  }
}
