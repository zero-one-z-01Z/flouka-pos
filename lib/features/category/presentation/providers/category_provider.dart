import 'package:flutter/material.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';

class CategoryProvider extends ChangeNotifier {
  List<String> get categories => [
    LanguageProvider.translate('global', 'all'),
    LanguageProvider.translate('global', 'mobiles'),
    LanguageProvider.translate('global', 'headsets'),
    LanguageProvider.translate('global', 'wearables'),
  ];

  late String selectedCategory = categories.first;

  void changeSelectedCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  isCategoryTab(String tab) {
    return selectedCategory == tab;
  }
}
