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
import '../../../../core/widgets/upload_video_widget.dart';
import '../../../../core/widgets/validation_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/reels_operations_provider.dart';

class AddReelWidget extends StatelessWidget {
  const AddReelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ReelsOperationsProvider reelsOperationsProvider = Provider.of(context);
    ProductOptionsProvider productOptionsProvider = Provider.of(context);
    return Form(
      key: reelsOperationsProvider.formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LanguageProvider.translate("inputs", "reel_video"),
                    style: TextStyleClass.captionStyle().copyWith(fontWeight: FontWeight.bold),),
                  Text(LanguageProvider.translate("global", "video_duration"),
                    style: TextStyleClass.captionStyle(color: Colors.grey).
                    copyWith(fontWeight: FontWeight.bold,fontSize: 11.sp),),
                  SizedBox(height: 1.h,),
                  UploadVideoWidget(
                    image: reelsOperationsProvider.cover,
                    video: reelsOperationsProvider.video,
                    selectImage: (a) {
                      reelsOperationsProvider.addVideo(a);
                    }, onTap: () { reelsOperationsProvider.removeVideo(); },),
                  SizedBox(height: 1.h,),
                  ValidationWidget(conditions: [
                    {"value": reelsOperationsProvider.video == null,
                      "text": LanguageProvider.translate("global", "select_video")}
                  ]),
                  SizedBox(height: 1.h,),
                  ListTextFieldWidget(inputs: reelsOperationsProvider.addStoreInputs),
                  SizedBox(height: 1.h,),
                  Text(LanguageProvider.translate("inputs", "select_product"),
                    style: TextStyleClass.captionStyle().copyWith(fontWeight: FontWeight.bold),),
                  SizedBox(height: 1.h,),
                  DropDownWidget(dropDownClass:productOptionsProvider ),
                  SizedBox(height: 1.h,),
                  ValidationWidget(conditions: [
                    {"value": productOptionsProvider.productOptionEntity == null,
                      "text": LanguageProvider.translate("global", "select_product")}
                  ]),
                ],
              ),
            ),
          ),
          SizedBox(height: 1.h,),
          ButtonWidget(onTap: (){
            if(reelsOperationsProvider.formKey.currentState!.validate()
                && reelsOperationsProvider.video != null
                && productOptionsProvider.productOptionEntity != null){
              reelsOperationsProvider.addReel();
            }
          }, text: "add_store"),
          SizedBox(height: 1.h,),
        ],
      ),
    );
  }
}
