import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/features/auth/presentation/widgets/have_account_section.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/list_text_field_widget.dart';
import '../../../language/presentation/widget/language_widget.dart';
import '../providers/auth_provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of(context);
    final compact = MediaQuery.sizeOf(context).width < 800;
    return Scaffold(
      backgroundColor: AppColor.canvas,
      appBar: AppBar(
        backgroundColor: AppColor.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
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
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: compact ? 6.w : 30.w),
          child: Form(
            key: authProvider.loginFormKey,
            child: Column(
              children: [
                SizedBox(height: compact ? 10.h : 14.h),
                Image.asset(Images.floukaLogo, width: compact ? 40.w : 15.w),
                const SizedBox(height: 24),
                Text(
                  LanguageProvider.translate('buttons', 'Login'),
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColor.ink,
                  ),
                ),
                const SizedBox(height: 20),
                ListTextFieldWidget(
                  color: AppColor.surface,
                  inputs: authProvider.loginTextFieldList,
                ),
                const SizedBox(height: 16),
                ButtonWidget(
                  borderRadius: 14,
                  color: AppColor.gold,
                  textStyle: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w800,
                    color: AppColor.ink,
                  ),
                  onTap: () async {
                    await authProvider.login();
                  },
                  text: LanguageProvider.translate('buttons', 'Login'),
                ),
                const SizedBox(height: 16),
                if (!authProvider.isStore) const HaveAccountSection(isLogin: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
