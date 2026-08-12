import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/widgets/svg_widget.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../language/presentation/widget/language_widget.dart';
import '../providers/auth_provider.dart';

class UserTypePage extends StatelessWidget {
  const UserTypePage({super.key});

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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: compact ? 6.w : 28.w),
        child: Column(
          children: [
            SizedBox(height: compact ? 12.h : 18.h),
            Text(
              LanguageProvider.translate('auth', 'vendor'),
              textAlign: TextAlign.center,
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColor.ink,
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: _TypeCard(
                    selected: authProvider.isStore,
                    label: LanguageProvider.translate('auth', 'store'),
                    svg: Images.store,
                    onTap: () => authProvider.changeUserType(isStore: true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TypeCard(
                    selected: !authProvider.isStore,
                    label: LanguageProvider.translate('auth', 'vendor'),
                    svg: Images.user,
                    onTap: () => authProvider.changeUserType(isStore: false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            ButtonWidget(
              borderRadius: 14,
              color: AppColor.gold,
              textStyle: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                color: AppColor.ink,
              ),
              onTap: () {
                authProvider.goToLoginView();
              },
              text: 'confirm',
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    required this.selected,
    required this.label,
    required this.svg,
    required this.onTap,
  });

  final bool selected;
  final String label;
  final String svg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColor.sidebar : AppColor.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColor.sidebar : AppColor.hairline,
            ),
          ),
          child: Column(
            children: [
              SvgWidget(
                svg: svg,
                width: 36,
                color: selected ? AppColor.gold : AppColor.ink,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  color: selected ? AppColor.gold : AppColor.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
