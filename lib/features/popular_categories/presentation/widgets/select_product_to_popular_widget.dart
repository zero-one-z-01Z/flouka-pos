import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/core/widgets/list_text_field_widget.dart';
import 'package:flouka_pos/core/widgets/validation_widget.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/widgets/checkbox_widget.dart';
import '../../../products/presentation/providers/product_options_provider.dart';
import '../providers/popular_category_provider.dart';

class AddOfferWidget extends StatelessWidget {
  const AddOfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProductOptionsProvider provider =Provider.of(context);
    PopularCategoryProvider popularCategoryProvider =Provider.of(context);
    return Form(
      key: popularCategoryProvider.formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LanguageProvider.translate("inputs", "select_product"),style: TextStyleClass.captionStyle(),),
                  SizedBox(height: 1.h,),
                  Container(width: 100.w,height: 0.1.h,color: Colors.grey,),
                  SizedBox(height: 1.h,),
                  Wrap(
                    runSpacing: 1.h,
                    children: List.generate(provider.productOptions.length, (index) {
                      bool isSelected =popularCategoryProvider.listProducts.contains(provider.productOptions[index].id);
                      return Row(
                        children: [
                          Text(provider.productOptions[index].title,style: TextStyleClass.captionStyle(),),
                          const Spacer(),
                          CheckBoxWidget(check: isSelected, onChange: (value) {
                            popularCategoryProvider.addToList(id: provider.productOptions[index].id);
                          }),
                        ],
                      );
                    },),
                  ),
                  SizedBox(height: 1.h,),
                  ValidationWidget(conditions: [
                    {"value": popularCategoryProvider.listProducts.isEmpty,
                      "text": LanguageProvider.translate("validation", "select_product")}
                  ]),

                ],
              ),
            ),
          ),
          SizedBox(height: 1.h,),
          Row(
            children: [
              Expanded(
                child: ButtonWidget(onTap: (){

                  if(popularCategoryProvider.formKey.currentState!.validate() &&
                      popularCategoryProvider.listProducts.isNotEmpty){
                    popularCategoryProvider.assignProductsToPopularCategories();
                  }
                }, text: "assign"),
              ),
              if(popularCategoryProvider.id != null)...[
                SizedBox(width: 2.w,),
                Expanded(
                  child: ButtonWidget(onTap: (){
                    popularCategoryProvider.reset();
                  }, color: Colors.red,text: "cancel_selection"),
                ),

              ],
            ],
          ),
          SizedBox(height: 1.h,),
        ],
      ),
    );
  }
}
