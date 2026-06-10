import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/dialog/success_dialog.dart';
import 'package:flouka_pos/core/helper_function/loading.dart';
import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/core/helper_function/text_form_field_validation.dart';
import 'package:flouka_pos/core/models/text_field_model.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/products/presentation/providers/product_options_provider.dart';
import 'package:flouka_pos/features/products/presentation/views/add_variant_view.dart';
import 'package:flouka_pos/features/story/domain/user_case/stories_use_case.dart';
import 'package:flouka_pos/features/vendor_stores/domain/user_case/vendor_stores_use_case.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/dialog/delete_item_dialog.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/image.dart';
import '../../../../core/helper_function/location.dart';
import '../../domain/entity/story_entity.dart';
import '../widgets/add_story_widget.dart';
import 'stories_provider.dart';

class StoriesOperationsProvider extends ChangeNotifier {
  List<TextFieldModel> addStoreInputs = [];
  final formKey = GlobalKey<FormState>();
  StoriesUseCase storiesUseCase;
  StoriesOperationsProvider(this.storiesUseCase);
  void addTextField() {
    addStoreInputs = [
      TextFieldModel(key: "title",
          hint: "title",
          label: "story_title",
          validator: (value) =>validateTitle(value),
          controller: TextEditingController(),
     ),
    ];
  }


  Future<Map<String, dynamic>> prepareData() async{
    ProductOptionsProvider productOptionsProvider = Provider.of(Constants.globalContext(),listen: false);
    Map<String,dynamic> data={};
    for(var element in addStoreInputs){
      if(element.key !="confirm_password"){
        data[element.key]=element.controller.text;
      }
    }
    data['image'] = await MultipartFile.fromFile(storyImage!.path);
    data['product_id'] = productOptionsProvider.productOptionEntity?.id;
    return data;
  }

  Future addStore() async {
    loading();
    Map<String,dynamic> dataToUse=await prepareData();
    final result = await storiesUseCase.createStory(dataToUse);
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      navPop();
      StoriesProvider storiesProvider = Provider.of(Constants.globalContext(),listen: false);
      storiesProvider.addStory(r);
      successDialog();
      notifyListeners();
    });
  }

  void clear(){
    for(var element in addStoreInputs){
      element.controller.clear();
    }
    storyImage = null;
    ProductOptionsProvider productOptionsProvider = Provider.of(Constants.globalContext(),listen: false);
    productOptionsProvider.productOptionEntity = null;

  }

  Future deleteStore({required int id}) async {
    Map<String, dynamic> data = {};
    data["story_id"] = id;
    loading();
    final result = await storiesUseCase.deleteStory(data);
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      navPop();
      StoriesProvider storiesProvider = Provider.of(Constants.globalContext(),listen: false);
      storiesProvider.deleteStory(id);
      successDialog();
      notifyListeners();
    });
  }

  void showAddWidget() {
    clear();
    showDialog(
      context: Constants.globalContext(),
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: SizedBox(
              width: 25.w,
              height: 65.h,
              child: const AddStoryWidget()),
        );
      },
    );
  }

  void deleteStory({required int id}) {
    deleteDialog(onTap: () => deleteStore(id: id),msg: "delete_story");
  }

  XFile? storyImage;
  bool storyUpdated = false;
  showLogoImage() {
      if (storyImage != null) {
        return FileImage(File(storyImage!.path));
    } else {
      return const AssetImage(Images.floukaLogo);
    }
  }

  Future selectStoryImage() async {
    FocusScope.of(Constants.globalContext()).unfocus();
    XFile? image = await chooseImage();
    if (image != null) {
      updateLogo(image);
    }
  }

  void updateLogo(XFile image) {
    storyUpdated = true;
    this.storyImage = image;
    notifyListeners();
  }



}
