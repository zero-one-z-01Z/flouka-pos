import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/models/pagination_class.dart';
import 'package:flouka_pos/features/auth/domain/entities/user_entity.dart';
import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/models/provider_structure_model.dart';
import '../../domain/entity/wallet_operation_entity.dart';
import '../../domain/user_case/wallet_use_case.dart';

class WalletProvider extends ChangeNotifier implements ProviderStructureModel<List<WalletOperationEntity>>,PaginationClass {
  final WalletUseCase walletUseCase;
  WalletProvider(this.walletUseCase){
    pagination();
  }

  @override
  List<WalletOperationEntity>? data;

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
    final result = await walletUseCase.getWalletOperations(dataToUse);
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

  WalletSummaryEntity get wallet {
   AuthProvider authProvider = Constants.globalContext().read();
   UserEntity userEntity = authProvider.userEntity!;
   return userEntity.vendorStatistics!.wallet!;
  }

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
