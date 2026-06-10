import 'package:cached_network_image/cached_network_image.dart';
import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/helper_function/convert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/widgets/empty_animation.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/sections_provider.dart';
import '../widgets/select_product_to_popular_widget.dart';

class SectionsView extends StatelessWidget {
  const SectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SectionsProvider popularCategoryProvider = Provider.of<SectionsProvider>(context,);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2,
              child: Builder(builder: (context) {
                if(popularCategoryProvider.data == null) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if(popularCategoryProvider.data!.isEmpty) {
                  return const Center(child: EmptyAnimation(title: "", gif: Lotties.noSearch));
                }
                return Wrap(
                  runSpacing: 2.w,
                  spacing: 2.w,
                  children: List.generate(popularCategoryProvider.data!.length, (index) {
                    return Container(width: 20.w,
                      padding:const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 6,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,spacing: 1.h,
                              children: [
                                Text("${LanguageProvider.translate("inputs", "title")} : ${popularCategoryProvider.data![index].title}",
                                  maxLines: 1,
                                  style: TextStyleClass.captionStyle(),),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              popularCategoryProvider.selectToEdit(section: popularCategoryProvider.data![index]);
                            },
                            child: Icon(Icons.edit,size: 1.5.w,color: AppColor.primaryColor,),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }),
            ),
            if(popularCategoryProvider.id != null)
            const Expanded(child: AddOfferWidget()),
          ],
        ),
      ),
    );
  }
}
