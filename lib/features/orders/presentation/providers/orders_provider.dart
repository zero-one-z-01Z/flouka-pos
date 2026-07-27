import 'package:flutter/material.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/models/pagination_class.dart';
import '../../domain/entity/order_entity.dart';
import '../../domain/use_case/order_use_case.dart';

class OrdersProvider extends ChangeNotifier implements PaginationClass{
  final OrderUseCase orderUseCase;

  OrdersProvider(this.orderUseCase);

  List<OrderEntity>? data;
  List<String> get tabs => [
    LanguageProvider.translate('global', 'new_orders'),
    LanguageProvider.translate('global', 'processing_orders'),
    LanguageProvider.translate('global', 'completed_orders'),
  ];
  Future getData() async {
    Map<String,dynamic> dataToUse = {};
    dataToUse['page'] = pageIndex;
    dataToUse['status[]'] = getOrdersByStatus();
    final result = await orderUseCase.getOrders(dataToUse);
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      pageIndex++;
      data ??= [];
      data!.addAll(r);
      if (r.isEmpty) paginationFinished = true;
      notifyListeners();
    });

    paginationStarted = false;
    notifyListeners();
  }

  late String selectedTab = tabs.first;

  void changeSelectedTab(String tab, {bool isHome = false}) {
    selectedTab = tab;
    if (isHome) {
      getHomeOrders();
    }else{
      refresh();
    }
    notifyListeners();
  }

  isSelectedTab(String tab) {
    return selectedTab == tab;
  }

  List<String> getOrdersByStatus() {
   if(selectedTab == tabs[0]){
     return [OrderStatus.pendingPayment.text,OrderStatus.paid.text, OrderStatus.paymentFailed.text];
   } else if(selectedTab == tabs[1]){
     return [OrderStatus.processing.text,OrderStatus.needsUserAction.text,];
   }
   return [OrderStatus.partiallyFulfilled.text,OrderStatus.fulfilled.text,
     OrderStatus.cancelled.text, OrderStatus.refunded.text];
  }

  ScrollController controller = ScrollController();

  void clear() {
    data = null;
    pageIndex = 1;
    paginationFinished = false;
    paginationStarted = false;
    notifyListeners();
  }

  Future refresh() async {
    clear();
    await getData();
  }
  @override
  int pageIndex = 1;

  @override
  bool paginationFinished =false;

  @override
  bool paginationStarted=false;

  @override
  void pagination() {
    controller.addListener(() async {
      if (controller.position.atEdge && controller.position.pixels > 10) {
        if (!paginationFinished && !paginationStarted && (data?.isNotEmpty ?? false)) {
          paginationStarted = true;
          await getData();
        }
      }
    });
  }

  List<OrderEntity>? homeOrders;
  Future getHomeOrders() async {
    Map<String,dynamic> dataToUse = {};
    homeOrders =null;
    notifyListeners();
    dataToUse['page']= 1;
    dataToUse['status[]'] = getOrdersByStatus();
    final result = await orderUseCase.getOrders(dataToUse);
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      homeOrders =[];
      homeOrders?.addAll(r);
      notifyListeners();

    });
  }

  void cancelOrderStatus(int id) {
    int? i = data?.indexWhere((element) => element.id == id) ?? -1;
    if (i != -1) {
      data?[i].status = OrderStatus.cancelled;
      data?[i].vendorOrders.status = VendorOrderStatus.cancelled;
      notifyListeners();
    }

    int? j = homeOrders?.indexWhere((element) => element.id == id)??-1;
    if (j != -1) {
      homeOrders?[j].status = OrderStatus.cancelled;
      homeOrders?[j].vendorOrders.status = VendorOrderStatus.cancelled;
      notifyListeners();
    }
  }

  void updateOrderStockStatus(int id) {
    int? i = data?.indexWhere((element) => element.id == id) ?? -1;
    if (i != -1) {
      data?[i].status = OrderStatus.processing;
      data?[i].vendorOrders.status = VendorOrderStatus.accepted;
      notifyListeners();
    }

    int? j = homeOrders?.indexWhere((element) => element.id == id)??-1;
    if (j != -1) {
      homeOrders?[j].status = OrderStatus.processing;
      homeOrders?[j].vendorOrders.status = VendorOrderStatus.accepted;
      notifyListeners();
    }
  }

  void updateOrderStatus({required VendorOrderStatus status,required int id , bool isPartiallyFulfilled = false}){
    int? i = data?.indexWhere((element) => element.id == id) ?? -1;
    if (i != -1) {
      data?[i].vendorOrders.status = status;
      if(status == VendorOrderStatus.delivered){
        if(isPartiallyFulfilled) {
          data?[i].status = OrderStatus.partiallyFulfilled;
        }else{
          data?[i].status = OrderStatus.fulfilled;
        }
      }
      notifyListeners();
    }

    int? j = homeOrders?.indexWhere((element) => element.id == id)??-1;
    if (j != -1) {
      homeOrders?[j].vendorOrders.status = status;
      if(status == VendorOrderStatus.delivered){
        if(isPartiallyFulfilled) {
          homeOrders?[j].status = OrderStatus.partiallyFulfilled;
        }else{
          homeOrders?[j].status = OrderStatus.fulfilled;
        }
      }
      notifyListeners();
    }
  }

}
