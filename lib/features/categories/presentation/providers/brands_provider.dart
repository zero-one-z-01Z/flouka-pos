import 'package:flouka_pos/core/models/drop_down_class.dart';
import 'package:flouka_pos/features/categories/domain/usecases/category_usecase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/models/provider_structure_model.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entity/brand_entity.dart';

class BrandsProvider extends ChangeNotifier implements ProviderStructureModel<List<BrandEntity>> ,DropDownClass<BrandEntity>{

  final CategoryUsecase categoryUsecase;
  BrandsProvider(this.categoryUsecase);
  BrandEntity? _selectedBrand;
  BrandEntity? get selectedBrand => _selectedBrand;
  @override
  List<BrandEntity>? data;

  @override
  Map? inputs;

  void reset(){
    _selectedBrand = null;
    notifyListeners();
  }
  String? categoryId;
  @override
  void clear() {
    data = null;
    notifyListeners();
  }

  List<Map<String,dynamic>> BrandsNames(){
    return List.generate(data?.length??0, (index){
      return {'name':data![index].name,'id':data![index].id};
    });
  }

  @override
  Future getData() async {
    Map<String, dynamic> dataToUse = {
      'category_id': categoryId,
    };

    final result = await categoryUsecase.getCategoryBrands(dataToUse);
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      data= r;
      notifyListeners();
    });

  }

  @override
  Future refresh() async {
    clear();
    await getData();
  }

  @override
  void goToPage([Map<String, dynamic>? inputs]) {

  }

  void setBrand(BrandEntity brand) {
    _selectedBrand = brand;
    notifyListeners();
  }

  Future setCategory(String? categoryId) async {
    _selectedBrand=null;
    this.categoryId = categoryId;
    loading();
    await refresh();
    navPop();
  }

  @override
  String labelTitle() {
    return LanguageProvider.translate("global", "select_brand");
  }

  @override
  String displayedName() {
    return LanguageProvider.translate("global", selected()?.name??"brand");
  }

  @override
  String displayedOptionName(BrandEntity? type) {
    return LanguageProvider.translate("global", type?.name??"brand");
  }

  @override
  Widget? displayedOptionWidget(BrandEntity type) {
    return null;
  }

  @override
  Widget? displayedWidget() {
    return null;
  }

  @override
  List<BrandEntity> list() {
    return data??[];
  }

  @override
  Future<dynamic> onTap(BrandEntity? data) async{
    _selectedBrand = data;
    notifyListeners();
  }

  @override
  bool require() {
    return false;
  }

  @override
  BrandEntity? selected() {
    return _selectedBrand;
  }

  @override
  String? titleName() {
    return null;
  }

  @override
  value() {
    return _selectedBrand?.id;
  }
}