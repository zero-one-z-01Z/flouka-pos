
import '../../../../core/helper_function/convert.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/entity/variant_entity.dart';
import 'product_model.dart';

class VariantModel extends VariantEntity{
  VariantModel({required super.id, required super.price, required super.offerPrice,
    required super.images,required super.name,
    required super.sku, required super.combination, required super.stock});


  factory VariantModel.fromJson(Map data){
    List<int> combination = [];
    List<ProductImage> images = [];
    for(var i in data['combination']){
      combination.add(convertStringToInt(i));
    }
    for(var i in data['images']){
      images.add(ProductImageModel.fromJson(i));
    }

    return VariantModel(id: data['id'], price: convertDataToNum(data['price'])??0,
        images: images,
        name: data['name']??"",
        offerPrice: convertDataToNum(data['offer_price']),
        sku: data['sku'], combination: combination,
        stock:data['stock'] ==null ? null: data['stock'] is Map<String,dynamic>?
            QuantityModel.fromJson(data['stock']):
        convertStringToInt(data['stock']));
  }

}