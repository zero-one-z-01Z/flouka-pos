import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/helper_function/loading.dart';
import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/features/orders/presentation/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/dialog/delete_item_dialog.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../chat/presentation/provider/message_provider.dart';
import '../../domain/entity/order_entity.dart';
import '../../domain/use_case/order_use_case.dart';
import '../views/order_details_view.dart';

class OrderDetailsProvider extends ChangeNotifier {
  final OrderUseCase orderUseCase;
  OrderDetailsProvider(this.orderUseCase);
  OrderEntity? orderEntity;

  void goToOrderDetailsView(int id) {
    orderEntity = null;
    MessageProvider messageProvider = Provider.of(Constants.globalContext(),listen: false);
    messageProvider.clear();
    getData(id);
    navP(const OrderDetailsView(),then: (val){
      MessageProvider messageProvider = Provider.of(Constants.globalContext(),listen: false);
      messageProvider.setIsShowChat(false);
    });
  }

  Future getData(int id) async {
    final result = await orderUseCase.getOrderDetails({'order_id': id});

    result.fold((l) => showToast(l.message ?? "Failed to load orders"), (r) {
      orderEntity = r;
      notifyListeners();
    });
  }

  void rebuild (){
    notifyListeners();
  }


  Future rejectOrder() async {
    loading();
    final result = await orderUseCase.rejectOrder({'order_id': orderEntity?.id});
    navPop();
    result.fold((l) => showToast(l.message ?? "Failed to load orders"), (r) {
      if(orderEntity !=null){
        rejectOrderDetails();
      }
      OrdersProvider ordersProvider = Provider.of(Constants.globalContext(),listen: false);
      ordersProvider.cancelOrderStatus(orderEntity!.id);

      notifyListeners();
    });
  }

  void rejectOrderDialog() {
    deleteDialog(
      msg: 'reject_order',
      onTap: (){
        navPop();
        rejectOrder();
      } ,
    );
  }

  Future updateVendorOrderStatus({required VendorOrderStatus status}) async {
    Map<String,dynamic> data = {};
    data['order_id'] =orderEntity?.id;
    data['status'] = status.text;
    loading();
    final result = await orderUseCase.updateVendorOrderStatus(data);
    navPop();
    result.fold((l) => showToast(l.message ?? "Failed to load orders"), (r) {
      if(orderEntity !=null){
        updateVendorStatus(status: status);
      }
      OrdersProvider ordersProvider = Provider.of(Constants.globalContext(),listen: false);
      ordersProvider.updateOrderStatus(status: status, id: orderEntity!.id, isPartiallyFulfilled: isPartiallyFulfilled());
      notifyListeners();
    });
  }

  bool isPartiallyFulfilled(){
    return orderEntity?.vendorOrders.items?.any((element) => element.status == OrderItemStatus.outOfStock) ?? false;
  }

  Future updateOrderStock() async {
    Map<String,dynamic> data = {};
    data['order_id'] =orderEntity?.id;
    for(int i = 0; i<(orderEntity?.vendorOrders.items?.length ?? 0); i++) {
      data['items[$i][id]'] =orderEntity?.vendorOrders.items?[i].id ;
      data['items[$i][quantity]'] =orderEntity?.vendorOrders.items?[i].changeableQuantity ;
    }
    loading();
    final result = await orderUseCase.updateOrderStock(data);
    navPop();
    result.fold((l) => showToast(l.message ?? "Failed to load orders"), (r) {
      OrdersProvider ordersProvider = Provider.of(Constants.globalContext(),listen: false);
      ordersProvider.updateOrderStockStatus(orderEntity!.id);
      if(orderEntity !=null){
        updateOrderStockDetails();
      }
      notifyListeners();
    });
  }

  bool canUpdateStock() {
    return (orderEntity?.status.isNew ??false) &&
    (orderEntity?.vendorOrders.status == VendorOrderStatus.pending ||
    orderEntity?.vendorOrders.status == VendorOrderStatus.outOfStock);
  }

  void rejectOrderDetails(){
    orderEntity?.status = OrderStatus.cancelled;
    orderEntity?.vendorOrders.status = VendorOrderStatus.cancelled;
    for(int k = 0; k < (orderEntity?.vendorOrders.items?.length ?? 0); k++) {
      orderEntity?.vendorOrders.items?[k].status = OrderItemStatus.cancelled;
    }
  }

  void updateOrderStockDetails(){
    orderEntity?.status = OrderStatus.processing;
    orderEntity?.vendorOrders.status = VendorOrderStatus.accepted;
    for(int k = 0; k < (orderEntity?.vendorOrders.items?.length ?? 0); k++) {
      if(orderEntity?.vendorOrders.items?[k].quantity == orderEntity?.vendorOrders.items?[k].changeableQuantity){
        orderEntity?.vendorOrders.items?[k].status = OrderItemStatus.confirmed;
      }else{
        orderEntity?.vendorOrders.items?[k].status = OrderItemStatus.outOfStock;
        orderEntity?.vendorOrders.items?[k].quantity = orderEntity?.vendorOrders.items?[k].changeableQuantity;
      }
    }
    notifyListeners();
  }

  void updateVendorStatus({required VendorOrderStatus status}){
    orderEntity?.vendorOrders.status = status;
    if(status == VendorOrderStatus.delivered){
      if(isPartiallyFulfilled()) {
        orderEntity?.status = OrderStatus.partiallyFulfilled;
      }else{
        orderEntity?.status = OrderStatus.fulfilled;
      }
    }
    for(int k = 0; k < (orderEntity?.vendorOrders.items?.length ?? 0); k++) {
      if(orderEntity?.vendorOrders.items?[k].status != OrderItemStatus.outOfStock){
        if(status == VendorOrderStatus.readyToShip){
          orderEntity?.vendorOrders.items?[k].status = OrderItemStatus.readyToShip;
        }else if(status == VendorOrderStatus.shipped){
          orderEntity?.vendorOrders.items?[k].status = OrderItemStatus.shipped;
        }else if(status == VendorOrderStatus.delivered){
          orderEntity?.vendorOrders.items?[k].status = OrderItemStatus.delivered;
        }
      }
      notifyListeners();
    }

    notifyListeners();
  }

  bool canUpdateStatus() {
    return (orderEntity?.vendorOrders.status == VendorOrderStatus.accepted ||
            orderEntity?.vendorOrders.status == VendorOrderStatus.processing ||
        orderEntity?.vendorOrders.status == VendorOrderStatus.readyToShip||
        orderEntity?.vendorOrders.status == VendorOrderStatus.shipped);
  }

  Map<String,dynamic> buttonMap(){
    VendorOrderStatus status = orderEntity!.vendorOrders.status;
    if(status == VendorOrderStatus.accepted){
      return {
        'title': 'order_processing',
        'onTap': (){
          updateVendorOrderStatus(status: VendorOrderStatus.processing);
        },
      };
    }else if(status == VendorOrderStatus.processing){
      return {
        'title': 'order_ready_to_ship',
        'onTap': (){
          updateVendorOrderStatus(status: VendorOrderStatus.readyToShip);
        },
      };
    }
    // else if(status == VendorOrderStatus.readyToShip){
    //   return {
    //     'title': 'order_shipped',
    //     'onTap': (){
    //       updateVendorOrderStatus(status: VendorOrderStatus.shipped);
    //     },
    //   };
    // }else if(status == VendorOrderStatus.shipped){
    //   return {
    //     'title': 'order_delivered',
    //     'onTap': (){
    //       updateVendorOrderStatus(status: VendorOrderStatus.delivered);
    //     },
    //   };
    // }
    else{
      return {};
    }
  }


}
