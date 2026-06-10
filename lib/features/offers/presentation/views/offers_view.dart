import 'package:cached_network_image/cached_network_image.dart';
import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/widgets/empty_animation.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/offers_operations_provider.dart';
import '../providers/offers_provider.dart';
import '../widgets/add_offer_widget.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    final OffersProvider offersProvider = Provider.of<OffersProvider>(context,);
    final OffersOperationsProvider offersOperationsProvider = Provider.of<OffersOperationsProvider>(context,);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2,
              child: Builder(builder: (context) {
                if(offersProvider.data == null) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if(offersProvider.data!.isEmpty) {
                  return const Center(child: EmptyAnimation(title: "", gif: Lotties.noSearch));
                }
                return Wrap(
                  runSpacing: 2.w,
                  spacing: 2.w,
                  children: List.generate(offersProvider.data!.length, (index) {
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
                                Text("${LanguageProvider.translate("inputs", "offer_name")} : ${offersProvider.data![index].name}",
                                  maxLines: 1,
                                  style: TextStyleClass.captionStyle(),),
                                Text("${LanguageProvider.translate("inputs", "offer_percentage")} : ${offersProvider.data![index].percentage}",
                                  maxLines: 1,
                                  style: TextStyleClass.captionStyle(),),
                                Text("${LanguageProvider.translate("global", "products_selections")} : ",
                                  style: TextStyleClass.captionStyle(),),
                                Text("${offersProvider.data![index].products.map((e) => e.title).join("\n")}",
                                  style: TextStyleClass.captionStyle(color: AppColor.primaryColor).copyWith(
                                      fontSize: 12.sp
                                  ),),

                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              offersOperationsProvider.selectToEdit(offer: offersProvider.data![index]);
                            },
                            child: Icon(Icons.edit,size: 1.5.w,color: AppColor.primaryColor,),
                          ),
                          SizedBox(width: 0.5.w,),
                          InkWell(
                            onTap: (){
                              offersOperationsProvider.deleteCouponDialog(id: offersProvider.data![index].id);
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
            if(offersProvider.data != null)
            const Expanded(child: AddOfferWidget()),
          ],
        ),
      ),
    );
  }
}
