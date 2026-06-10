import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/widgets/empty_animation.dart';
import '../../../../core/widgets/loading_animation_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/svg_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/add_ticket_provider.dart';
import '../provider/ticket_message_provider.dart';
import '../provider/tickets_provider.dart';
import '../widgets/ticket_widget.dart';
import 'add_ticket_page.dart';
import 'ticket_message_page.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});
  @override
  Widget build(BuildContext context) {
    TicketsProvider ticketsProvider = Provider.of(context);
    TicketMessageProvider ticketMessageProvider = Provider.of(context);
    AddTicketProvider addTicketProvider = Provider.of(context);
    ticketsProvider.pagination();
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        // appBar: AppBar(title: Text(LanguageProvider.translate("ticket","support_ticket")),),
        body: SizedBox(width: double.infinity,height:double.infinity,
          child: Row(
            children: [
              Expanded(flex: 2,
                child: SingleChildScrollView(
                  controller: ticketsProvider.controller,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Builder(builder: (context) {
                        if(ticketsProvider.tickets ==null){
                          return Center(child: LoadingAnimationWidget(gif: Lotties.chats, width: 40.w, height:50.h,topPadding: 0,));
                        }else if(ticketsProvider.tickets!.isEmpty){
                          return Center(child: EmptyAnimation(title: "no_ticket",gif: Lotties.noSearch,width: 20.w,));
                        }
                        return Row(
                          children: [
                            Expanded(flex:3,
                              child: Container(height: 200.h,
                                padding:  EdgeInsets.symmetric(horizontal: 1.w),
                                child: SingleChildScrollView(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 2.h,),
                                      Wrap(runSpacing: 0.5.h, children:List.generate(ticketsProvider.tickets!.length,
                                          (index) => TicketWidget(ticket: ticketsProvider.tickets![index],))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },),
                      SizedBox(height: 3.h,),
                      if(ticketsProvider.paginationStarted) const LoadingWidget(),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 1.w,),
              if(addTicketProvider.isAddTicket && !ticketMessageProvider.isShowTicket)
              Expanded(child: AddTicketPage()),
              if(!addTicketProvider.isAddTicket && ticketMessageProvider.isShowTicket)
                const Expanded(flex: 1,child:  TicketMessagePage()),

            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton:ticketsProvider.tickets !=null &&
            (!addTicketProvider.isAddTicket && !ticketMessageProvider.isShowTicket)  ?
        Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                Provider.of<AddTicketProvider>(context,listen: false).goToAddTicketPage();
              },
              child: Container(padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
                margin: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w,),
                decoration:const BoxDecoration(
                    image: DecorationImage(image: AssetImage(Images.addTicket,),fit:BoxFit.contain)
                ),
                child: Row(
                  children: [
                    SizedBox(width: 1.w,),
                    SvgWidget(svg: Images.addIcon,width: 2.w,),
                    SizedBox(width: 1.w,),
                    Text(LanguageProvider.translate("ticket","add_ticket"),
                      style: TextStyleClass.normalStyle(color: Colors.white),),
                    SizedBox(width: 1.w,),
                  ],
                ),
              ),
            ),
          ],
        ) : const SizedBox(),
      ),
    );
  }
}
