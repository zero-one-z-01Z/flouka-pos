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
import '../providers/sections_provider.dart';

class AddOfferWidget extends StatelessWidget {
  const AddOfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProductOptionsProvider provider =Provider.of(context);
    SectionsProvider sectionsProvider =Provider.of(context);
    return Form(
      key: sectionsProvider.formKey,
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
                      bool isSelected =sectionsProvider.listProducts.contains(provider.productOptions[index].id);
                      return Row(
                        children: [
                          Text(provider.productOptions[index].title,style: TextStyleClass.captionStyle(),),
                          const Spacer(),
                          CheckBoxWidget(check: isSelected, onChange: (value) {
                            sectionsProvider.addToList(id: provider.productOptions[index].id);
                          }),
                        ],
                      );
                    },),
                  ),
                  SizedBox(height: 1.h,),
                  ValidationWidget(conditions: [
                    {"value": sectionsProvider.listProducts.isEmpty,
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

                  if(sectionsProvider.formKey.currentState!.validate() &&
                      sectionsProvider.listProducts.isNotEmpty){
                    sectionsProvider.assignProductsToPopularCategories();
                  }
                }, text: "assign"),
              ),
              if(sectionsProvider.id != null)...[
                SizedBox(width: 2.w,),
                Expanded(
                  child: ButtonWidget(onTap: (){
                    sectionsProvider.reset();
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
