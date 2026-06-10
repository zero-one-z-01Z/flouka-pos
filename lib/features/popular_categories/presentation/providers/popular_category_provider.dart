import 'package:flouka_pos/features/story/domain/user_case/stories_use_case.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/dialog/success_dialog.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/models/provider_structure_model.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../../products/domain/entity/product_entity.dart';
import '../../domain/entity/popular_category_entity.dart';
import '../../domain/user_case/popular_category_use_case.dart';

class PopularCategoryProvider extends ChangeNotifier implements ProviderStructureModel<List<PopularCategoryEntity>> {
  final PopularCategoryUseCase popularCategoryUseCase;
  PopularCategoryProvider(this.popularCategoryUseCase);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  List<PopularCategoryEntity>? data;

  @override
  Map? inputs;


  ScrollController controller = ScrollController();

  @override
  void clear() {
    data = null;
    inputs = null;
    id = null;
    listProducts.clear();
    notifyListeners();
  }

  @override
  Future getData() async {
    Map<String, dynamic> dataToUse = {};
    final result = await popularCategoryUseCase.getPopularCategories(dataToUse);
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      data = [];
      data!.addAll(r);
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

  List<int> listProducts = [];
  void addToList({required int id }){
    if(listProducts.contains(id)){
      listProducts.remove(id);
    }else{
      listProducts.add(id);
    }
    notifyListeners();
  }

  int?id;
  void selectToEdit({required PopularCategoryEntity popularCategory}){
    id = popularCategory.id;
    listProducts.clear();
    for(var element in popularCategory.productsIds){
      listProducts.add(element);
    }
    notifyListeners();
  }

  Map<String, dynamic> prepareData() {
    Map<String,dynamic> data={};
    List<int> ids=[];
    data['popular_category_id'] = id;
    for(var element in listProducts){
      ids.add(element);
    }
    data['products_id[]']= ids;
    return data;
  }

  Future assignProductsToPopularCategories() async {
    loading();
    final result = await popularCategoryUseCase.assignProductsToPopularCategories(prepareData());
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      successDialog();
      int index = data!.indexWhere((element) => element.id == id);
      data![index].productsIds.clear();
      data![index].productsIds.addAll(listProducts);
      reset();
      notifyListeners();
    });
  }

  void reset() {
    id = null;
    listProducts.clear();
    notifyListeners();
  }

}
