import 'package:flouka_pos/core/dialog/snack_bar.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../config/app_styles.dart';
import '../constants/constants.dart';
import '../helper_function/navigation.dart';
import '../models/drop_down_class.dart';
import '../widgets/button_widget.dart';
import '../widgets/drop_down_option_widget.dart';

Future showDropDownDialog(DropDownClass dropDownClass) async {
  dynamic selected = dropDownClass.selected();
  if(dropDownClass.list().isEmpty){
    showToast(LanguageProvider.translate('global', 'loading'));
    return ;
  }
  await showDialog(context: Constants.globalContext(), builder:(context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      content: InkWell(
        onTap: () {
          FocusScope.of(Constants.globalContext()).unfocus();
        },
        child: Container(
          width: 40.w,height: 60.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Text(dropDownClass.labelTitle(),style: TextStyleClass.normalStyle()),
                  ),
                  SizedBox(height: 3.h),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ...List.generate(dropDownClass.list().length, (index) {
                              dynamic data = dropDownClass.list()[index];
                              return Padding(
                                padding:  EdgeInsets.symmetric(vertical: 1.h),
                                child: DropDownOptionWidget(
                                  dropDownClass: dropDownClass,
                                  data: data,
                                  selected: selected,
                                  rebuild: () async {
                                    if (selected == data) {
                                      // selected = null;
                                    } else {
                                      selected = data;
                                    }
                                    // selected = data;
                                    dropDownClass.onTap(selected);
                                    setState(() {});
                                    navPop();
                                  },
                                ),
                              );
                            }),
                            SizedBox(height: 4.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  },);

}
