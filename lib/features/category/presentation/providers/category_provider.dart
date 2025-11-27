import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  final List<String> categories = ["All", "Mobiles", "Headests", "Wearables"];

  late String selectedCategory = categories.first;

  void changeSelectedCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  isCategoryTab(String tab) {
    return selectedCategory == tab;
  }
}
