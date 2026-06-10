import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/core/widgets/list_text_field_widget.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../providers/coupons_operations_provider.dart';
import 'coupon_stores_select_widget.dart';

class AddCouponWidget extends StatelessWidget {
  const AddCouponWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CouponsOperationsProvider couponsOperationsProvider = Provider.of(context);
    return Form(
      key: couponsOperationsProvider.formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          couponsOperationsProvider.setIsPercentage(true);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: couponsOperationsProvider.isPercentage ? Colors.blue : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: Text(LanguageProvider.translate("global", "percentage"),
                              style:TextStyleClass.captionStyle(color: couponsOperationsProvider.isPercentage ? Colors.white : Colors.black) ,),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          couponsOperationsProvider.setIsPercentage(false);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: couponsOperationsProvider.isPercentage ? Colors.grey.shade200 : Colors.blue,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: Text(LanguageProvider.translate("global", "fixed"),
                              style:TextStyleClass.captionStyle(color: couponsOperationsProvider.isPercentage ?  Colors.black:Colors.white ) ,),
                          ),
                        ),
                      ),
                    ),
                  ],),
                  SizedBox(height: 1.h,),
                  ListTextFieldWidget(inputs: couponsOperationsProvider.addCouponsInputs),
                  SizedBox(height: 1.h,),
                  const CouponStoresSelectWidget(),
                ],
              ),
            ),
          ),
          SizedBox(height: 1.h,),
          Row(
            children: [
              Expanded(
                child: ButtonWidget(onTap: (){
                  if(couponsOperationsProvider.formKey.currentState!.validate()
                  && couponsOperationsProvider.listStores.isNotEmpty){
                    if(couponsOperationsProvider.id !=null){
                      couponsOperationsProvider.updateCoupons();
                    }else{
                      couponsOperationsProvider.addCoupons();
                    }
                  }
                }, text: couponsOperationsProvider.id != null ? "update" : "add_coupon"),
              ),
              if(couponsOperationsProvider.id != null)...[
                SizedBox(width: 2.w,),
                Expanded(
                  child: ButtonWidget(onTap: (){
                    couponsOperationsProvider.reset();
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
