import 'package:flouka_pos/features/auth/presentation/views/register_page1.dart';
import 'package:flouka_pos/features/auth/presentation/views/register_page2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../injection_container.dart';
import '../../../language/presentation/widget/language_widget.dart';
import '../providers/register_provider.dart';
import 'register_page3.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _RegisterBody();
  }
}

class _RegisterBody extends StatelessWidget {
  const _RegisterBody();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterProvider>();

    Widget page;
    switch (provider.currentStep) {
      case 1:
        page = const RegisterPage1();
        break;
      case 2:
        page = const RegisterPage2();
        break;
      case 3:
        page = const RegisterPage3();
        break;
      default:
        page = const RegisterPage1();
    }

    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xff00A8E1).withOpacity(0.05),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(0.6),
            title: Text(
              'POS SYSTEM V 0.1',
              style: TextStyleClass.smallStyle().copyWith(fontSize: 12.sp),
            ),
            actions: [
              const LanguageWidget(),
            ],
          ),
          body: page,
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset(Images.topCircles, width: 25.w),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(Images.bottomCircles, width: 25.w),
        ),
      ],
    );
  }
}
