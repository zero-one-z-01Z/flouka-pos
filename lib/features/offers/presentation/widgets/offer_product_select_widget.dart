import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/core/widgets/validation_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../language/presentation/provider/language_provider.dart';
import '../../../products/presentation/providers/product_options_provider.dart';
import '../../../vendor_stores/presentation/providers/store_options_provider.dart';
import '../providers/offers_operations_provider.dart';

class OfferProductSelectWidget extends StatelessWidget {
  const OfferProductSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OffersOperationsProvider>(context);
    final productOptionsProvider = Provider.of<ProductOptionsProvider>(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(provider.listProducts.isNotEmpty)...[
          Text(LanguageProvider.translate("global", "products_selections"),style: TextStyleClass.captionStyle(),),
          SizedBox(height: 1.h),
          SingleChildScrollView(
            physics:const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(spacing: 1.w,
              children: List.generate(provider.listProducts.length, (index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal:0.5.w,vertical: 1.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:AppColor.primaryColor.withOpacity(0.5),
                    ),
                    child: Text(provider.listProducts[index].title,style: TextStyleClass.captionStyle(color: Colors.white),));
              },),
            ),
          ),
          SizedBox(height: 1.h),
        ],
        SizedBox(height: 1.h),
        ButtonWidget(onTap: (){
            provider.showAddWidget();
        }, text: LanguageProvider.translate("global", "select_product"),),
        SizedBox(height: 1.h),
        ValidationWidget(conditions: [
          {"value": provider.listProducts.isEmpty,
            "text": LanguageProvider.translate("validation", "select_product")}
        ]),
        SizedBox(height: 1.h),

      ],
    );
  }
}
