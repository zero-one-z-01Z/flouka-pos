import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/helper_function/text_form_field_validation.dart';
import 'package:flouka_pos/core/models/text_field_model.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/products/domain/entity/variant_entity.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/dialog/delete_item_dialog.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/dialog/success_dialog.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/models/provider_structure_model.dart';
import '../../../categories/domain/entity/category_attributes_entity.dart';
import '../../../categories/domain/usecases/category_usecase.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/user_case/product_use_case.dart';
import '../views/add_variant_view.dart';
import 'add_product_provider.dart';

class AddVariantProvider extends ChangeNotifier implements ProviderStructureModel<List<CategoryAttributesEntity>>{
  final CategoryUsecase categoryUseCase;
  final ProductUseCase productUseCase;
  AddVariantProvider(this.categoryUseCase,this.productUseCase);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<TextFieldModel> variantInputs=[];
  void goToAddVariantView({required String id}){
    reset();
    categoryId=id;
    refresh();
    navP(const AddVariantView());
  }

  void initField({VariantEntity?variant}){
    variantInputs=[
      TextFieldModel(key: 'name',label: 'name',
          validator: (val)=> validateName(val),
          controller:TextEditingController(text: variant?.name??""),width: 30.w),
      TextFieldModel(key: 'sku',label: 'sku',validator: (val)=> validateSku(val),
          controller:TextEditingController(text: variant?.sku??""),width: 30.w),
      TextFieldModel(key: 'price',label: 'price',validator: (val)=> validatePrice(val),
          controller:TextEditingController(text: variant?.price.toString()??""),width: 30.w),
      TextFieldModel(key: 'offer_price',validator: (val)=> null,
          label: LanguageProvider.translate("product", "discounted_price"),
          controller:TextEditingController(text: variant?.offerPrice.toString()??""),width: 30.w),
    ];

  }
  List<dynamic> productImages = [];
  List<int> deletedId = [];
  void addToImages(List<XFile> img){
    List lastImages = [...productImages];
    for (var i in img) {
      if (lastImages.length < 20) {
        lastImages.add(i);
      } else {
        break;
      }
    }
    productImages.clear();
    productImages.addAll(lastImages);
    notifyListeners();
  }

  void deleteImage(int index) {
    if (productImages[index] is ProductImage) {
      deletedId.add(productImages[index].id);
    }
    productImages.removeAt(index);
    notifyListeners();
  }
  @override
  List<CategoryAttributesEntity>? data;

  @override
  Map? inputs;

  String? categoryId;
  @override
  void clear() {
    data = null;
    notifyListeners();
  }

  @override
  Future getData() async {
    Map<String, dynamic> dataToUse = {
      'category_id': categoryId,
    };

    final result = await categoryUseCase.getCategoryAttributes(dataToUse);
    result.fold((l) => showToast(l.message ?? "Error loading products"), (r) {
      data= r;
      addFilter();
      notifyListeners();
    });

  }

  List<Map<String,dynamic>> CategoryAttributesNames(int index){
    if(data ==null || (data!=null && data!.isEmpty)){
      return [];
    }
    return List.generate(data![index].values.length, (i){
      return {'name':data![index].values[i].value,'id':data![index].values[i].id};
    });
  }
  List<Map<String, dynamic>> attributes=[];

  void addFilter(){
    attributes = [];
    for(int i=0;i<(data?.length??0);i++){
      attributes.add(
          {
            'title': data![i].name,
            'on_tap':(){

            },
            'active':false,
            'value':null,
            'children':CategoryAttributesNames(i),
          }
      );
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

  Future setCategory(String? categoryId) async {
    this.categoryId = categoryId;
    loading();
    await refresh();
    navPop();
  }

  void setLabelValue(Map<String, dynamic> attribute, Map<String, dynamic> value) {
    final index = attributes.indexWhere((e) => e['title'] == attribute['title']);

    for (final item in attribute['children'] ?? []) {
      item['active'] = false;
    }
    value['active'] = true;
    attributes[index]['value'] = value;
    notifyListeners();
  }

  List<int> get selectedAttributeIds {
    return attributes.where((e) => e['value'] != null).map<int>((e) => e['value']['id'] as int).toList();
  }

  bool get isAllAttributesSelected {
    print('${attributes.every((attribute) => attribute['value'] != null)}');
    return attributes.every((attribute) => attribute['value'] != null);
  }


  Future<Map<String,dynamic>> productData()async{
    Map<String,dynamic> data={};
    for(var field in variantInputs){
      data[field.key]=field.controller.text;
    }
    for(int i =0;i<productImages.length;i++){
      if(productImages[i] is XFile){
        data['images[$i]']=await MultipartFile.fromFile(productImages[i].path);
      }
    }
    AddProductProvider addProductProvider = Provider.of(Constants.globalContext(),listen: false);
    data['product_id']=addProductProvider.product?.id;
    for(int i=0;i<selectedAttributeIds.length;i++){
      data['attributes_id[$i]']=selectedAttributeIds[i];
    }


    return data;
  }

  Future createVariant() async {
    Map<String,dynamic> data=await productData();
    loading();
    Either<DioException, VariantEntity> value = await productUseCase.createVariant(data);
    navPop();
    value.fold((l) async {
      showToast(l.message!);
    }, (r) {
      successDialog();
      afterSuccess(variant: r);
      notifyListeners();
    },
    );
  }

  VariantEntity? variant;

  Future updateVariant() async {
    Map<String,dynamic> data=await productData();
    data['product_variant_id']=variant?.id;
    for(int i=0;i<deletedId.length;i++){
      data['deleted_images[$i]'] = "${deletedId[i]}";
    }
    loading();
    Either<DioException, VariantEntity> value = await productUseCase.updateVariant(data);
    navPop();
    value.fold((l) async {
      showToast(l.message!);
    }, (r) {
      successDialog();
      afterSuccess(variant: r);
      notifyListeners();
    },
    );
  }

  void reset(){
    variant = null;
    initField();
    productImages.clear();
    deletedId =[];
    for(var element in attributes){
      element['value']=null;
      element['children'].forEach((element) {
        element['active'] = false;
      });
    }
    notifyListeners();
  }

  void afterSuccess({required VariantEntity variant}){
    reset();
    AddProductProvider addProductProvider= Provider.of<AddProductProvider>(Constants.globalContext(), listen: false);
    if(addProductProvider.product != null){
      int index = addProductProvider.product!.variants.indexWhere((element) => element.id == variant.id);
      if (index != -1) {
        addProductProvider.product!.variants[index] = variant;
      }else{
        addProductProvider.product!.variants.add(variant);
      }
    }

  }

  void deleteVariantDialog({required int id}){
    deleteDialog(onTap: (){
      deleteVariant(id: id);
    }, msg: "delete_variant");
  }


  Future deleteVariant({required int id}) async {
    AddProductProvider addProductProvider = Provider.of(Constants.globalContext(),listen: false);
    Map<String,dynamic> data={};
    data['product_variant_id']=id;
    data['product_id']=addProductProvider.product?.id;

    loading();
    Either<DioException, bool> value = await productUseCase.deleteVariant(data);
    navPop();
    value.fold((l) async {
      showToast(l.message!);
    }, (r) {
      navPop();
      successDialog(then: (){reset();});
      int index = addProductProvider.product!.variants.indexWhere((element) => element.id == id);
      if (index != -1) {
        addProductProvider.product!.variants.removeAt(index);
      }
      notifyListeners();
    },
    );
  }

  void selectToEdit({required VariantEntity variant}) async{
    this.variant = variant;
    productImages = [];
    initField(variant: variant);
    for (var i in variant.images) {
      productImages.add(i);
    }
    deletedId =[];
    for(var attribute in attributes){
      attribute['value']=null;
      attribute['active']=false;
      attribute['children'].forEach((element) {
        element['active'] = false;
      });
      notifyListeners();
    }

    for (var valueId in variant.combination) {
      for (var attribute in attributes) {
        final children = attribute['children'] as List<Map<String, dynamic>>;
        final child = children.where((e) => e['id'] == valueId).firstOrNull;
        if (child != null) {
          attribute['value'] = child;
          attribute['active'] = true;
          child['active'] = true;
          break;
        }
      }
    }
    notifyListeners();
  }
}