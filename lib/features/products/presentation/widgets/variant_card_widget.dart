import 'package:flouka_pos/features/products/domain/entity/variant_entity.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';

class VariantCardWidget extends StatelessWidget {
  final VariantEntity variant;

  const VariantCardWidget({
    super.key,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 13.w,
      padding: EdgeInsets.all(0.8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardRow("SKU", variant.sku, isBlue: true),
              SizedBox(height: 0.5.h),
              _buildCardRow("Price", ": ${variant.price}\$"),
              SizedBox(height: 0.5.h),
              _buildCardRow("Stock", ": ${variant.stock}"),
              SizedBox(height: 0.5.h),
              Divider(color: Colors.grey.shade200),
              SizedBox(height: 0.5.h),
              _buildCardRow("RAM", ": ${variant.stock}"),
              SizedBox(height: 0.5.h),
              _buildCardRow("Storage", ": ${variant.stock}"),
              SizedBox(height: 0.5.h),
              _buildCardRow("Color", ": ${variant.stock}"),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardRow(
    String label,
    String value, {
    bool isBlue = false,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label ",
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 9.sp,
              color: isBlue
                  ? AppColor.primaryColor
                  : Colors.black54,
              fontWeight:
                  isBlue ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
