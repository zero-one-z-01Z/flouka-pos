import 'package:flouka_pos/features/story/domain/user_case/stories_use_case.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/models/provider_structure_model.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../domain/entity/story_entity.dart';

class StoriesProvider extends ChangeNotifier implements ProviderStructureModel<List<StoryEntity>> {
  final StoriesUseCase storiesUseCase;
  StoriesProvider(this.storiesUseCase);

  @override
  List<StoryEntity>? data;

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
    final result = await storiesUseCase.getVendorStories(dataToUse);
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      data = [];
      data!.addAll(r);
      notifyListeners();
    });
  }

  void addStory(StoryEntity store) {
    data?.insert(0,store);
    notifyListeners();
  }

  void deleteStory(int id) {
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
