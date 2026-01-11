import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../domain/entity/navigation_entity.dart';

class HomeProvider extends ChangeNotifier {
  void goToHomeView() {
    navPR(const HomeView());
  }

  bool isDrawerOpen = true;

  void toggleDrawer() {
    isDrawerOpen = !isDrawerOpen;
    notifyListeners();
  }

  List<NavigationEntity> navigationList = [
    NavigationEntity(title: "Overview", svgImage: Images.overView),
    NavigationEntity(title: "Products", svgImage: Images.products),
    NavigationEntity(title: "Settings", svgImage: Images.settings),
    NavigationEntity(title: "Orders", svgImage: Images.orders),
    NavigationEntity(title: "Performance", svgImage: Images.products),
    NavigationEntity(title: "Messages", svgImage: Images.messages),
  ];
  late NavigationEntity selectedNavigation = navigationList.first;
  void setSelectedNavigation(NavigationEntity navigation) {
    selectedNavigation = navigation;
    notifyListeners();
  }

  bool isSelected(NavigationEntity navigation) {
    return selectedNavigation.title == navigation.title;
  }
}
