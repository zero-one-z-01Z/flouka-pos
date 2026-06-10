import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/dialog/delete_item_dialog.dart';
import 'package:flouka_pos/core/dialog/success_dialog.dart';
import 'package:flouka_pos/core/helper_function/loading.dart';
import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/core/helper_function/text_form_field_validation.dart';
import 'package:flouka_pos/core/models/text_field_model.dart';
import 'package:flouka_pos/features/coupons/domain/user_case/coupons_use_case.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/products/presentation/views/add_variant_view.dart';
import 'package:flouka_pos/features/story/domain/user_case/stories_use_case.dart';
import 'package:flouka_pos/features/vendor_stores/domain/entity/store_entity.dart';
import 'package:flouka_pos/features/vendor_stores/domain/user_case/vendor_stores_use_case.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/location.dart';
import '../../../vendor_stores/presentation/providers/store_options_provider.dart';
import '../../domain/entity/coupon_entity.dart';
import '../widgets/stores_options_widget.dart';
import 'coupons_provider.dart';

class CouponsOperationsProvider extends ChangeNotifier {
  List<TextFieldModel> addCouponsInputs = [];
  final formKey = GlobalKey<FormState>();
  CouponsUseCase couponsUseCase;
  CouponsOperationsProvider(this.couponsUseCase);
  bool isPercentage=true;
  void setIsPercentage(bool value) {
    isPercentage = value;
    insertController();
    notifyListeners();
  }

  void addTextField() {
    addCouponsInputs = [
      TextFieldModel(key: "name",
          hint: "coupon_name",
          validator: (value) =>validateCouponName(value),
          controller: TextEditingController(),
      ),
      TextFieldModel(key: "coupon",
          hint: "coupon_code",
          validator: (value) =>validateCouponCode(value),
          controller: TextEditingController()),
      TextFieldModel(key: "value",
          hint: "value",
          textInputType: TextInputType.number,
          validator: (value) {
            if(value ==null ){
              return LanguageProvider.translate("validation", "value_required");
            }else if(num.tryParse(value) == null){
              return LanguageProvider.translate("validation", "value_invalid");
            }
            return null;
          },
          controller: TextEditingController()),
      TextFieldModel(key: "count",
          hint: "count",
          validator: (value) =>validateCount(value),
          controller: TextEditingController()),
    ];
    insertController();
    Provider.of<StoreOptionsProvider>(Constants.globalContext(), listen: false).refresh();
    notifyListeners();
  }

  TextFieldModel minController(){
    return TextFieldModel(key: "min",
        hint: "min",
        validator: (value) =>validateMin(value),
        controller: TextEditingController());
  }

  TextFieldModel maxController(){
    return TextFieldModel(key: "max",
        hint: "max",
        validator: (value) =>validateMax(value),
        controller: TextEditingController());
  }

  void insertController(){
    if(isPercentage){
      int index= addCouponsInputs.indexWhere((element) => element.key=="min");
      if(index !=-1){
        addCouponsInputs.removeAt(index);
      }
      addCouponsInputs.insert(3,maxController());
    }else{
      int index= addCouponsInputs.indexWhere((element) => element.key=="max");
      if(index !=-1){
        addCouponsInputs.removeAt(index);
      }
      addCouponsInputs.insert(3,minController());
    }
    notifyListeners();
  }


  Map<String, dynamic> prepareData() {
    Map<String,dynamic> data={};
    for(var element in addCouponsInputs){
      data[element.key]=element.controller.text;
    }
    data['type'] = isPercentage ? "percentage" : "fixed";
    if(isPercentage){
      data['min'] =0;
    }else{
      data['max'] =0;
    }
    List<int> ids=[];
    for(var element in listStores){
      ids.add(element.id);
    }
    data['stores_id[]']= ids;
    return data;
  }

  Future addCoupons() async {
    loading();
    final result = await couponsUseCase.createCoupon(prepareData());
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      successDialog();
      Provider.of<CouponsProvider>(Constants.globalContext(), listen: false).addCoupon(r);
      for(var element in addCouponsInputs){
        element.controller.clear();
      }
      notifyListeners();
    });
  }

  void reset(){
    id = null;
    addCouponsInputs.forEach((element) {
      element.controller.clear();
    });
    listStores.clear();
    notifyListeners();
  }


  Future updateCoupons() async {
    loading();
    Map<String, dynamic> data = prepareData();
    data["id"] = id;
    final result = await couponsUseCase.updateCoupon(data);
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      successDialog();
      Provider.of<CouponsProvider>(Constants.globalContext(), listen: false).updateCoupon(r);
      reset();
      notifyListeners();
    });
  }


  Future deleteCoupons({required int id}) async {
    Map<String, dynamic> data = {};
    data["id"] = id;
    loading();
    final result = await couponsUseCase.deleteCoupon(data);
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      navPop();
      successDialog();
      Provider.of<CouponsProvider>(Constants.globalContext(), listen: false).deleteCoupon(id);
      notifyListeners();
    });
  }

  int? id;
  void selectToEdit({required CouponEntity coupon}){
    addCouponsInputs.firstWhere((element) => element.key == "name",).controller.text =coupon.name;
    addCouponsInputs.firstWhere((element) => element.key == "coupon",).controller.text =coupon.coupon;
    addCouponsInputs.firstWhere((element) => element.key == "value",).controller.text =coupon.value.toString();
    addCouponsInputs.firstWhere((element) => element.key == "count",).controller.text =coupon.count.toString();
    isPercentage = coupon.type == "percentage" ? true:false;
    if(!isPercentage){
      addCouponsInputs.firstWhere((element) => element.key == "min",).controller.text =coupon.min.toString();
    }else{
      addCouponsInputs.firstWhere((element) => element.key == "max",).controller.text =coupon.max.toString();
    }
    listStores.clear();
    for(var element in (coupon.stores)){
      listStores.add(element);
    }
    id = coupon.id;
    notifyListeners();
  }

  List<StoreOption> listStores = [];
  void addToList({required StoreOption store}){
    if(listStores.contains(store)){
      listStores.remove(store);
    }else{
      listStores.add(store);
    }
    notifyListeners();
  }

  void deleteCouponDialog({required int id}){
    deleteDialog(onTap: (){
      deleteCoupons(id: id);
    }, msg: "delete_coupon");
  }
  void showAddWidget() {
    showDialog(
      context: Constants.globalContext(),
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: SizedBox(
              width: 25.w,
              height: 65.h,
              child: const StoresOptionsWidget()),
        );
      },
    );
  }

}
