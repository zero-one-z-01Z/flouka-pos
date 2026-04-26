import 'package:flutter/material.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../domain/entity/order_entity.dart';
import '../../domain/use_case/order_use_case.dart';

class OrdersProvider extends ChangeNotifier {
  final OrderUseCase orderUseCase;

  OrdersProvider(this.orderUseCase);

  List<OrderEntity>? data;
  List<String> get tabs => [
    LanguageProvider.translate('global', 'all'),
    LanguageProvider.translate('global', 'new'),
    LanguageProvider.translate('global', 'ongoing'),
    LanguageProvider.translate('global', 'completed'),
  ];
  Future getData() async {
    final result = await orderUseCase.getOrders({});

    result.fold((l) => showToast(l.message ?? "Failed to load orders"), (r) {
      data = r;
      notifyListeners();
    });
  }

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

  List<String> get orederTypes => [
    LanguageProvider.translate('global', 'new_orders'),
    LanguageProvider.translate('global', 'ongoing_orders'),
    LanguageProvider.translate('global', 'completed_orders'),
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
