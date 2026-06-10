import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/models/provider_structure_model.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../domain/entity/store_entity.dart';
import '../../domain/user_case/vendor_stores_use_case.dart';

class VendorStoresProvider extends ChangeNotifier implements ProviderStructureModel<List<StoreEntity>> {
  final VendorStoresUseCase productUseCase;
  VendorStoresProvider(this.productUseCase);

  @override
  List<StoreEntity>? data;

  @override
  Map? inputs;


  ScrollController controller = ScrollController();

  @override
  void clear() {
    data = null;
    inputs = null;
    notifyListeners();
  }

  @override
  Future getData() async {
    Map<String, dynamic> dataToUse = {};
    final result = await productUseCase.getVendorStores(dataToUse);
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      data = [];
      data!.addAll(r);
      notifyListeners();
    });
  }

  void addStore(StoreEntity store) {
    data?.add(store);
    notifyListeners();
  }

  void updateStore(StoreEntity store) {
    final index = data?.indexWhere((element) => element.id == store.id) ?? -1;

    if (index != -1) {
      data![index] = store;
      notifyListeners();
    }
  }

  void deleteStore(int id) {
    final index = data?.indexWhere((element) => element.id == id) ?? -1;

    if (index != -1) {
      data?.removeAt(index);
      notifyListeners();
    }
  }


  @override
  Future refresh() async {
    clear();
    await getData();
  }

  @override
  void goToPage([Map<String, dynamic>? inputs]) {

  }

}
