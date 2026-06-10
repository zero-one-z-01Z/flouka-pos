import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/models/drop_down_class.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/usecases/tickets_use_case.dart';
import 'add_ticket_provider.dart';

class TicketsCategoryProvider extends ChangeNotifier implements DropDownClass{

  TicketProblemCategoryEntity? problemCategory;
  List<TicketProblemCategoryEntity>?categoriesList;
  Future getCategories() async {
    categoriesList= [];
    Map<String, dynamic> data = {};
    Either<DioException, List<TicketProblemCategoryEntity>> response = await TicketsUseCase(sl()).getTicketCategory(data);
    response.fold((l) {
      showToast(l.message??"");
    }, (r) {
      categoriesList ??=[];
      categoriesList?.addAll(r);
      notifyListeners();
    });
  }

  @override
  String displayedName() {
    return problemCategory?.name ?? "";
  }

  @override
  String displayedOptionName(type) {
    return type?.name??"";
  }

  @override
  Widget? displayedOptionWidget(type) {
    return null;
  }

  @override
  Widget? displayedWidget() {
    return null;
  }

  @override
  TicketProblemCategoryEntity? selected() {
    return problemCategory;
  }

  @override
  value() {
    return problemCategory?.id;
  }

  @override
  List list() {
    return categoriesList!;
  }

  @override
  Future onTap(data) async{
    problemCategory= data;
    AddTicketProvider addTicketCubit= Provider.of<AddTicketProvider>(Constants.globalContext(),listen: false);
    addTicketCubit.ticketInputs.firstWhere((element) => element.key=="ticket_category_id",)
        .controller.text = problemCategory?.name??"";
    notifyListeners();
  }

  @override
  bool require() {
    return false;
  }

  @override
  String? titleName() {
    return "";
  }

  @override
  String labelTitle() {
    return "";
  }


}