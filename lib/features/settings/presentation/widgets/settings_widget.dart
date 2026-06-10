import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/config/app_styles.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/widgets/svg_widget.dart';
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
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: settingsEntity.onTap,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            LanguageProvider.translate(
                              "settings",
                              settingsEntity.text,
                            ),
                            style: TextStyleClass.normalStyle(),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 4.w,
                        color: const Color(0xffA5A5A5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (!isLast)
            Row(
              children: [
                Expanded(
                  child: Container(color: const Color(0xffEFEFEF), height: 0.15.h),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
