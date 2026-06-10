import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/models/drop_down_class.dart';
import '../../../language/presentation/provider/language_provider.dart';
import 'add_ticket_provider.dart';

class ImportantTicketValuesProvider extends ChangeNotifier implements DropDownClass{

  String important = "low";
  List<String>importantList = ["high","medium","low"];

  @override
  String displayedName() {
    return LanguageProvider.translate("ticket",important);
  }

  @override
  String displayedOptionName(type) {
    return LanguageProvider.translate("ticket",type);
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
  String? selected() {
    return important;
  }

  @override
  value() {
    return important;
  }

  @override
  List list() {
    return importantList;
  }

  @override
  Future onTap(data) async{
    important= data;
    AddTicketProvider addTicketCubit= Provider.of(Constants.globalContext(),listen: false);
    addTicketCubit.ticketInputs.firstWhere((element) => element.key=="important",).controller.text =
        LanguageProvider.translate("ticket",important);
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