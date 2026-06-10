import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/features/products/presentation/providers/add_variant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entity/variant_entity.dart';

class VariantWidget extends StatelessWidget {
  const VariantWidget({super.key, required this.variant});
  final VariantEntity variant;

  @override
  Widget build(BuildContext context) {
    AddVariantProvider addVariantProvider = Provider.of(context);
    return SizedBox(width: 16.w,
      child: Stack(
        children: [
          Container(width: 16.w,
            padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h).copyWith(top: 5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("SKU : ${variant.sku}",
                maxLines: 1,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
              Text("${LanguageProvider.translate('inputs', 'name')} : ${variant.name}",maxLines: 1,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
                Text("${LanguageProvider.translate('inputs', 'price')} : ${variant.price}",maxLines: 1,
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
                if(variant.offerPrice!=null && variant.offerPrice! > 0)
                  Text("${LanguageProvider.translate('inputs', 'offer_price')} : ${variant.offerPrice}",maxLines: 1,
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                  ),
            ],),
          ),
          Row(mainAxisAlignment:MainAxisAlignment.end,children: [
            IconButton(onPressed: (){
              addVariantProvider.selectToEdit(variant: variant);
            }, icon: Icon(Icons.edit,color: AppColor.primaryColor,size: 2.w,)),
            IconButton(onPressed: (){
              addVariantProvider.deleteVariantDialog(id: variant.id);
            }, icon: Icon(Icons.delete,color: Colors.red,size: 2.w,)),

          ],),
        ],
      ),
    );
  }
}
