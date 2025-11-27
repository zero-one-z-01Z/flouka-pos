import 'package:flutter/material.dart';

class OrdersProvider extends ChangeNotifier {
  final List<String> tabs = ['All', 'New', 'Ongoing', 'Completed'];

  late String selectedTab = tabs.first;

  void changeSelectedTab(String tab) {
    selectedTab = tab;
    notifyListeners();
  }

  isSelectedTab(String tab) {
    return selectedTab == tab;
  }
}
