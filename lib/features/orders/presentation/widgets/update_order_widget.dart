import 'package:cached_network_image/cached_network_image.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/features/orders/presentation/providers/order_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/custom_star_rating_widget.dart';
import '../../../../core/widgets/price_widget.dart';
import '../../domain/entity/order_entity.dart';

class UpdateOrderWidget extends StatelessWidget {
  const UpdateOrderWidget({super.key, required this.ordersEntity});
  final VendorOrderEntity ordersEntity;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderDetailsProvider>(context, listen: false);
    return Column(
      children: [
        if(ordersEntity.items !=null && ordersEntity.items!.isNotEmpty)
        Wrap(runSpacing: 1.h,spacing: 1.w,
          children: List.generate(ordersEntity.items!.length, (index) {
            num? currentQuantity = ordersEntity.items![index].afterQuantity;
            return Container(
              width: 20.w,
              decoration: BoxDecoration(
                color: const Color(0xfff3f3f3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: 20.w,height: 15.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(ordersEntity.items![index].product!.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal:0.5.w),
                    child: Column(
                      spacing: 1.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 0.5.h,),
                        Text(ordersEntity.items![index].variant?.sku??"",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyleClass.smallStyle()
                              .copyWith(color: const Color(0xff333542))
                              .copyWith(fontSize: 13.sp,height: 1),
                        ),
                        SizedBox(height: 0.5.h,),
                        Text(ordersEntity.items![index].variant?.name??"",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyleClass.smallStyle()
                              .copyWith(color: const Color(0xff333542))
                              .copyWith(fontSize: 13.sp,height: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 4,
                          children: [
                            PriceWidget(price: ordersEntity.items![index].variant!.price!, isGreen: false, isBold: true),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomStarRatingWidget(itemSize: 11.sp, rate: ordersEntity.items![index].product!.rate!),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      "${ordersEntity.items![index].product!.rate!}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyleClass.smallStyle(
                                        color: Colors.grey,
                                      ).copyWith(fontSize: 10.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(LanguageProvider.translate("global", ordersEntity.items![index].status?.text??""),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyleClass.smallStyle().copyWith(color:ordersEntity.items![index].status?.color),
                        ),
                        Text("${LanguageProvider.translate('product', 'quantity')} : ${ordersEntity.items![index].quantity.toString() }",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyleClass.smallStyle()
                              .copyWith(color: const Color(0xff333542))
                              .copyWith(fontSize: 13.sp),
                        ),
                        if(provider.canUpdateStock())...[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.grey),
                              boxShadow: [BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              )],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                      onTap: (){
                                        ordersEntity.items![index].increaseQuantity();
                                      },
                                      child: Icon(Icons.add, size: 15.sp,)
                                  ),
                                ),
                                Expanded(
                                  child: Center(child: Text(ordersEntity.items![index].changeableQuantity.toString(),maxLines: 1, style: TextStyleClass.smallStyle().copyWith(fontSize: 14.sp),)),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      ordersEntity.items![index].decreaseQuantity();
                                    },
                                    child: Icon(Icons.remove, size: 15.sp,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        SizedBox(height: 0.5.h,),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },),
        ),
      ],
    );
  }
}
