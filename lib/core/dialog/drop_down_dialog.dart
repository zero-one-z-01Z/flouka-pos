import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../helper_function/navigation.dart';
import '../models/drop_down_class.dart';
import '../widgets/button_widget.dart';
import '../widgets/drop_down_option_widget.dart';

Future showDropDownDialog(DropDownClass dropDownClass) async {
  dynamic selected = dropDownClass.selected();
  await showModalBottomSheet(
    context: Constants.globalContext(),
    backgroundColor: Colors.white.withValues(alpha: 0.8),
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    builder: (context) {
      return InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: 100.w,
          constraints: BoxConstraints(maxHeight: 45.h, minHeight: 45.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 7.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 3.h),
                          ...List.generate(dropDownClass.list().length, (index) {
                            dynamic data = dropDownClass.list()[index];
                            return DropDownOptionWidget(
                              dropDownClass: dropDownClass,
                              data: data,
                              selected: selected,
                              rebuild: () {
                                if (selected == data) {
                                  // selected = null;
                                } else {
                                  selected = data;
                                }
                                // selected = data;
                                setState(() {});
                              },
                            );
                          }),
                          SizedBox(height: 4.h),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 2.h,
                    left: 5.w,
                    right: 5.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWidget(
                          onTap: () async {
                            navPop();
                            await dropDownClass.onTap(selected);
                          },
                          text: 'save',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
}
