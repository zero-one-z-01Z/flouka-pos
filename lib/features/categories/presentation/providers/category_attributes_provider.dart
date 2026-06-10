import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/models/provider_structure_model.dart';
import '../../domain/entity/category_attributes_entity.dart';
import '../../domain/usecases/category_usecase.dart';

class CategoryAttributesProvider extends ChangeNotifier implements ProviderStructureModel<List<CategoryAttributesEntity>>{

  final CategoryUsecase categoryUsecase;
  CategoryAttributesProvider(this.categoryUsecase);

  @override
  List<CategoryAttributesEntity>? data;

  @override
  Map? inputs;

  String? categoryId;
  @override
  void clear() {
    data = null;
    notifyListeners();
  }

  @override
  Future getData() async {
    Map<String, dynamic> dataToUse = {
      'category_id': categoryId,
    };

    final result = await categoryUsecase.getCategoryAttributes(dataToUse);
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      data= r;
      notifyListeners();
    });

  }

  List<Map<String,dynamic>> CategoryAttributesNames(int index){
    if(data ==null || (data!=null && data!.isEmpty)){
      return [];
    }
    return List.generate(data![index].values.length, (i){
      return {'name':data![index].values[i].value,'id':data![index].values[i].id};
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

  Future setCategory(String? categoryId) async {
    this.categoryId = categoryId;
    loading();
    await refresh();
    navPop();
  }
}