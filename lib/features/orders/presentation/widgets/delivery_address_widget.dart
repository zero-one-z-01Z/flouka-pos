import 'package:cached_network_image/cached_network_image.dart';
import 'package:flouka_pos/core/helper_function/contact.dart';
import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flouka_pos/features/chat/presentation/provider/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_styles.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/order_details_provider.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    // AuthProvider authProvider = Provider.of(context);
    return Container(
      width: 30.w,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(orderDetailsProvider.orderEntity?.user?.image != null)
          Row(
            children: [
              Container(
                width: 4.w,
                height: 4.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.primaryColor),
                  image: DecorationImage(image: CachedNetworkImageProvider(orderDetailsProvider.orderEntity!.user!.image))
                ),
              ),
              SizedBox(width: 1.w),
              Expanded(
                child: Text(orderDetailsProvider.orderEntity!.user!.name,
                  style: TextStyleClass.smallStyle().copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 1.w),
              ButtonWidget(onTap: (){
                Provider.of<MessageProvider>(context,listen: false)
                    .goToMessagePage(orderId: orderDetailsProvider.orderEntity!.id,
                    userId: orderDetailsProvider.orderEntity!.vendorOrders.items!.first.storeId??0);
              }, text:"chat",takeSmallestWidth: true,height: 5.h,borderRadius: 3,),
              SizedBox(width: 1.w),
              InkWell(onTap: (){
                callPhone(orderDetailsProvider.orderEntity!.user!.fullPhone);
              },child: Icon(Icons.call,size: 3.w,),),
            ],
          ),
          Text(
            LanguageProvider.translate("global", "delivery_address"),
            style: TextStyleClass.smallStyle().copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            orderDetailsProvider.orderEntity!.address.address,
            style: TextStyleClass.smallStyle().copyWith(
              color: const Color(0xff535353),
              fontSize: 13.sp,
            ),
          ),
          Text(
            "${orderDetailsProvider.orderEntity!.address.city.name}, ${orderDetailsProvider.orderEntity!.address.area.name}",
            style: TextStyleClass.smallStyle().copyWith(
              color: const Color(0xff535353),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 0.5.h),
          Row(
            spacing: 1.w,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                LanguageProvider.translate("global", "Mobile number"),
                style: TextStyleClass.normalStyle().copyWith(
                  color: const Color(0xff595959),
                  fontSize: 13.sp,
                ),
              ),
              Text(
                orderDetailsProvider.orderEntity!.user?.phone??"",
                style: TextStyleClass.normalStyle().copyWith(
                  color: AppColor.primaryColor,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
