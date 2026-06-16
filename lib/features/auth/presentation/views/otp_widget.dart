import 'package:flouka_pos/features/auth/presentation/providers/otp_provider.dart';
import 'package:flouka_pos/features/auth/presentation/widgets/otp_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_styles.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/register_provider.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.watch<OtpProvider>();
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LanguageProvider.translate("auth", "enter_otp_code"),style: TextStyleClass.smallStyle(),),
        SizedBox(height: 2.h,),
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (registerProvider.counter ==0) {
                        registerProvider.reSend();
                      }
                    },
                    child: AnimatedOpacity(
                      opacity:registerProvider.counter == 0? 1 : registerProvider.counter == 1?0:1,
                      duration: const Duration(milliseconds: 700),
                      child: Text(
                        " ${LanguageProvider.translate("global", "resend")}",
                        style: TextStyleClass.smallStyle(
                            color: registerProvider.counter == 0? AppColor.primaryColor : Colors.grey),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity:registerProvider.counter == 0? 1 : registerProvider.counter == 1?0:1,
                    duration: const Duration(milliseconds: 700),
                    child: Text(
                      '00:${registerProvider.counter.toString().padLeft(2, "0")}',
                      style: TextStyleClass.normalStyle(color: registerProvider.counter == 0?Colors.grey  :AppColor.primaryColor ),
                    ),
                  ),

                ],
              ),
            ),
            const Expanded(child: OtpFieldWidget()),
            SizedBox(width: 5.w,),
          ],
        ),
      ],
    );
  }
}
