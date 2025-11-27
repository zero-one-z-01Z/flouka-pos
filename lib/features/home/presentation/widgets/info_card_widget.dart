import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/widgets/svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_images.dart';
import '../../domain/entity/info_card_entity.dart';

class InfoCardWidget extends StatelessWidget {
  final InfoCardEntity infoCardEntity;

  const InfoCardWidget({super.key, required this.infoCardEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: infoCardEntity.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(1.h),
            decoration: BoxDecoration(
              color: infoCardEntity.svgBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const SvgWidget(svg: Images.products),
          ),
          SizedBox(width: 1.5.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  infoCardEntity.title,
                  style: TextStyleClass.smallStyle().copyWith(fontSize: 12.sp),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  infoCardEntity.subtitle,
                  style: TextStyleClass.smallStyle(
                    color: const Color(0xff71747d),
                  ).copyWith(fontSize: 10.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
