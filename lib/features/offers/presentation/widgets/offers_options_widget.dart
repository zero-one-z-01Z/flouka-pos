import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/core/widgets/checkbox_widget.dart';
import 'package:flouka_pos/features/coupons/presentation/providers/coupons_operations_provider.dart';
import 'package:flouka_pos/features/products/presentation/providers/product_options_provider.dart';
import 'package:flouka_pos/features/vendor_stores/presentation/providers/store_operations_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../vendor_stores/presentation/providers/store_options_provider.dart';
import '../providers/offers_operations_provider.dart';

class OffersOptionsWidget extends StatelessWidget {
  const OffersOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProductOptionsProvider provider =Provider.of(context);
    OffersOperationsProvider offersOperationsProvider=Provider.of(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  runSpacing: 1.h,
                  children: List.generate(provider.productOptions.length, (index) {
                    bool isSelected =offersOperationsProvider.listProducts.contains(provider.productOptions[index]);
                    return Row(
                      children: [
                        Text(provider.productOptions[index].title,style: TextStyleClass.captionStyle(),),
                        const Spacer(),
                        CheckBoxWidget(check: isSelected, onChange: (value) {
                          offersOperationsProvider.addToList(option: provider.productOptions[index]);
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
