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
import '../../domain/usecase/city_usecase.dart';
import 'neighborhood_provider.dart';


class AreaProvider extends ChangeNotifier implements DropDownClass<AreaEntity> {
  AreaEntity? areaEntity;
  List<AreaEntity> areas = [];
  final CityUseCases areaUseCases;
  AreaProvider(this.areaUseCases);

  Map<dynamic, dynamic> validation() {
    return {
      'value': selected() == null,
      "text": LanguageProvider.translate("validation", "select_city_first"),
    };
  }

  void clear() {
    areaEntity = null;
    areas.clear();
    notifyListeners();
  }

  void setData(int? id) {
    if (id != null) {
      areaEntity = areas.firstWhere((element) => element.id == id);
    } else {
      areaEntity = null;
    }
    notifyListeners();
  }

  Future getArea({required int id, required bool fromAddress}) async {
    Map<String, dynamic> data = {};
    data['city_id'] = id;
    areas.clear();
    if (!fromAddress) loading();
    Either<DioException, List<AreaEntity>> value = await areaUseCases.getArea(data);
    if (!fromAddress) navPop();
    value.fold(
      (l) async {
        showToast(l.message!);
      },
      (r) {
        areas = r;
        notifyListeners();
      },
    );
  }

  @override
  String displayedName() {
    return areaEntity?.name ?? LanguageProvider.translate('inputs', 'areas');
  }

  @override
  String displayedOptionName(AreaEntity type) {
    return type.name;
  }

  @override
  Widget? displayedOptionWidget(AreaEntity? type) {
    return null;
  }

  @override
  Widget? displayedWidget() {
    return null;
  }

  @override
  List<AreaEntity> list() {
    return areas;
  }

  @override
  Future onTap(AreaEntity? data) async {
    areaEntity = data;
    if (data != null) {
      NeighborhoodProvider neighborhoodProvider= Provider.of(Constants.globalContext(), listen: false,);
      neighborhoodProvider.neighborhood = null;
      neighborhoodProvider.getNeighborhood(id: areaEntity!.id,fromAddress: false);
    }
    notifyListeners();
  }

  @override
  AreaEntity? selected() {
    return areaEntity;
  }

  @override
  value() {
    return areaEntity?.id;
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
    return LanguageProvider.translate('inputs', 'areas');
  }
}
