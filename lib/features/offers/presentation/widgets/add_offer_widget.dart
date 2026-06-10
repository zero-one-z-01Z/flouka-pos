import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/core/widgets/list_text_field_widget.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../providers/offers_operations_provider.dart';
import 'offer_product_select_widget.dart';

class AddOfferWidget extends StatelessWidget {
  const AddOfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    OffersOperationsProvider offersOperationsProvider = Provider.of(context);
    return Form(
      key: offersOperationsProvider.formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 2.h,),
                  ListTextFieldWidget(inputs: offersOperationsProvider.addOffersInputs),
                  SizedBox(height: 1.h,),
                  const OfferProductSelectWidget(),
                ],
              ),
            ),
          ),
          SizedBox(height: 1.h,),
          Row(
            children: [
              Expanded(
                child: ButtonWidget(onTap: (){
                  if(offersOperationsProvider.formKey.currentState!.validate()
                  && offersOperationsProvider.listProducts.isNotEmpty){
                    if(offersOperationsProvider.id !=null){
                      offersOperationsProvider.updateOffers();
                    }else{
                      offersOperationsProvider.addOffers();
                    }
                  }
                }, text: offersOperationsProvider.id != null ? "update" : "add_offer"),
              ),
              if(offersOperationsProvider.id != null)...[
                SizedBox(width: 2.w,),
                Expanded(
                  child: ButtonWidget(onTap: (){
                    offersOperationsProvider.reset();
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
