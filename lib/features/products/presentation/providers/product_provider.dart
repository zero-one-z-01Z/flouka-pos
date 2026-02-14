import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../domain/entities/product_entity.dart';

class ProductProvider extends ChangeNotifier{

final List<Product> dummyProducts = [
  Product(name: "Apple 13\" MacBook Pro", imagePath: Images.macBook, price: 1200, oldPrice: 1500),
  Product(name: "Samsung Galaxy S22", imagePath: Images.macBook, price: 999, oldPrice: 1200),
  Product(name: "Apple iPhone 14", imagePath: Images.macBook, price: 1100, oldPrice: 1300),
  Product(name: "Dell XPS 13", imagePath: Images.macBook, price: 1050),
  Product(name: "Lenovo ThinkPad", imagePath: Images.macBook, price: 900),
  Product(name: "HP Spectre x360", imagePath: Images.macBook, price: 1150),
];

}