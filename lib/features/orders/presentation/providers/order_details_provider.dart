import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flutter/material.dart';

import '../../../../core/dialog/snack_bar.dart';
import '../../domain/entity/order_details_entity.dart';
import '../../domain/use_case/order_use_case.dart';
import '../views/order_details_view.dart';

class OrderDetailsProvider extends ChangeNotifier {
  final OrderUseCase orderUseCase;
  OrderDetailsProvider(this.orderUseCase);
  OrderDetailsEntity? orderDetailsEntity;

  void goToOrderDetailsView(int id) {
    getData(id);
    navP(const OrderDetailsView());
  }

  Future getData(int id) async {
    final result = await orderUseCase.getOrderDetails({'id': id});

    result.fold((l) => showToast(l.message ?? "Failed to load orders"), (r) {
      orderDetailsEntity = r;
      notifyListeners();
    });
  }
}
