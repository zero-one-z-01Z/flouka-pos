import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/home_provider.dart';
import 'info_card_widget.dart';

class InfoGridWidget extends StatelessWidget {
  const InfoGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of(context);
    final HomeProvider homeProvider = Provider.of(context, listen: false);
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: const Border(
          bottom: BorderSide(color: Color(0xffE7ECF3)),
        ),
      ),
      child: GridView.count(
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 1.w,
        mainAxisSpacing: 1.h,
        childAspectRatio: 4,
        children: List.generate(authProvider.infoCards.length, (index) {
          final card = authProvider.infoCards[index];
          return GestureDetector(
            onTap: () {
              if(card.onTap !=null){
                card.onTap!();
              }
              },
            child: InfoCardWidget(infoCardEntity: card),
          );
        }),
      ),
    );
  }
}
