import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flouka_pos/features/products/domain/user_case/product_use_case.dart';
import 'package:flouka_pos/features/products/presentation/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/dialog/success_dialog.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../domain/entity/product_entity.dart';
import '../widgets/product_preview_overlay.dart';

class StoreOperationProvider extends ChangeNotifier {
  final ProductUseCase productUseCase;
  StoreOperationProvider(this.productUseCase);

  void showAddWidget({required ProductEntity product}) {
    if(product.stock !=null){
      stockController.text = product.stock!.quantity.toString();
    }else{
      stockController.clear();
    }

    showDialog(
      context: Constants.globalContext(),
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: SizedBox(
              width: 40.w,
              height: 65.h,
              child: ProductPreviewOverlay(product: product,)),
        );
      },
    );
  }

  Future addProductToStore({required int id,required num quantity, int? productVariantId,}) async {
    Map<String,dynamic> data= {};
    data['product_id']=id;
    data['quantity']=quantity;
    if(productVariantId != null){
      data['product_variant_id']=productVariantId;
    }

    loading();
    Either<DioException, QuantityEntity> value = await productUseCase.addProductToStore(data);
    navPop();
    value.fold((l) async {
      showToast(l.message!);
    }, (r) {
      navPop();
      ProductsProvider provider = Provider.of<ProductsProvider>(Constants.globalContext(), listen: false);

      if(productVariantId != null){
        int index = provider.data?.indexWhere((element) => element.id == id) ?? -1;
        if (index != -1) {
          int variantIndex = provider.data![index].variants.indexWhere((element) => element.id == productVariantId);
          if (variantIndex != -1) {
            provider.data![index].variants[variantIndex].stock = r;
            provider.data![index].variants[variantIndex].quantityController.text = r.quantity.toString();
          }
        }
      }else{
        int index = provider.data?.indexWhere((element) => element.id == id) ?? -1;
        if (index != -1) {
          provider.data![index].stock = r;
          stockController.text = r.quantity.toString();
        }
      }

      successDialog();
    },
    );
  }

  TextEditingController stockController = TextEditingController();

  Future removeStock({required int storeProductStockId,bool removeProduct=false,required int productId,}) async {
    Map<String,dynamic> data= {};
    data['store_product_stock_id']=storeProductStockId;
    loading();
    Either<DioException, bool> value = await productUseCase.removeStock(data);
    navPop();
    value.fold((l) async {
      showToast(l.message!);
    }, (r) {
      navPop();
      ProductsProvider provider = Provider.of<ProductsProvider>(Constants.globalContext(), listen: false);

      if(removeProduct){
        int index = provider.data?.indexWhere((element) => element.id == productId) ?? -1;
        if (index != -1) {
          provider.data![index].stock = null;
        }
      }else{
        int index = provider.data?.indexWhere((element) => element.id == productId) ?? -1;
        if (index != -1) {
          int variantIndex = provider.data![index].variants.indexWhere((element) => element.stock.id == storeProductStockId);
          if (variantIndex != -1) {
            provider.data![index].variants[variantIndex].stock = null;
            provider.data![index].variants[variantIndex].quantityController.clear();
          }
        }
      }
      successDialog();
    },
    );
  }

}