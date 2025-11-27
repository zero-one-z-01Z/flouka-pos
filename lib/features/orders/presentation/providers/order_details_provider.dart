import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flutter/material.dart';

import '../views/order_details_view.dart';

class OrderDetailsProvider extends ChangeNotifier {
  void goToOrderDetailsView() {
    navP(const OrderDetailsView());
  }
}
