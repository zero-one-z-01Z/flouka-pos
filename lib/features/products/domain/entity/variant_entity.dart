import 'package:flutter/material.dart';

import 'product_entity.dart';

class VariantEntity{
  int id;
  String name;
  num price;
  num? offerPrice;
  String sku;
  dynamic stock;
  List<int> combination;
  List<ProductImage>images;
  late TextEditingController quantityController = TextEditingController(text: "${stock !=null?(stock is num ? stock : stock.quantity) :""}");
  VariantEntity({required this.id,required this.price,required this.offerPrice,required this.sku,required this.name,
    required this.images, required this.combination, required this.stock});

}