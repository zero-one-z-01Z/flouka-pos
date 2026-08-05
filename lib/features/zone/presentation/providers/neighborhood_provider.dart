import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/dialog/snack_bar.dart';
import '../../../../../core/models/drop_down_class.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entities/area_entity.dart';
import '../../domain/entities/neighborhood_entity.dart';
import '../../domain/usecase/city_usecase.dart';


class NeighborhoodProvider extends ChangeNotifier implements DropDownClass<NeighborhoodEntity> {
  NeighborhoodEntity? neighborhood;
  List<NeighborhoodEntity> neighborhoods = [];
  final CityUseCases areaUseCases;
  NeighborhoodProvider(this.areaUseCases);

  Map<dynamic, dynamic> validation() {
    return {
      'value': selected() == null,
      "text": LanguageProvider.translate("validation", "select_neighborhood_first"),
    };
  }

  void clear() {
    neighborhood = null;
    neighborhoods.clear();
    notifyListeners();
  }

  void setData(int? id) {
    if (id != null) {
      neighborhood = neighborhoods.firstWhere((element) => element.id == id);
    } else {
      neighborhood = null;
    }
    notifyListeners();
  }

  Future getNeighborhood({required int id, required bool fromAddress}) async {
    Map<String, dynamic> data = {};
    data['area_id'] = id;
    neighborhoods.clear();
    if (!fromAddress) loading();
    Either<DioException, List<NeighborhoodEntity>> value = await areaUseCases.getNeighborhoods(data);
    if (!fromAddress) navPop();
    value.fold(
      (l) async {
        showToast(l.message!);
      },
      (r) {
        neighborhoods = r;
        notifyListeners();
      },
    );
  }

  @override
  String displayedName() {
    return neighborhood?.name ?? LanguageProvider.translate('inputs', 'neighborhood');
  }

  @override
  String displayedOptionName(NeighborhoodEntity type) {
    return type.name;
  }

  @override
  Widget? displayedOptionWidget(NeighborhoodEntity? type) {
    return null;
  }

  @override
  Widget? displayedWidget() {
    return null;
  }

  @override
  List<NeighborhoodEntity> list() {
    return neighborhoods;
  }

  @override
  Future onTap(NeighborhoodEntity? data) async {
    neighborhood = data;
    // if (data != null) {
    //   Provider.of<PartsProvider>(
    //     Constants.globalContext(),
    //     listen: false,
    //   ).getParts(numbers: neighborhood!.id);
    // }
    notifyListeners();
  }

  @override
  NeighborhoodEntity? selected() {
    return neighborhood;
  }

  @override
  value() {
    return neighborhood?.id;
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
    return LanguageProvider.translate('inputs', 'neighborhood');
  }
}
