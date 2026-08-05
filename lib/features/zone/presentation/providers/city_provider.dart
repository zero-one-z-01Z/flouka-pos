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
import '../../domain/entities/city_entity.dart';
import '../../domain/usecase/city_usecase.dart';
import 'area_provider.dart';
import 'neighborhood_provider.dart';

class CityProvider extends ChangeNotifier implements DropDownClass<CityEntity> {
  CityEntity? cityEntity;
  CityEntity? getLatLngCityEntity;
  List<CityEntity> cities = [];
  final CityUseCases cityUseCases;
  CityProvider(this.cityUseCases);

  Map<dynamic, dynamic> validation() {
    return {
      'value': selected() == null,
      "text": LanguageProvider.translate("validation", "select_city_first"),
    };
  }

  void clear() {
    cityEntity = null;
    // cities.clear();
    notifyListeners();
  }

  Future getCities() async {
    cities.clear();
    Either<DioException, List<CityEntity>> value = await cityUseCases.getCities();
    value.fold(
      (l) async {
        showToast(l.message!);
      },
      (r) {
        cities = r;
        notifyListeners();
      },
    );
  }

  @override
  String displayedName() {
    return cityEntity?.name ?? LanguageProvider.translate('inputs', 'cities');
  }

  @override
  String displayedOptionName(CityEntity type) {
    return type.name;
  }

  @override
  Widget? displayedOptionWidget(CityEntity? type) {
    return null;
  }

  @override
  Widget? displayedWidget() {
    return null;
  }

  @override
  List<CityEntity> list() {
    return cities;
  }

  @override
  Future onTap(CityEntity? data) async {
    cityEntity = data;
    AreaProvider areaProvider= Provider.of<AreaProvider>(Constants.globalContext(), listen: false,);
    areaProvider.areaEntity = null;
    NeighborhoodProvider neighborhoodProvider= Provider.of(Constants.globalContext(), listen: false,);
    neighborhoodProvider.neighborhood = null;
    if (data != null) {
      areaProvider.getArea(id: cityEntity!.id,fromAddress: false);
    }
    log(data!.id.toString());
    notifyListeners();
  }

  @override
  CityEntity? selected() {
    return cityEntity;
  }

  @override
  value() {
    return cityEntity?.id;
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
    return LanguageProvider.translate('inputs', 'cities');
  }
}
