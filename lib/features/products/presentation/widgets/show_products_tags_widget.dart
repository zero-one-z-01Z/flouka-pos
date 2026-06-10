import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/core/widgets/checkbox_widget.dart';
import 'package:flouka_pos/features/coupons/presentation/providers/coupons_operations_provider.dart';
import 'package:flouka_pos/features/products/presentation/providers/product_options_provider.dart';
import 'package:flouka_pos/features/products/presentation/providers/tags_options_provider.dart';
import 'package:flouka_pos/features/vendor_stores/presentation/providers/store_operations_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../vendor_stores/presentation/providers/store_options_provider.dart';
import '../providers/add_product_provider.dart';

class ShowProductsTagsWidget extends StatelessWidget {
  const ShowProductsTagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TagsOptionsProvider provider =Provider.of(context);
    AddProductProvider addProductProvider=Provider.of(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  runSpacing: 1.h,
                  children: List.generate(provider.productOptions.length, (index) {
                    bool isSelected =addProductProvider.tags.contains(provider.productOptions[index]);
                    return Row(
                      children: [
                        Text(provider.productOptions[index].name,style: TextStyleClass.captionStyle(),),
                        const Spacer(),
                        CheckBoxWidget(check: isSelected, onChange: (value) {
                          addProductProvider.addToList(tag: provider.productOptions[index]);
                        }),
                      ],
                    );
                  },),
                ),

              ],
            ),
          ),
        ),
        SizedBox(height: 1.h,),
        ButtonWidget(onTap: (){
          navPop();
        }, text: "save"),
        SizedBox(height: 1.h,),

      ],
    );
  }
}
