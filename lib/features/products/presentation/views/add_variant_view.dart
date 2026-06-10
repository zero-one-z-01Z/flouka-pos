import 'package:flouka_pos/core/widgets/list_text_field_widget.dart';
import 'package:flouka_pos/core/widgets/validation_widget.dart';
import 'package:flouka_pos/features/categories/presentation/providers/category_attributes_provider.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/products/presentation/providers/add_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/checkbox_widget.dart';
import '../../../../core/widgets/radio_widget.dart';
import '../../../../core/widgets/upload_multi_image_widget.dart';
import '../providers/add_variant_provider.dart';
import '../widgets/attribute_top_pill_widget.dart';
import '../widgets/attribute_selection_widget.dart';
import '../widgets/section_title_widget.dart';
import '../widgets/variant_card_widget.dart';
import '../widgets/variant_form_widget.dart';
import '../widgets/variant_widget.dart';

class AddVariantView extends StatelessWidget {
  const AddVariantView({super.key});
  @override
  Widget build(BuildContext context) {
    AddVariantProvider addVariantProvider = Provider.of(context);
    CategoryAttributesProvider attributesProvider = Provider.of(context);
    AddProductProvider addProductProvider =Provider.of(context);
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: addVariantProvider.formKey,
        child: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 3.h),
                  margin: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 1.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LanguageProvider.translate("global", "add_variant"),
                                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                                ),

                                ListTextFieldWidget(inputs: addVariantProvider.variantInputs),
                                SizedBox(height: 2.h),


                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LanguageProvider.translate('product', 'upload_variant_images'),
                                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 1.h),
                                SizedBox(width: 25.w,
                                  child: UploadMultiImageWidget(
                                    images: addVariantProvider.productImages,
                                    count: 5,
                                    deleteImage: (index) {
                                      addVariantProvider.deleteImage(index);
                                    },
                                    imagesList: (images) {
                                      addVariantProvider.addToImages(images);
                                    },
                                    title: 'upload_product_images',
                                    translationSection: 'product',
                                  ),
                                ),
                                SizedBox(height: 1.h,),
                                ValidationWidget(conditions: [
                                  {"value": addVariantProvider.productImages.isEmpty,
                                    "text": LanguageProvider.translate("product", "select_variant_images")}
                                ]),
                                SizedBox(height: 1.h,),
                                Wrap(
                                  children: List.generate(addVariantProvider.attributes.length, (index) {
                                    final attribute = addVariantProvider.attributes[index];
                                    return Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Row(
                                        //   children: [
                                        //     Text(
                                        //       LanguageProvider.translate('filter', attribute['title']),
                                        //       style: TextStyle(
                                        //         fontSize: 13.sp,
                                        //         fontWeight: FontWeight.bold,
                                        //         color: Colors.black,
                                        //       ),
                                        //     ),
                                        //     if(attribute['value']!=null )...[
                                        //       SizedBox(width: 4.w,),
                                        //       Expanded(child: Text(
                                        //         "${attribute['value']['name']}",
                                        //         style:TextStyleClass.normalStyle(color: AppColor.primaryColor).copyWith(
                                        //           fontWeight: FontWeight.bold,fontSize: 13.sp
                                        //         ),
                                        //       ),),
                                        //     ],
                                        //
                                        //   ],
                                        // ),
                                        Text(
                                          LanguageProvider.translate('filter', attribute['title']),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Container(
                                          padding:  EdgeInsets.symmetric(horizontal: 2.w),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(spacing:1.w,
                                              children: List.generate(attribute['children'].length, (index){
                                                return Row(
                                                  children: [
                                                    Text(attribute['children'][index]['name'],
                                                      style: TextStyleClass.normalStyle().copyWith(fontSize: 13.sp),maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,),
                                                    SizedBox(width: 1.w,),
                                                    RadioWidget(selected: attribute['children'][index]['active']??false, onTap: (){
                                                      addVariantProvider.setLabelValue(attribute, attribute['children'][index]);
                                                    }),

                                                  ],
                                                );
                                              },),
                                            ),
                                          ),
                                        ),

                                        Container(color: Colors.grey.shade200,margin: EdgeInsets.symmetric(vertical: 1.h),
                                          width: double.infinity,height: 0.2.h,)
                                      ],
                                    );
                                  },),
                                ),
                                SizedBox(height: 1.h),
                                ValidationWidget(conditions: [
                                  {"value": !addVariantProvider.isAllAttributesSelected,
                                    "text": LanguageProvider.translate("product", "select_all")}
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      Center(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonWidget(
                              onTap: () {
                                if(addVariantProvider.formKey.currentState!.validate()){
                                  if(addVariantProvider.variant !=null){
                                    addVariantProvider.updateVariant();
                                  }else{
                                    addVariantProvider.createVariant();
                                  }
                                }
                              },
                              text:addVariantProvider.variant !=null ? "update_variant" : "add_variant",
                              width: 15.w,
                              height: 5.h,
                              borderRadius: 8,
                            ),
                            if(addVariantProvider.variant !=null)...[
                              SizedBox(width: 2.w,),
                              ButtonWidget(onTap: (){
                                addVariantProvider.reset();
                              }, color: Colors.red,height: 5.h,
                                borderRadius: 8,text: "cancel_selection",width: 15.w,),

                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if(addProductProvider.product != null )
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                      margin: EdgeInsets.symmetric(vertical: 1.h),

                      child: Wrap(runSpacing: 1.h,spacing: 1.w,
                        children: List.generate(addProductProvider.product!.variants.length,
                                (index) => VariantWidget(variant: addProductProvider.product!.variants[index])),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
