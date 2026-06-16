import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/models/drop_down_class.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../language/presentation/provider/language_provider.dart';

class AccountTypeProvider extends ChangeNotifier implements DropDownClass<String> {
  String type = 'company';
  List<String> types = ['company','individual'];

  Map<dynamic, dynamic> validation() {
    return {
      'value': selected() == null,
      "text": LanguageProvider.translate("validation", "select_type_first"),
    };
  }

  void clear() {
    type = 'company';
    notifyListeners();
  }

  @override
  String displayedName() {
    return type!=null? LanguageProvider.translate('global', type) : LanguageProvider.translate('inputs', 'account_type');
  }

  @override
  String displayedOptionName(String type) {
    return LanguageProvider.translate('global', type);
  }

  @override
  Widget? displayedOptionWidget(String? type) {
    return null;
  }

  @override
  Widget? displayedWidget() {
    return null;
  }

  @override
  List<String> list() {
    return types;
  }

  @override
  Future onTap(String? data) async {
    if(data!=null){
      type = data;
    }
    notifyListeners();
  }

  @override
  String? selected() {
    return type;
  }

  @override
  value() {
    return type;
  }

  @override
  bool require() {
    return true;
  }

  @override
  String? titleName() {
    return null;
  }

  @override
  String labelTitle() {
    return LanguageProvider.translate("inputs", "account_type");
  }
}
