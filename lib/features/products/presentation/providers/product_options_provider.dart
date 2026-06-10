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
class ProductOptionsProvider extends ChangeNotifier implements DropDownClass<ProductOptionEntity> {
  ProductOptionEntity? productOptionEntity;
  List<ProductOptionEntity> productOptions = [];
  final ProductUseCase productUseCase;
  ProductOptionsProvider(this.productUseCase);

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

  Future getVendorProductsOption() async {
    clear();
    Either<DioException, List<ProductOptionEntity>> value = await productUseCase.getVendorProductsOption({});
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
    return productOptionEntity?.title ?? LanguageProvider.translate('global', 'product');
  }

  @override
  String labelTitle() {
    return LanguageProvider.translate("global", "select_product");
  }

  @override
  String displayedOptionName(ProductOptionEntity type) {
    return type.title;
  }

  @override
  Widget? displayedOptionWidget(ProductOptionEntity? type) {
    return null;
  }

  @override
  Widget? displayedWidget() {
    return null;
  }

  @override
  List<ProductOptionEntity> list() {
    return productOptions;
  }

  @override
  Future onTap(ProductOptionEntity? data) async {
    productOptionEntity = data;
    notifyListeners();
  }

  @override
  ProductOptionEntity? selected() {
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
