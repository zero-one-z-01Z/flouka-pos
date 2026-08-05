import 'package:flouka_pos/core/models/pagination_class.dart';
import 'package:flutter/material.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/models/provider_structure_model.dart';
import '../../domain/entity/withdraw_entity.dart';
import '../../domain/user_case/withdraw_use_case.dart';

class WithdrawProvider extends ChangeNotifier implements ProviderStructureModel<List<WithdrawEntity>>,
    PaginationClass {
  final WithdrawUseCase withdrawUseCase;
  WithdrawProvider(this.withdrawUseCase){
    pagination();
  }

  @override
  List<WithdrawEntity>? data;

  @override
  Map? inputs;

  ScrollController controller = ScrollController();

  @override
  void clear() {
    data = null;
    inputs = null;
    pageIndex = 1;
    paginationFinished = false;
    paginationStarted = false;
    notifyListeners();
  }

  @override
  Future getData() async {
    Map<String,dynamic> dataToUse = {};
    dataToUse['page'] = pageIndex;
    final result = await withdrawUseCase.getVendorWithdraws(dataToUse);
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

  void addWithdraw(WithdrawEntity withdraw) {
    data?.insert(0, withdraw);
    notifyListeners();
  }

  @override
  Future refresh() async {
    clear();
    await getData();
  }

  @override
  void goToPage([Map<String, dynamic>? inputs]) {}
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
}
