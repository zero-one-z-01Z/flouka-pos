import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/models/provider_structure_model.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../domain/entity/reel_entity.dart';
import '../../domain/user_case/reels_use_case.dart';

class ReelsProvider extends ChangeNotifier implements ProviderStructureModel<List<ReelEntity>> {
  final ReelsUseCases reelsUseCases;
  ReelsProvider(this.reelsUseCases);

  @override
  List<ReelEntity>? data;

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
    final result = await reelsUseCases.getVendorReels(dataToUse);
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      data = [];
      data!.addAll(r);
      notifyListeners();
    });
  }

  void addReel(ReelEntity store) {
    data?.insert(0,store);
    notifyListeners();
  }

  void deleteReel(int id) {
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
