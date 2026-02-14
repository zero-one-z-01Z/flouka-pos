import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../domain/entities/product_entity.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  final ValueChanged<bool>? onActiveChanged;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProductItemWidget({
    super.key,
    required this.product,
    this.onActiveChanged,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15.w, // small width to fit multiple items per row
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            height: 12.h,
            decoration: BoxDecoration(
              color: const Color(0xfff8f7fa),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(product.imagePath, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 1.h),

          // Name
          Text(
            product.name,
            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 0.5.h),

          // Price + Old Price
          Row(
            children: [
              Text(
                "\$${product.price}",
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600),
              ),
              if (product.oldPrice != null) ...[
                SizedBox(width: 2.w),
                Text(
                  "\$${product.oldPrice}",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColor.tertiaryColor,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ]
            ],
          ),

          // Rating
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 14),
              SizedBox(width: 1.w),
              Text(
                product.rating.toString(),
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 1.h),

          // Switch + Edit/Delete icons
          Row(
          
            children: [
              // Active Switch
              Row(
                children: [
                  Switch(
                    value: product.isActive,
                    onChanged: onActiveChanged,
                    activeColor: AppColor.primaryColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Text(
                    product.isActive ? "Active" : "Inactive",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                ],
              ),
              SizedBox(width: 1.w,),
              // Edit / Delete Icons
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(Icons.edit, size: 14.sp, color: Colors.blue),
                    onPressed: onEdit,
                  ),
                  SizedBox(width: 1.w),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(Icons.delete, size: 14.sp, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
