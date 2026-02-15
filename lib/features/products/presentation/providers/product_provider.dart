import 'package:flutter/material.dart';
import '../../../../core/constants/app_images.dart';
import '../../domain/entities/product_entity.dart';

class ProductProvider extends ChangeNotifier {
  /// ================= PRODUCTS =================
  final List<Product> _products = [
    Product(
      name: "Apple 13\" MacBook Pro",
      imagePath: Images.macBook,
      imagePaths: [
        Images.macBook,
        Images.macBook,
        Images.macBook,
      ],
      price: 1200,
      oldPrice: 1500,
      description: "Powerful Apple laptop with M2 chip and Retina display.",
      storeName: "Apple Store",
    ),
    Product(
      name: "Samsung Galaxy S22",
      imagePath: Images.macBook,
      imagePaths: [
        Images.macBook,
        Images.macBook,
        Images.macBook,
      ],
      price: 999,
      oldPrice: 1200,
      description: "Premium Android smartphone with excellent camera.",
      storeName: "Samsung Official",
    ),
    Product(
      name: "Apple iPhone 14",
      imagePath: Images.macBook,
      imagePaths: [
        Images.macBook,
        Images.macBook,
        Images.macBook,
      ],
      price: 1100,
      oldPrice: 1300,
      description: "Latest iPhone model with advanced camera features.",
      storeName: "Apple Store",
    ),
    Product(
      name: "Dell XPS 13",
      imagePath: Images.macBook,
      imagePaths: [
        Images.macBook,
        Images.macBook,
        Images.macBook,
      ],
      price: 1050,
      description: "Compact and powerful ultrabook for professionals.",
      storeName: "Dell Store",
    ),
    Product(
      name: "Lenovo ThinkPad",
      imagePath: Images.macBook,
      imagePaths: [
        Images.macBook,
        Images.macBook,
        Images.macBook,
      ],
      price: 900,
      description: "Reliable business laptop with excellent keyboard.",
      storeName: "Lenovo Official",
    ),
    Product(
      name: "HP Spectre x360",
      imagePath: Images.macBook,
      imagePaths: [
        Images.macBook,
        Images.macBook,
        Images.macBook,
      ],
      price: 1150,
      description: "Convertible laptop with high build quality.",
      storeName: "HP Store",
    ),
  ];

  List<Product> get products => _products;

  /// ================= PREVIEW =================
  Product? _selectedProduct;
  bool _isPreviewOpen = false;

  Product? get selectedProduct => _selectedProduct;
  bool get isPreviewOpen => _isPreviewOpen;

  void openPreview(Product product) {
    _selectedProduct = product;
    _isPreviewOpen = true;
    notifyListeners();
  }

  void closePreview() {
    _selectedProduct = null;
    _isPreviewOpen = false;
    notifyListeners();
  }

  /// ================= SWITCH LOGIC =================
  void toggleProductActive(int index, bool value) {
    _products[index].isActive = value;
    notifyListeners();
  }
}
