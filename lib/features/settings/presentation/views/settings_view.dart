import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/settings_provider.dart';
import '../widgets/settings_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsProvider settingsProvider = Provider.of(context);
    final compact = Constants.isCompactShell(context);

    return Scaffold(
      backgroundColor: AppColor.canvas,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            compact ? 16 : 20,
            16,
            compact ? 16 : 20,
            28,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LanguageProvider.translate('navbar', 'settings'),
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: compact ? 22 : 18,
                  fontWeight: FontWeight.w800,
                  color: AppColor.ink,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColor.hairline),
                ),
                child: Column(
                  children: List.generate(
                    settingsProvider.settingsList.length,
                    (index) {
                      final isLast =
                          index == settingsProvider.settingsList.length - 1;
                      return SettingsWidget(
                        settingsEntity: settingsProvider.settingsList[index],
                        isLast: isLast,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
