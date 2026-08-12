import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entities/profile_settings_entity.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    super.key,
    required this.settingsEntity,
    this.isLast = false,
  });
  final ProfileSettingsEntity settingsEntity;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: settingsEntity.onTap,
          borderRadius: BorderRadius.circular(isLast ? 16 : 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    LanguageProvider.translate(
                      'settings',
                      settingsEntity.text,
                    ),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.ink,
                    ),
                  ),
                ),
                if (settingsEntity.badge)
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 10),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColor.gold,
                      shape: BoxShape.circle,
                    ),
                  ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: AppColor.textMuted,
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          const Divider(
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: AppColor.hairline,
          ),
      ],
    );
  }
}
