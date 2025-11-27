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

  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  final List<String> orederTypes = [
    'New Orders',
    'Ongoing Orders',
    'Completed Orders',
  ];
  Alignment getAlignment() {
    if (currentIndex == 2) {
      return Alignment.centerRight;
    } else if (currentIndex == 0) {
      return Alignment.centerLeft;
    } else {
      return Alignment.center;
    }
  }
}
