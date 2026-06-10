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
import 'package:flouka_pos/features/reels/domain/user_case/reels_use_case.dart';
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
import '../../../../core/helper_function/video.dart';
import '../../domain/entity/reel_entity.dart';
import '../widgets/add_reel_widget.dart';
import 'package:video_player/video_player.dart';

import 'reels_provider.dart';

class ReelsOperationsProvider extends ChangeNotifier {
  List<TextFieldModel> addStoreInputs = [];
  final formKey = GlobalKey<FormState>();
  ReelsUseCases reelsUseCases;
  ReelsOperationsProvider(this.reelsUseCases);
  void addTextField() {
    addStoreInputs = [
      TextFieldModel(key: "title",
          hint: "title",
          label: "reels_title",
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
    data['video']=  video!= null ? await MultipartFile.fromFile(video!.path, filename:  video!.path.split('/').last) : null;
    data['cover']=  cover!= null ? await MultipartFile.fromFile(cover!, filename: "cover_${video!.path.split('/').last}") : null;
    data['product_id'] = productOptionsProvider.productOptionEntity?.id;
    return data;
  }

  void removeVideo(){
    video = null;
    cover = null;
    notifyListeners();
  }


  Future addReel() async {
    loading();
    Map<String,dynamic> dataToUse=await prepareData();
    final result = await reelsUseCases.createReel(dataToUse);
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      navPop();
      ReelsProvider reelsProvider = Provider.of(Constants.globalContext(),listen: false);
      reelsProvider.addReel(r);
      successDialog();
      notifyListeners();
    });
  }

  void clear(){
    for(var element in addStoreInputs){
      element.controller.clear();
    }
    cover = null;
    video = null;
    ProductOptionsProvider productOptionsProvider = Provider.of(Constants.globalContext(),listen: false);
    productOptionsProvider.productOptionEntity = null;

  }

  Future deleteReel({required int id}) async {
    Map<String, dynamic> data = {};
    data["reel_id"] = id;
    loading();
    final result = await reelsUseCases.deleteReel(data);
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      navPop();
      successDialog();
      for(var element in addStoreInputs){
        element.controller.clear();
      }
      ReelsProvider reelsProvider = Provider.of(Constants.globalContext(),listen: false);
      reelsProvider.deleteReel(id);
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
              child: const AddReelWidget()),
        );
      },
    );
  }

  void deleteReelDialog({required int id}) {
    deleteDialog(onTap: () => deleteReel(id: id),msg: "delete_reel");
  }


  dynamic video;
  String? cover;

  void addVideo(XFile? video)  async{
    if (video != null) {
      VideoPlayerController? controller;
      controller = VideoPlayerController.file(File(video.path));
      await controller.initialize().then((_)  async{
        notifyListeners();
        int sec = controller!.value.duration.inSeconds;
        if (sec <= 60) {
          String? cover = await createVideoCover(video.path);
          if (cover != null) {
            this.video = video;
            this.cover = cover;
          }
          notifyListeners();
        } else {
          showToast(LanguageProvider.translate('validation', 'video_duration'));
        }
      });
    } else {
      this.video = null;
      cover = null;
    }
    notifyListeners();
  }

}
