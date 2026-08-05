import 'package:cached_network_image/cached_network_image.dart';
import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/widgets/empty_animation.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/withdraw_operations_provider.dart';
import '../providers/withdraw_provider.dart';
import '../widgets/add_withdraw_widget.dart';

class WithdrawView extends StatelessWidget {
  const WithdrawView({super.key});

  void _showImage(BuildContext context, String image) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: CachedNetworkImage(imageUrl: image, fit: BoxFit.contain),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final WithdrawProvider withdrawProvider = Provider.of<WithdrawProvider>(context,);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2,
              child: Builder(builder: (context) {
                if (withdrawProvider.data == null) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if (withdrawProvider.data!.isEmpty) {
                  return const Center(child: EmptyAnimation(title: "", gif: Lotties.noSearch));
                }
                return SingleChildScrollView(
                  controller: withdrawProvider.controller,
                  child: Wrap(
                    runSpacing: 2.w,
                    spacing: 2.w,
                    children: List.generate(withdrawProvider.data!.length, (index) {
                      final withdraw = withdrawProvider.data![index];
                      return Container(width: 20.w,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 1.h,
                          children: [
                            Text("${LanguageProvider.translate("inputs", "name")} : ${withdraw.name}",
                              maxLines: 1,
                              style: TextStyleClass.captionStyle(),),
                            Text("${LanguageProvider.translate("inputs", "amount")} : ${withdraw.amount}",
                              maxLines: 1,
                              style: TextStyleClass.captionStyle(),),
                            if (withdraw.paypal != null && withdraw.paypal!.isNotEmpty)
                              Text("Paypal : ${withdraw.paypal}",
                                maxLines: 1,
                                style: TextStyleClass.captionStyle(),),
                            if (withdraw.iban != null && withdraw.iban!.isNotEmpty)
                              Text("IBAN : ${withdraw.iban}",
                                maxLines: 1,
                                style: TextStyleClass.captionStyle(),),
                            Text(LanguageProvider.translate('global', withdraw.status),
                              style: TextStyleClass.captionStyle(color: AppColor.primaryColor),),
                            // if image != null show a "Show Image" button, otherwise leave empty
                            withdraw.image != null && withdraw.image!.isNotEmpty
                                ? InkWell(
                                    onTap: () => _showImage(context, withdraw.image!),
                                    child: Text(
                                      LanguageProvider.translate("global", "show_image"),
                                      style: TextStyleClass.captionStyle(color: AppColor.primaryColor),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
            if (withdrawProvider.data != null)
              const Expanded(child: AddWithdrawWidget()),
          ],
        ),
      ),
    );
  }
}
