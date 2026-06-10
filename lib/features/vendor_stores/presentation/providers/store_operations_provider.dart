import 'dart:async';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/dialog/success_dialog.dart';
import 'package:flouka_pos/core/helper_function/loading.dart';
import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/core/helper_function/text_form_field_validation.dart';
import 'package:flouka_pos/core/models/text_field_model.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/products/presentation/views/add_variant_view.dart';
import 'package:flouka_pos/features/vendor_stores/domain/user_case/vendor_stores_use_case.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/location.dart';
import '../../domain/entity/store_entity.dart';
import 'vendor_stores_provider.dart';

class StoreOperationsProvider extends ChangeNotifier {
  List<TextFieldModel> addStoreInputs = [];
  final formKey = GlobalKey<FormState>();
  VendorStoresUseCase vendorStoresUseCase;
  StoreOperationsProvider(this.vendorStoresUseCase);
  void addTextField({StoreEntity?store}) {
    addStoreInputs = [
      TextFieldModel(key: "name",
          hint: "store_name",
          validator: (value) =>validateName(value),
          controller: TextEditingController(text: store?.name??"")),
      TextFieldModel(key: "user_name",
          hint: "store_user_name",
          validator: (value) =>validateUserName(value),
          controller: TextEditingController(text:store?.userName??"")),
      TextFieldModel(key: "phone",
          hint: "store_phone",
          validator: (value) =>validatePhone(value),
          textInputType: TextInputType.phone,
          controller: TextEditingController(text:store?.phone??"")),
      TextFieldModel(key: "address",
          hint: "store_address",
          validator: (value) =>validateAddress(value),
          controller: TextEditingController(text: store?.address??"")),
      TextFieldModel(key: "password",
          hint: "password",
          validator: (value) =>validatePassword(value),
          controller: TextEditingController()),
      TextFieldModel(key: "confirm_password",
          hint: "confirm_password",
          validator: (value) {
            if(value != addStoreInputs.firstWhere((element) => element.key == "password").controller.text){
              return LanguageProvider.translate("validation", "confirm_password");
            }
            return null;
          },
          controller: TextEditingController()),

    ];
    initLocation();
  }

  LatLng? _center;
  final double _zoom = 14;
  final Set<Marker> _markers = {};

  double get zoom => _zoom;
  LatLng? get center => _center;
  Set<Marker> get markers => _markers;

  GoogleMapController? controller;
  Timer? _timer;

  void onCameraMove(CameraPosition position) {
    _center = position.target;
    if (_timer?.isActive ?? false) return;

    _timer = Timer(
      const Duration(milliseconds: 200),
          () => notifyListeners(),
    );
  }
  void onCameraMoveEnd() {
    notifyListeners();
  }

  Future<void> initLocation() async {
    LatLng latLng = await determinePosition();
    _center = latLng;
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  Map<String, dynamic> prepareData() {
    Map<String,dynamic> data={};
    for(var element in addStoreInputs){
      if(element.key !="confirm_password"){
        data[element.key]=element.controller.text;
      }
    }
    data["lat"]=_center?.latitude;
    data["lng"]=_center?.longitude;
    return data;
  }

  Future addStore() async {
    loading();
    final result = await vendorStoresUseCase.createStore(prepareData());
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      successDialog();
      Provider.of<VendorStoresProvider>(Constants.globalContext(), listen: false).addStore(r);
      for(var element in addStoreInputs){
        element.controller.clear();
      }
      notifyListeners();
    });
  }

  int? id;
  Future updateStore() async {
    Map<String, dynamic> data = prepareData();
    data["store_id"] = id;
    loading();
    final result = await vendorStoresUseCase.updateStore(data);
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      successDialog();
      Provider.of<VendorStoresProvider>(Constants.globalContext(), listen: false).updateStore(r);
      for(var element in addStoreInputs){
        element.controller.clear();
      }
      id = null;
      notifyListeners();
    });
  }

  void selectToEdit({required StoreEntity store}){
    addStoreInputs.firstWhere((element) => element.key == "name",).controller.text =store.name??"";
    addStoreInputs.firstWhere((element) => element.key == "user_name",).controller.text =store.userName??"";
    addStoreInputs.firstWhere((element) => element.key == "phone",).controller.text =store.phone??"";
    addStoreInputs.firstWhere((element) => element.key == "address",).controller.text =store.address??"";
    id = store.id;
    _center=LatLng(store.lat??0, store.lng??0);
    notifyListeners();
  }

  void reset(){
    id = null;
    addStoreInputs.forEach((element) {
      element.controller.clear();
    });
    notifyListeners();
  }

  Future deleteStore({required int id}) async {
    Map<String, dynamic> data = {};
    data["store_id"] = id;
    loading();
    final result = await vendorStoresUseCase.deleteStore(data);
    navPop();
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      successDialog();
      Provider.of<VendorStoresProvider>(Constants.globalContext(), listen: false).deleteStore(id);
      for(var element in addStoreInputs){
        element.controller.clear();
      }
      notifyListeners();
    });
  }



}
