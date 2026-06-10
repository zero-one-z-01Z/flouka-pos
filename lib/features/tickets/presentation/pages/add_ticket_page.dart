import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/list_text_field_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/add_ticket_provider.dart';

class AddTicketPage extends StatelessWidget {
  AddTicketPage({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AddTicketProvider addTicketCubit =Provider.of(context);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(title: Text(LanguageProvider.translate("ticket","add_ticket"))),
        body: Form(
          key:formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(mainAxisSize:MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 2.h,),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: ListTextFieldWidget(inputs: addTicketCubit.ticketInputs,
                            style: TextStyleClass.normalStyle().copyWith(fontSize: 12.sp),
                            color:const Color(0xffEEEEEE),borderColor: Colors.transparent, ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Center(child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 1.w,vertical: 2.h),
                      child: ButtonWidget(onTap: (){
                        if(formKey.currentState!.validate()){
                          addTicketCubit.createTicket();
                        }
                      },borderRadius: 8,withShadow: false, text: "start_chat"),
                    ),
                  ),
                  if(addTicketCubit.isAddTicket)...[
                    SizedBox(width: 1.w,),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 1.w,vertical: 2.h),
                        child: ButtonWidget(onTap: (){
                          addTicketCubit.setIsAddTicket(false);
                        },borderRadius: 8,withShadow: false,color: Colors.red, text: "cancel"),
                      ),
                    ),
                  ],
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
