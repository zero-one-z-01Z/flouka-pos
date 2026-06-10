import 'package:flouka_pos/core/models/drop_down_class.dart';
import 'package:flouka_pos/features/categories/presentation/providers/brands_provider.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../domain/entity/category_entity.dart';
import '../../domain/usecases/category_usecase.dart';
import 'subcategory_provider.dart';

class CategoryProvider extends ChangeNotifier implements DropDownClass<CategoryEntity>{
  final CategoryUsecase categoryUseCases;

  CategoryProvider(this.categoryUseCases);

  List<CategoryEntity> _categories = [];
  CategoryEntity? _selectedCategory;
  bool _isLoading = false;
  String? _error;
  void reset(){
    _selectedCategory = null;
    notifyListeners();
  }

  List<CategoryEntity> get categories => _categories;
  CategoryEntity? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Map<String,dynamic>> CategoriesNames(){
    return List.generate(categories.length, (index){
      return {'name':categories[index].name,'id':categories[index].id};
    });
  }

  List<Map<String,dynamic>> SubCategoriesNames({String? categoryId}){
    List<CategoryEntity> subCategories=categories.firstWhere((element) => element.id.toString()==categoryId,).children!;
    return List.generate(subCategories.length, (index){
      return {'name':subCategories[index].name,'id':subCategories[index].id};
    });
  }

  /// Static home navigation tiles (not from API)
  // List<CategoryEntity> homeCategories = [];

  Future<void> getCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await categoryUseCases.getCategories();

    response.fold(
      (failure) {
        _error = failure.message ?? 'Error loading categories';
        showToast(_error!);
      },
      (categoriesList) {
        _categories = categoriesList;
        if (_categories.isNotEmpty && _selectedCategory == null) {
          _selectedCategory = null; // default = show all
        }
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  void selectCategory(CategoryEntity category) {
    if (_selectedCategory?.id == category.id) {
      _selectedCategory = null;
    } else {
      _selectedCategory = category;
    }
    notifyListeners();
  }

  Future<void> refresh() async {
    _categories = [];
    _selectedCategory = null;
    _error = null;
    await getCategories();
  }

  void clear() {
    _categories = [];
    _selectedCategory = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  @override
  String labelTitle() {
    return LanguageProvider.translate("global", "select_category");
  }

  @override
  String displayedName() {
    return LanguageProvider.translate("global", _selectedCategory?.name??"category");
  }

  @override
  String displayedOptionName(CategoryEntity? type) {
    return LanguageProvider.translate("global", type?.name??"category");
  }

  @override
  Widget? displayedOptionWidget(CategoryEntity type) {
    return null;
  }

  @override
  Widget? displayedWidget() {
    return null;
  }

  @override
  List<CategoryEntity> list() {
  return categories;
  }

  @override
  Future<dynamic> onTap(CategoryEntity? data) async{
    _selectedCategory = data;
    Provider.of<SubcategoryProvider>(Constants.globalContext(), listen: false).refresh(data!);
    Provider.of<BrandsProvider>(Constants.globalContext(), listen: false).setCategory("${data.id}");
    notifyListeners();
  }

  @override
  bool require() {
    return false;
  }

  @override
  CategoryEntity? selected() {
    return _selectedCategory;
  }

  void setCategory(int id) {
    _selectedCategory = categories.firstWhere((element) => element.id == id);
    notifyListeners();
  }

  @override
  String? titleName() {
    return null;
  }

  @override
  value() {
    return _selectedCategory?.id;
  }




}
