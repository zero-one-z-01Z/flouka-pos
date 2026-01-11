import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_styles.dart';
import '../../../../core/widgets/button_widget.dart';

class DelivryItemWidget extends StatelessWidget {
  const DelivryItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2.w, right: 3.w, top: 2.h, bottom: 2.h),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff22C55E)),
        color: const Color(0xffECFDF5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 1.w,
            children: [
              Text(
                "🚚 ${LanguageProvider.translate('global', 'nearest_available')} ",
                style: TextStyleClass.smallStyle()
                    .copyWith(color: const Color(0xff333542))
                    .copyWith(fontSize: 12.sp),
              ),
              ButtonWidget(
                color: const Color(0xff22C55E),
                height: 3.h,
                width: 10.w,
                onTap: () {},
                text: LanguageProvider.translate('buttons', 'selected'),
              ),
            ],
          ),
          Text(
            "📅 ${LanguageProvider.translate('time', 'today')} ",
            style: TextStyleClass.smallStyle()
                .copyWith(color: const Color(0xff333542))
                .copyWith(fontSize: 12.sp),
          ),
          Text(
            "⏰ 6:00 – 9:00 PM ",
            style: TextStyleClass.smallStyle()
                .copyWith(color: const Color(0xff333542))
                .copyWith(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
