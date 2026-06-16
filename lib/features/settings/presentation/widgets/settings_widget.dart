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
    return SizedBox(
      width: (100.w/2)-10.w,
      child: Column(
        children: [
          InkWell(
            onTap: settingsEntity.onTap,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LanguageProvider.translate(
                        "settings",
                        settingsEntity.text,
                      ),
                      style: TextStyleClass.smallStyle(),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!isLast)
            Divider(thickness: 0.15.h,color: const Color(0xffEFEFEF),),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(color: const Color(0xffEFEFEF), height: 0.15.h),
            //     ),
            //   ],
            // ),
        ],
      ),
    );
  }
}
