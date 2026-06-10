import 'package:flouka_pos/features/story/domain/user_case/stories_use_case.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/models/provider_structure_model.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../domain/entity/coupon_entity.dart';
import '../../domain/user_case/coupons_use_case.dart';

class CouponsProvider extends ChangeNotifier implements ProviderStructureModel<List<CouponEntity>> {
  final CouponsUseCase storiesUseCase;
  CouponsProvider(this.storiesUseCase);

  @override
  List<CouponEntity>? data;

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
    final result = await storiesUseCase.getVendorCoupons(dataToUse);
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      data = [];
      data!.addAll(r);
      notifyListeners();
    });
  }

  void addCoupon(CouponEntity coupon) {
    data?.add(coupon);
    notifyListeners();
  }

  void updateCoupon(CouponEntity coupon) {
    final index = data?.indexWhere((element) => element.id == coupon.id) ?? -1;

    if (index != -1) {
      data![index] = coupon;
      notifyListeners();
    }
  }

  void deleteCoupon(int id) {
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
