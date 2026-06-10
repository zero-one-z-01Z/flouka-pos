import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/models/text_field_model.dart';
import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/core/widgets/list_text_field_widget.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/products/domain/entity/product_entity.dart';
import 'package:flouka_pos/features/products/presentation/widgets/sold_by_product_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/store_operation_provider.dart';

class ProductPreviewOverlay extends StatelessWidget {
  final ProductEntity product;

  const ProductPreviewOverlay({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    StoreOperationProvider storeOperationProvider =Provider.of(context, listen: false);
    num? productStock = product.stock?.quantity ;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Carousel
          if(product.image != null)
            Container(
              width: double.infinity,height: 15.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(product.image.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          // Page indicator

          SizedBox(height: 2.h),

          // Product Name
          Row(
            children: [
              Expanded(
                child: Text(
                  product.title.toString(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "\$${product.price}",
                style:
                TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),

            ],
          ),
          SizedBox(height: 1.h),
          Text(
            product.description.toString(),
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey[500],
              height: 1.5,
            ),
          ),
          SizedBox(height: 2.h),
          if(product.variants.isNotEmpty)
            ExpansionTile(
              title: Text(LanguageProvider.translate("global", "variants"),style: TextStyleClass.captionStyle(),),
              iconColor: AppColor.primaryColor,
              collapsedIconColor: AppColor.primaryColor,
              tilePadding: EdgeInsets.zero,
              children: List.generate(product.variants.length, (index) {
                num stock = product.variants[index].stock == null ? 0
                : product.variants[index].stock is num   ? product.variants[index].stock : product.variants[index].stock.quantity;
                print('${product.variants[index].stock}');
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
                    Expanded(flex: 2,child: Text(product.variants[index].name,style: TextStyleClass.captionStyle().copyWith(fontSize: 12.sp),)),
                    SizedBox(width: 1.w,),
                    Text(LanguageProvider.translate("inputs", "stock"),
                      style: TextStyleClass.captionStyle().copyWith(fontSize: 12.sp),),
                    SizedBox(width: 1.w,),
                    Expanded(child: ListTextFieldWidget(borderRadius: 5,inputs:  [TextFieldModel(key: "key",
                        hint: "stock",
                        controller: product.variants[index].quantityController,
                        textInputType: TextInputType.number,validator:(num) {
                          if(num == null) return LanguageProvider.translate("validation", "valid_number");
                          return null;
                        },)],)),
                    SizedBox(width: 1.w,),
                    Expanded(flex: 1,child: Column(
                      children: [
                        ButtonWidget(height: 5.h,borderRadius: 5,onTap: (){
                          if(product.variants[index].quantityController.text.isEmpty ||
                          num.parse(product.variants[index].quantityController.text) == stock) return;
                          storeOperationProvider.addProductToStore(id: product.id,
                              quantity: num.parse(product.variants[index].quantityController.text),
                              productVariantId: product.variants[index].id);
                        }, text: "update",),
                        if(product.variants[index].stock !=null)...[
                          SizedBox(height: 1.h,),
                          ButtonWidget(height: 5.h,color: Colors.red,borderRadius: 5,onTap: (){
                            storeOperationProvider.removeStock(storeProductStockId: product.variants[index].stock!.id
                            ,productId: product.id,removeProduct: false);
                          }, text: "remove",),
                        ],
                      ],
                    )),
                  ],),
                );
              },),
            ),
          if(product.variants.isEmpty)
            Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
              Expanded(
                child: Text(LanguageProvider.translate("inputs", "stock"),
                  style: TextStyleClass.captionStyle().copyWith(fontSize: 12.sp),),
              ),
              SizedBox(width: 1.w,),
              Expanded(child: ListTextFieldWidget(borderRadius: 5,inputs:  [TextFieldModel(key: "key",
                hint: "stock",
                controller: storeOperationProvider.stockController,
                textInputType: TextInputType.number,validator:(num) {
                  if(num == null) return LanguageProvider.translate("validation", "valid_number");
                  return null;
                },)],)),
              SizedBox(width: 1.w,),
              Expanded(flex: 1,child: Column(
                children: [
                  ButtonWidget(height: 5.h,borderRadius: 5,onTap: (){
                    if(storeOperationProvider.stockController.text.isEmpty ||
                        num.parse(storeOperationProvider.stockController.text) == productStock) return;
                    storeOperationProvider.addProductToStore(id: product.id,
                        quantity: num.parse(storeOperationProvider.stockController.text),
                    );
                  }, text: "update",),
                  if(product.stock !=null)...[
                    SizedBox(height: 1.h,),
                    ButtonWidget(height: 5.h,color: Colors.red,borderRadius: 5,onTap: (){
                      storeOperationProvider.removeStock(storeProductStockId: product.stock!.id,
                      productId: product.id,removeProduct: true);
                    }, text: "remove",),

                  ],

                ],
              )),
            ],)
        ],
      ),
    );
  }
}
