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
import '../../domain/entity/product_entity.dart';
import '../../domain/user_case/product_use_case.dart';
class TagsOptionsProvider extends ChangeNotifier implements DropDownClass<TagEntity> {
  TagEntity? productOptionEntity;
  List<TagEntity> productOptions = [];
  final ProductUseCase productUseCase;
  TagsOptionsProvider(this.productUseCase);

  Map<dynamic, dynamic> validation() {
    return {
      'value': selected() == null,
      "text": LanguageProvider.translate("validation", "select_city_first"),
    };
  }

  void clear() {
    productOptionEntity = null;
    productOptions.clear();
    notifyListeners();
  }

  Future getTags() async {
    clear();
    Either<DioException, List<TagEntity>> value = await productUseCase.getTags({});
    value.fold(
          (l) async {
        showToast(l.message!);
      }, (r) {
      productOptions = r;
      notifyListeners();
    },
    );
  }

  @override
  String displayedName() {
    return productOptionEntity?.name ?? LanguageProvider.translate('global', 'product');
  }

  @override
  String labelTitle() {
    return LanguageProvider.translate("global", "select_product");
  }

  @override
  String displayedOptionName(TagEntity type) {
    return type.name;
  }

  @override
  Widget? displayedOptionWidget(TagEntity? type) {
    return null;
  }

  @override
  Widget? displayedWidget() {
    return null;
  }

  @override
  List<TagEntity> list() {
    return productOptions;
  }

  @override
  Future onTap(TagEntity? data) async {
    productOptionEntity = data;
    notifyListeners();
  }

  @override
  TagEntity? selected() {
    return productOptionEntity;
  }

  @override
  value() {
    return productOptionEntity?.id;
  }

  @override
  bool require() {
    return true;
  }

  @override
  String? titleName() {
    return null;
  }
}
