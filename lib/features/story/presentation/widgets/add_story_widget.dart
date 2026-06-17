import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/core/widgets/drop_down_widget.dart';
import 'package:flouka_pos/core/widgets/list_text_field_widget.dart';
import 'package:flouka_pos/features/products/presentation/providers/product_options_provider.dart';
import 'package:flouka_pos/features/vendor_stores/presentation/providers/store_operations_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/config/app_styles.dart';
import '../../../../core/widgets/validation_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/stories_operations_provider.dart';

class AddStoryWidget extends StatelessWidget {
  const AddStoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    StoriesOperationsProvider storiesOperationsProvider = Provider.of(context);
    ProductOptionsProvider productOptionsProvider = Provider.of(context);
    return Form(
      key: storiesOperationsProvider.formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LanguageProvider.translate("global", "image_story"),
                    style: TextStyleClass.captionStyle().copyWith(fontWeight: FontWeight.bold),),
                  SizedBox(height: 1.h,),
                  InkWell(
                    onTap: (){
                      storiesOperationsProvider.selectStoryImage();
                    },
                    child: Container(
                      width: double.infinity,height: 10.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        image: DecorationImage(
                          image: storiesOperationsProvider.showLogoImage(),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  ValidationWidget(conditions: [
                    {"value": storiesOperationsProvider.storyImage == null,
                      "text": LanguageProvider.translate("global", "select_story_image")}
                  ]),
                  SizedBox(height: 1.h,),
                  ListTextFieldWidget(inputs: storiesOperationsProvider.addStoreInputs),
                  SizedBox(height: 1.h,),
                  Text(LanguageProvider.translate("inputs", "select_product"),
                    style: TextStyleClass.captionStyle().copyWith(fontWeight: FontWeight.bold),),
                  SizedBox(height: 1.h,),
                  DropDownWidget(dropDownClass:productOptionsProvider ),
                  SizedBox(height: 1.h,),
                  // ValidationWidget(conditions: [
                  //   {"value": productOptionsProvider.productOptionEntity == null,
                  //     "text": LanguageProvider.translate("global", "select_product")}
                  // ]),
                ],
              ),
            ),
          ),
          SizedBox(height: 1.h,),
          ButtonWidget(onTap: (){
            if(storiesOperationsProvider.formKey.currentState!.validate()
                && storiesOperationsProvider.storyImage != null
                && productOptionsProvider.productOptionEntity != null){
              storiesOperationsProvider.addStore();
            }
          }, text: "add_store"),
          SizedBox(height: 1.h,),
        ],
      ),
    );
  }
}
