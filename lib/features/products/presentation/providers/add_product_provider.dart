import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/dialog/success_dialog.dart';
import 'package:flouka_pos/core/helper_function/loading.dart';
import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/core/helper_function/text_form_field_validation.dart';
import 'package:flouka_pos/core/models/text_field_model.dart';
import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flouka_pos/features/categories/presentation/providers/brands_provider.dart';
import 'package:flouka_pos/features/categories/presentation/providers/subcategory_provider.dart';
import 'package:flouka_pos/features/home/presentation/providers/home_provider.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/products/presentation/views/add_variant_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/dialog/delete_item_dialog.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../categories/presentation/providers/categories_provider.dart';
import '../../../home/domain/entity/navigation_entity.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/user_case/product_use_case.dart';
import '../widgets/show_products_tags_widget.dart';
import 'product_provider.dart';

class AddProductProvider extends ChangeNotifier {
  final ProductUseCase productUseCase;
  AddProductProvider(this.productUseCase);
  List<TextFieldModel>  addProductTextFields = [];

  void initFields({ ProductEntity? product}){
    if(product == null) this.product =null;
    AuthProvider authProvider = Provider.of(Constants.globalContext(),listen: false);
    addProductTextFields = [
      TextFieldModel(
        label: LanguageProvider.translate('product', 'product_title'),
        controller: TextEditingController(text: product?.title),
        key: 'title',
        validator: (val) => validateTitle(val),
      ),
      TextFieldModel(
        label: LanguageProvider.translate('product', 'product_description'),
        controller: TextEditingController(text: product?.description),
        key: 'description',
        validator: (val) => validateDescription(val),
        max: 4,
      ),
      TextFieldModel(
        label: LanguageProvider.translate('product', 'cost_price'),
        controller: TextEditingController(text:product !=null? (product.costPrice?.toString()??"0") : ""),
        validator: (val) => validateCostPrice(val),
        key: 'offer_price',
      ),

      TextFieldModel(
        label: LanguageProvider.translate('product', 'product_price'),
        controller: TextEditingController(text: product?.price.toString()),
        validator: (val) => validatePrice(val),
        key: 'price',
      ),
      TextFieldModel(
        label: LanguageProvider.translate('product', 'discounted_price'),
        controller: TextEditingController(text: product?.offerPrice?.toString() ?? ""),
        validator: (val) => validateOfferPrice(val),
        key: 'offer_price',
      ),
      if(authProvider.userEntity!.accountType=='individual')TextFieldModel(
        label: LanguageProvider.translate('product', 'stock'),
        controller: TextEditingController(text: product?.stock?.quantity?.toString() ?? ""),
        // validator: (val) => validateStock(val),
        key: 'stock',
      ),
      TextFieldModel(
        label: LanguageProvider.translate('product', 'product_sku'),
        controller: TextEditingController(text: product?.sku),
        validator: (val) => validateSku(val),
        key: 'sku',
      ),


    ];
    productImages.clear();
    CategoryProvider categoryProvider =Provider.of<CategoryProvider>(Constants.globalContext(), listen: false);
    SubcategoryProvider subcategoryProvider =Provider.of<SubcategoryProvider>(Constants.globalContext(), listen: false);
    BrandsProvider brandsProvider =Provider.of<BrandsProvider>(Constants.globalContext(), listen: false);
    categoryProvider.reset();
    subcategoryProvider.reset();
    brandsProvider.reset();
  }
  // Additional controllers
  final TextEditingController discountController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  // State variables
  bool _taxIncluded = true;
  String _status = 'Active';

  // Image management
  XFile? _mainProductImage;
  List<dynamic> _productImages = [];

  // Getters
  bool get taxIncluded => _taxIncluded;
  String get status => _status;
  XFile? get mainProductImage => _mainProductImage;
  List<dynamic> get productImages => _productImages;

  List<TagEntity> tags = [];
  void addToList({required TagEntity tag}){
    if(tags.contains(tag)){
      tags.remove(tag);
    }else{
      tags.add(tag);
    }
    notifyListeners();
  }


  // Update methods
  void updateTaxIncluded(bool value) {
    _taxIncluded = value;
    notifyListeners();
  }

  void updateStatus(String value) {
    _status = value;
    notifyListeners();
  }

  // Image management methods
  void updateMainImage(XFile? image) {
    _mainProductImage = image;
    notifyListeners();
  }

  void addProductImages(List<XFile> images) {
    _productImages.addAll(images);
    notifyListeners();
  }

  void deleteProductImage(int index) {
    _productImages.removeAt(index);
    notifyListeners();
  }

  // Publish product method placeholder
  void publishProduct() {
    if (formKey.currentState!.validate()) {
      if(product !=null){
        updateProduct();
      }else{
        createProduct();
      }
    }
  }

  Future<Map<String,dynamic>> productData()async{
    Map<String,dynamic> data={};
    for(var field in addProductTextFields){
      data[field.key]=field.controller.text;
    }
    for(int i =0;i<productImages.length;i++){
      if(productImages[i] is XFile){
        data['images[$i]']=await MultipartFile.fromFile(productImages[i].path);
      }
    }
    for(int i =0;i<tags.length;i++){
      data['tags[$i]']=tags[i].id;
    }
    BrandsProvider brandsProvider = Provider.of<BrandsProvider>(Constants.globalContext(), listen: false);
    SubcategoryProvider subcategoryProvider = Provider.of<SubcategoryProvider>(Constants.globalContext(), listen: false);
    data['brand_id']= brandsProvider.selected()?.id;
    data['category_id']= subcategoryProvider.selected()?.id;


    return data;
  }

  Future createProduct() async {
    Map<String,dynamic> data=await productData();
    loading();
    Either<DioException, ProductEntity> value = await productUseCase.createProduct(data);
    navPop();
    value.fold((l) async {
      showToast(l.message!);
      }, (r) {
     successDialog();
     afterSuccess();
      notifyListeners();
    },
    );
  }
  ProductEntity? product;
  void selectToEdit({required ProductEntity product}) async{
    this.product = product;
    initFields(product: product);
    CategoryProvider categoryProvider =Provider.of<CategoryProvider>(Constants.globalContext(), listen: false);
    SubcategoryProvider subcategoryProvider =Provider.of<SubcategoryProvider>(Constants.globalContext(), listen: false);
    BrandsProvider brandsProvider =Provider.of<BrandsProvider>(Constants.globalContext(), listen: false);
    if(product.category!.parentId!=null){
      categoryProvider.setCategory(product.category!.parentId!);
      await subcategoryProvider.refresh(categoryProvider.selectedCategory!);
      subcategoryProvider.setCategory(product.category!);
      await brandsProvider.setCategory(product.category!.id.toString());
      brandsProvider.setBrand(product.brand!);
    }
    tags.clear();
    for(var tag in (product.tags??[])){
      tags.add(tag);
    }
    _productImages = [];
    if(product.images!=null){
      for (var i in product.images!) {
        _productImages.add(i);
      }
    }
    deletedId =[];
    HomeProvider homeProvider =Provider.of<HomeProvider>(Constants.globalContext(), listen: false);
    NavigationEntity navigation= homeProvider.navigationList.firstWhere((nav) => nav.title == "add_products",);
    homeProvider.setAddProductNavigation(navigation);

  }

  void reset(){
    initFields();
    tags.clear();
    productImages.clear();
    deletedId =[];
    Provider.of<BrandsProvider>(Constants.globalContext(), listen: false).reset();
    Provider.of<CategoryProvider>(Constants.globalContext(), listen: false).reset();
    Provider.of<SubcategoryProvider>(Constants.globalContext(), listen: false).reset();
    notifyListeners();
  }
  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Add attributes method placeholder
  void showAddWidget() {
    showDialog(
      context: Constants.globalContext(),
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: SizedBox(
              width: 25.w,
              height: 65.h,
              child: const ShowProductsTagsWidget()),
        );
      },
    );
  }


  Future getProductVendorDetails({required int id}) async {
    Map<String,dynamic> data={};
    data['product_id']= id;
    loading();
    Either<DioException, ProductEntity> value = await productUseCase.getProductVendorDetails(data);
    navPop();
    value.fold((l) async {
      showToast(l.message!);
    }, (r) {
      selectToEdit(product: r);
    },
    );
  }

  List<int> deletedId = [];
  void addToImages(List<XFile> img){
    List lastImages = [..._productImages];
    for (var i in img) {
      if (lastImages.length < 20) {
        lastImages.add(i);
      } else {
        break;
      }
    }
    _productImages.clear();
    _productImages.addAll(lastImages);
    notifyListeners();
  }

  void deleteImage(int index) {
    if (_productImages[index] is ProductImage) {
      deletedId.add(_productImages[index].id);
    }
    _productImages.removeAt(index);
    notifyListeners();
  }

  Future updateProduct() async {
    Map<String,dynamic> data=await productData();
    data['product_id']=product?.id;
    for(int i=0;i<deletedId.length;i++){
      data['deleted_images[$i]'] = "${deletedId[i]}";
    }
    loading();
    Either<DioException, ProductEntity> value = await productUseCase.updateProduct(data);
    navPop();
    value.fold((l) async {
      showToast(l.message!);
    }, (r) {
      successDialog();
      afterSuccess();
      notifyListeners();
    },
    );
  }

  void afterSuccess(){
    reset();
    HomeProvider homeProvider =Provider.of<HomeProvider>(Constants.globalContext(), listen: false);
    ProductsProvider productsProvider =Provider.of<ProductsProvider>(Constants.globalContext(), listen: false);
    NavigationEntity navigation= homeProvider.navigationList.firstWhere((nav) => nav.title == "Products",);
    homeProvider.setAddProductNavigation(navigation);
    productsProvider.refresh();

  }

  void deleteProductDialog({required int id}){
    deleteDialog(onTap: (){
      deleteProduct(id: id);
    }, msg: "delete_product");
  }


  Future deleteProduct({required int id}) async {
    Map<String,dynamic> data=await productData();
    data['product_id']=id;
    loading();
    Either<DioException, bool> value = await productUseCase.deleteProduct(data);
    navPop();
    value.fold((l) async {
      showToast(l.message!);
    }, (r) {
      navPop();

      successDialog();
      ProductsProvider productsProvider =Provider.of<ProductsProvider>(Constants.globalContext(), listen: false);
      productsProvider.deleteProduct(id);
      notifyListeners();
    },
    );
  }

}
