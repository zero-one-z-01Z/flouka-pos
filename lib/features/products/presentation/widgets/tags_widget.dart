import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../providers/add_product_provider.dart';

class TagsWidget extends StatelessWidget {
  const TagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AddProductProvider provider = Provider.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
        Text(LanguageProvider.translate("global", "selected_tags"),style: TextStyleClass.smallStyle(),),
        SizedBox(height: 1.h),
        SingleChildScrollView(
          physics:const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(provider.tags.length, (index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.primaryColor,
                ),
                child: Text(provider.tags[index].name,style: TextStyleClass.smallStyle(color: Colors.white),),
              );
            },),
          ),
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
