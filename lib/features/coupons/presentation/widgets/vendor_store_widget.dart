import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../domain/entity/coupon_entity.dart';

class VariantFormWidget extends StatelessWidget {
  final CouponEntity storeEntity;

  const VariantFormWidget({super.key, required this.storeEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [

        ],
      ),
    );
  }

}
