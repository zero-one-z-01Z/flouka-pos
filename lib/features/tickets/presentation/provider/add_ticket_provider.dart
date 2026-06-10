import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flouka_pos/features/tickets/presentation/provider/ticket_message_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/drop_down_dialog.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/dialog/success_dialog.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/text_form_field_validation.dart';
import '../../../../core/models/text_field_model.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/usecases/tickets_use_case.dart';
import '../pages/add_ticket_page.dart';
import 'important_ticket_values_provider.dart';
import 'tickets_category_provider.dart';
import 'tickets_provider.dart';

class AddTicketProvider extends ChangeNotifier{
  List<TextFieldModel> ticketInputs = [];

  void goToAddTicketPage(){
    TicketsCategoryProvider ticketsCategoryCubit = Provider.of(Constants.globalContext(),listen:false);
    TicketMessageProvider ticketMessageProvider = Provider.of(Constants.globalContext(),listen:false);
    ticketsCategoryCubit.getCategories();
    setIsAddTicket(true);
    ticketMessageProvider.setIsShowTicket(false);
    ticketInputs = [
      TextFieldModel(
        key: "ticket_category_id",
        controller: TextEditingController(),
        textInputType: TextInputType.phone,
        isLabel: true,
        // validator: (value) => validateProblem(value),
        onTap: (){
          TicketsCategoryProvider ticketsCategoryProvider = Provider.of(Constants.globalContext(),listen: false);
          showDropDownDialog(ticketsCategoryProvider);
        },
        label: "problem_type",readOnly: true,
        width: 350.w,
        next: true,
      ),
      TextFieldModel(
        key: "important",isLabel: true,
        controller: TextEditingController(),
        width: 350.w,
        textInputType: TextInputType.phone,
        // validator: (value) => validateEnterImportant(value),
        onTap: (){
          ImportantTicketValuesProvider importantTicketValuesProvider = Provider.of(Constants.globalContext(),listen:false);
          showDropDownDialog(importantTicketValuesProvider);
        },
        label: "important",readOnly: true,
        next: true,
      ),
      TextFieldModel(
        key: "reason_id",
        controller: TextEditingController(),
        textInputType: TextInputType.number,
        width: 350.w,isLabel: true,
        validator: (value) => null,
        label: "reason_id",
        next: true,
      ),
      TextFieldModel(
        key: "title",isLabel: true,
        controller: TextEditingController(),
        textInputType: TextInputType.text,
        // validator: (value) => validateTitle(value),
        width: 350.w,

        label: "title",
        next: true,
      ),
      TextFieldModel(
          key: "description",
          controller: TextEditingController(),
          label: "description",isLabel: true,
          width: 720.w,
          max: 6,
          min: 6, validator: (value) => validateDescription(value),
          next: false),
    ];
  }
  bool isAddTicket = false;
  void setIsAddTicket(bool value){
    isAddTicket = value;
    notifyListeners();
  }
  Future createTicket()async{
    Map<String,dynamic> data = {};
    loading();
    for(var element in ticketInputs){
      if(element.key=="ticket_category_id"){
        TicketsCategoryProvider ticketsCategoryProvider = Provider.of(Constants.globalContext(),listen:false);
        data['ticket_category_id'] = ticketsCategoryProvider.problemCategory?.id;

      }else if(element.key=="important"){
        ImportantTicketValuesProvider importantTicketValuesProvider = Provider.of(Constants.globalContext(),listen:false);
        data['${element.key}'] = importantTicketValuesProvider.important;
      }else{
        if(element.controller.text.isNotEmpty){
          data['${element.key}'] = element.controller.text;
        }
      }
    }
    Either<DioException,TicketEntity> value = await TicketsUseCase(sl()).createTicket(data);
    navPop();
    value.fold((l) {
      showToast(l.message??"");
    }, (r) async{
      TicketsProvider ticketsProvider = Provider.of(Constants.globalContext(),listen:false);
      ticketsProvider.tickets?.insert(0,r);
      ticketsProvider.rebuild();
      successDialog(then: (){
        for (var element in ticketInputs) {
          element.controller.clear();
        }
        setIsAddTicket(false);
      });
    notifyListeners();
    });
  }

}