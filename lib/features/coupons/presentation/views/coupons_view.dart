import 'package:cached_network_image/cached_network_image.dart';
import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/widgets/empty_animation.dart';
import '../providers/coupons_operations_provider.dart';
import '../providers/coupons_provider.dart';
import '../widgets/add_coupon_widget.dart';

class CouponsView extends StatelessWidget {
  const CouponsView({super.key});

  @override
  Widget build(BuildContext context) {
    final CouponsProvider couponsProvider = Provider.of<CouponsProvider>(context,);
    final CouponsOperationsProvider couponsOperationsProvider = Provider.of<CouponsOperationsProvider>(context,);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2,
              child: Builder(builder: (context) {
                if(couponsProvider.data == null) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if(couponsProvider.data!.isEmpty) {
                  return const Center(child: EmptyAnimation(title: "", gif: Lotties.noSearch));
                }
                return Wrap(
                  runSpacing: 2.w,
                  spacing: 2.w,
                  children: List.generate(couponsProvider.data!.length, (index) {
                    return Container(width: 20.w,
                      padding:const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(flex: 6,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,spacing: 1.h,
                              children: [
                                Text("${LanguageProvider.translate("inputs", "coupon_name")} : ${couponsProvider.data![index].name}",
                                  maxLines: 1,
                                  style: TextStyleClass.captionStyle().copyWith(
                                    fontSize: 12.sp
                                  ),),
                                Text("${LanguageProvider.translate("inputs", "coupon_code")} : ${couponsProvider.data![index].coupon}",
                                  maxLines: 1,
                                  style: TextStyleClass.captionStyle().copyWith(
                                      fontSize: 12.sp
                                  ),),
                                Text("${LanguageProvider.translate("inputs", "coupon_type")} : ${LanguageProvider.translate("global", "${couponsProvider.data![index].type}")}",
                                  maxLines: 1,
                                  style: TextStyleClass.captionStyle().copyWith(
                                      fontSize: 12.sp
                                  ),),
                                Text("${LanguageProvider.translate("inputs", "count")} : ${couponsProvider.data![index].count}",
                                  maxLines: 1,
                                  style: TextStyleClass.captionStyle().copyWith(
                                      fontSize: 12.sp
                                  ),),

                                if(couponsProvider.data![index].min != null && couponsProvider.data![index].min! >0
                                    &&couponsProvider.data![index].type == "fixed")
                                Text("${LanguageProvider.translate("inputs", "min")} : ${couponsProvider.data![index].min}",
                                  maxLines: 1,
                                  style: TextStyleClass.captionStyle().copyWith(
                                      fontSize: 12.sp
                                  ),),

                                if(couponsProvider.data![index].max != null && couponsProvider.data![index].max! >0
                                    &&couponsProvider.data![index].type == "percentage")
                                  Text("${LanguageProvider.translate("inputs", "max")} : ${couponsProvider.data![index].max}",
                                    maxLines: 1,
                                    style: TextStyleClass.captionStyle().copyWith(
                                        fontSize: 12.sp
                                    ),),

                                Text("${LanguageProvider.translate("global", "stores_selections")} : ",
                                  style: TextStyleClass.captionStyle(),),
                                Text("${couponsProvider.data![index].stores.map((e) => e.name).join("\n")}",
                                  style: TextStyleClass.captionStyle(color: AppColor.primaryColor).copyWith(
                                    fontSize: 12.sp
                                  ),),

                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              couponsOperationsProvider.selectToEdit(coupon: couponsProvider.data![index]);
                            },
                            child: Icon(Icons.edit,size: 1.5.w,color: AppColor.primaryColor,),
                          ),
                          SizedBox(width: 0.5.w,),
                          InkWell(
                            onTap: (){
                              couponsOperationsProvider.deleteCouponDialog(id: couponsProvider.data![index].id);
                            },
                            child: Icon(Icons.delete,size: 1.5.w,color: Colors.red,),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }),
            ),
            if(couponsProvider.data != null)
            const Expanded(child: AddCouponWidget()),
          ],
        ),
      ),
    );
  }
}
