import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/core/widgets/checkbox_widget.dart';
import 'package:flouka_pos/features/coupons/presentation/providers/coupons_operations_provider.dart';
import 'package:flouka_pos/features/vendor_stores/presentation/providers/store_operations_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_styles.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../vendor_stores/presentation/providers/store_options_provider.dart';

class StoresOptionsWidget extends StatelessWidget {
  const StoresOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    StoreOptionsProvider storeOptionsProvider =Provider.of(context);
    CouponsOperationsProvider couponsOperationsProvider=Provider.of(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  runSpacing: 1.h,
                  children: List.generate(storeOptionsProvider.data!.length, (index) {
                    bool isSelected =couponsOperationsProvider.listStores.contains(storeOptionsProvider.data![index]);
                    return Row(
                      children: [
                        Text(storeOptionsProvider.data![index].name,style: TextStyleClass.captionStyle(),),
                        const Spacer(),
                        CheckBoxWidget(check: isSelected, onChange: (value) {
                          couponsOperationsProvider.addToList(store: storeOptionsProvider.data![index]);
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
