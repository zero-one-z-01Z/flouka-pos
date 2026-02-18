import 'package:camera/camera.dart';
import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/core/models/text_field_model.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/products/presentation/views/add_attributes_view.dart';
import 'package:flutter/material.dart';

class AddProductProvider extends ChangeNotifier {
  // Main text fields controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Getters for controllers if needed (optional)
  TextEditingController get nameController => _nameController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get priceController => _priceController;

  // Main text fields model list (Dynamic for translation)
  List<TextFieldModel> get addProductTextFields => [
    TextFieldModel(
      label: LanguageProvider.translate('product', 'product_name'),
      controller: _nameController,
      key: 'product_name',
    ),
    TextFieldModel(
      label: LanguageProvider.translate('product', 'product_description'),
      controller: _descriptionController,
      key: 'product_description',
    ),
    TextFieldModel(
      label: LanguageProvider.translate('product', 'product_price'),
      controller: _priceController,
      key: 'product_price',
    ),
  ];

  // Additional controllers
  final TextEditingController discountController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  // State variables
  bool _taxIncluded = true;
  String _status = 'Active';

  // Image management
  XFile? _mainProductImage;
  final List<dynamic> _productImages = [];

  // Getters
  bool get taxIncluded => _taxIncluded;
  String get status => _status;
  XFile? get mainProductImage => _mainProductImage;
  List<dynamic> get productImages => _productImages;

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
    debugPrint('Publishing product...');
    debugPrint('Name: ${_nameController.text}');
    debugPrint('Description: ${_descriptionController.text}');
    debugPrint('Price: ${_priceController.text}');
    debugPrint('Discount: ${discountController.text}');
    debugPrint('Stock: ${stockController.text}');
    debugPrint('Tax Included: $_taxIncluded');
    debugPrint('Status: $_status');
  }


  // Add attributes method placeholder
  void addAttributes() {
    navP(const AddAttributesView());
    debugPrint('Adding attributes...');
  }
}
