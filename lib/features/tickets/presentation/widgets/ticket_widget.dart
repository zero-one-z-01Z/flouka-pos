import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/helper_function/convert.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entities/ticket_entity.dart';
import '../provider/ticket_message_provider.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({super.key, required this.ticket,});
  final TicketEntity ticket;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Provider.of<TicketMessageProvider>(context,listen: false).goToMessagePage(selectedChatEntity: ticket,);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical:2.h,horizontal: 1.w),
        margin: EdgeInsets.symmetric(vertical:1.h,horizontal: 2.w),
        decoration: BoxDecoration(
          color: const Color(0xffF4F1F1),borderRadius: BorderRadius.circular(8)
        ),
        child:  Row(mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LanguageProvider.translate("ticket", "ticket_number").replaceFirst("*id*", "${ticket.id}"),maxLines: 1,
                  style: TextStyleClass.normalStyle().copyWith(fontSize: 11.sp),
                ),
                SizedBox(height: 0.5.h,),
                Text(LanguageProvider.translate("ticket", "ticket_category").replaceFirst("*cat*", ticket.ticketCategory?.name??""),
                  maxLines: 1,style: TextStyleClass.normalStyle(color:const Color(0xff727272)).copyWith(fontSize: 11.sp),),
                SizedBox(height: 0.5.h,),
                Text(LanguageProvider.translate("ticket", "ticket_date").replaceFirst("*date*", convertDateTimeToStringDMY(ticket.createdAt)),
                  maxLines: 1,style: TextStyleClass.normalStyle(color:const Color(0xff727272)).copyWith(fontSize: 11.sp),),
              ],
            ),
            const SizedBox(width: 20,),
            Column(crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(padding: EdgeInsets.symmetric(horizontal:2.w,vertical: 0.5.h),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),
                    color:const Color(0xffFF5F00).withAlpha((0.39*255).round())
                  ),
                  child: Text(LanguageProvider.translate("ticket", ticket.status),maxLines: 1,
                    style: TextStyleClass.normalStyle().copyWith(height: 1,fontSize: 11.sp),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}