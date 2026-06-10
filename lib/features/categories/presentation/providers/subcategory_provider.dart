import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/models/drop_down_class.dart';
import 'package:flouka_pos/features/categories/presentation/providers/brands_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entity/category_entity.dart';

class SubcategoryProvider extends ChangeNotifier implements DropDownClass<CategoryEntity>{
  List<CategoryEntity> _subcategories = [];
  bool _isLoading = false;
  String? _error;
  CategoryEntity? _selectedSubcategory;
  CategoryEntity? selectedCategory;
  int? _categoryId;


  void reset(){
    _selectedSubcategory = null;
    notifyListeners();
  }
  List<CategoryEntity> get subcategories => _subcategories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  CategoryEntity? get selectedSubcategory => _selectedSubcategory;
  int? get categoryId => _categoryId;

  /// Loads subcategories from the parent category's children list.
  /// No API call needed — children come from the already-fetched hierarchical data.
  Future<void> getSubcategories(CategoryEntity category) async {
    _isLoading = true;
    _error = null;
    _categoryId = category.id;
    notifyListeners();
    selectedCategory = category;
    _subcategories = category.children ?? [];

    if (_subcategories.isNotEmpty && _selectedSubcategory == null) {
      _selectedSubcategory = null; // default = show all
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectSubcategory(CategoryEntity subcategory) {
    if (_selectedSubcategory?.name == subcategory.name) {
      _selectedSubcategory = null;
    } else {
      _selectedSubcategory = subcategory;
    }
    notifyListeners();
  }

  @override
  String labelTitle() {
    return LanguageProvider.translate("global", "select_subcategory");
  }

  Future<void> refresh(CategoryEntity category) async {
    _subcategories = [];
    _selectedSubcategory = null;
    _categoryId = null;
    await getSubcategories(category);
  }

  void clear() {
    _subcategories = [];
    _selectedSubcategory = null;
    _error = null;
    _isLoading = false;
    _categoryId = null;
    notifyListeners();
  }


  @override
  String displayedName() {
    return LanguageProvider.translate("global", selectedSubcategory?.name??"subcategory");
  }

  @override
  Widget? displayedWidget() {
    return null;
  }

  @override
  List<CategoryEntity> list() {
    return subcategories;
  }

  @override
  Future<dynamic> onTap(CategoryEntity? data) async{
    _selectedSubcategory = data;
    Provider.of<BrandsProvider>(Constants.globalContext(), listen: false).setCategory("${data?.id}");
    notifyListeners();
  }

  @override
  bool require() {
    return false;
  }

  @override
  CategoryEntity? selected() {
    return selectedSubcategory;
  }
  void setCategory(CategoryEntity category) {
    _selectedSubcategory = category;
    notifyListeners();
  }
  @override
  String? titleName() {
    return null;
  }

  @override
  value() {
    return selectedSubcategory?.id;
  }

  @override
  String displayedOptionName(CategoryEntity type) {
    return LanguageProvider.translate("global", type.name);
  }

  @override
  Widget? displayedOptionWidget(CategoryEntity type) {
    return null;
  }
}
