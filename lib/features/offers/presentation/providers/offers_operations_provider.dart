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
import '../../../products/domain/entity/product_entity.dart';
import '../../../products/presentation/providers/product_options_provider.dart';
import '../../../vendor_stores/presentation/providers/store_options_provider.dart';
import '../../domain/entity/offer_entity.dart';
import '../../domain/user_case/offers_use_case.dart';
import '../widgets/offers_options_widget.dart';
import 'offers_provider.dart';

class OffersOperationsProvider extends ChangeNotifier {
  List<TextFieldModel> addOffersInputs = [];
  final formKey = GlobalKey<FormState>();
  OffersUseCase couponsUseCase;
  OffersOperationsProvider(this.couponsUseCase);
  void addTextField() {
    addOffersInputs = [
      TextFieldModel(key: "name",
          hint: "offer_name",
          validator: (value) =>validateOfferName(value),
          controller: TextEditingController(),
      ),
      TextFieldModel(key: "percentage",
          hint: "offer_percentage",
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
    ];
    Provider.of<ProductOptionsProvider>(Constants.globalContext(), listen: false).getVendorProductsOption();
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


  Map<String, dynamic> prepareData() {
    Map<String,dynamic> data={};
    for(var element in addOffersInputs){
      data[element.key]=element.controller.text;
    }
    List<int> ids=[];
    for(var element in listProducts){
      ids.add(element.id);
    }
    data['products_id[]']= ids;
    return data;
  }

  Future addOffers() async {
    loading();
    final result = await couponsUseCase.createOffer(prepareData());
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      successDialog();
      Provider.of<OffersProvider>(Constants.globalContext(), listen: false).addOffer(r);
      reset();
      notifyListeners();
    });
  }

  void reset(){
    id = null;
    addOffersInputs.forEach((element) {
      element.controller.clear();
    });
    listProducts.clear();
    notifyListeners();
  }


  Future updateOffers() async {
    loading();
    Map<String, dynamic> data = prepareData();
    data["id"] = id;
    final result = await couponsUseCase.updateOffer(data);
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      successDialog();
      Provider.of<OffersProvider>(Constants.globalContext(), listen: false).updateOffer(r);
      reset();
      notifyListeners();
    });
  }


  Future deleteOffers({required int id}) async {
    Map<String, dynamic> data = {};
    data["id"] = id;
    loading();
    final result = await couponsUseCase.deleteOffer(data);
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      navPop();
      successDialog();
      Provider.of<OffersProvider>(Constants.globalContext(), listen: false).deleteOffer(id);
      notifyListeners();
    });
  }

  int? id;
  void selectToEdit({required OfferEntity offer}){
    addOffersInputs.firstWhere((element) => element.key == "name",).controller.text =offer.name;
    addOffersInputs.firstWhere((element) => element.key == "percentage",).controller.text =offer.percentage.toString();
    listProducts.clear();
    for(var element in (offer.products)){
      listProducts.add(element);
    }
    id = offer.id;
    notifyListeners();
  }

  List<ProductOptionEntity> listProducts = [];
  void addToList({required ProductOptionEntity option}){
    if(listProducts.contains(option)){
      listProducts.remove(option);
    }else{
      listProducts.add(option);
    }
    notifyListeners();
  }

  void deleteCouponDialog({required int id}){
    deleteDialog(onTap: (){
      deleteOffers(id: id);
    }, msg: "delete_offer");
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
              child: const OffersOptionsWidget()),
        );
      },
    );
  }

}
