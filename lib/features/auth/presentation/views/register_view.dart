import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flouka_pos/features/auth/presentation/views/register_page1.dart';
import 'package:flouka_pos/features/auth/presentation/views/register_page2.dart';
import 'package:flouka_pos/features/auth/presentation/views/register_page3.dart';
import 'package:flouka_pos/features/auth/presentation/views/register_signup_pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_images.dart';
import '../../../language/presentation/widget/language_widget.dart';
import '../providers/register_provider.dart';

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
    final signup = !AuthProvider.isLogin();

    Widget page;
    if (signup) {
      switch (provider.currentStep) {
        case 1:
          page = const SignupPage1();
          break;
        case 2:
          page = const SignupPage2();
          break;
        default:
          page = const SignupOtpPage();
      }
    } else {
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
    }

    if (signup) {
      return Scaffold(
        backgroundColor: AppColor.canvas,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.canvas,
          title: Image.asset(
            Images.floukaLogo,
            height: 32,
            fit: BoxFit.contain,
            alignment: Alignment.centerLeft,
          ),
          actions: const [LanguageWidget()],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: page,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.canvas,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.surface,
        title: Text(
          'Flouka Vendeur',
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColor.ink,
          ),
        ),
        actions: const [
          LanguageWidget(),
        ],
      ),
      body: page,
    );
  }
}
