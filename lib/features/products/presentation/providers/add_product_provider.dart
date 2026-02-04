import 'package:flouka_pos/core/models/text_field_model.dart';
import 'package:flutter/material.dart';

class AddProductProvider extends ChangeNotifier {
  // Main text fields (Product Name, Description, Price)
  List<TextFieldModel> addProductTextFields = [
    TextFieldModel(
      label: 'Product Name',
      controller: TextEditingController(),
      key: '',
    ),
    TextFieldModel(
      label: 'Product Description',
      controller: TextEditingController(),
      key: '',
    ),
    TextFieldModel(
      label: 'Product Price',
      controller: TextEditingController(),
      key: '',
    ),
  ];

  // Additional controllers
  final TextEditingController discountController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  // State variables
  bool _taxIncluded = true;
  String _status = 'Active';

  // Getters
  bool get taxIncluded => _taxIncluded;
  String get status => _status;

  // Update methods
  void updateTaxIncluded(bool value) {
    _taxIncluded = value;
    notifyListeners();
  }

  void updateStatus(String value) {
    _status = value;
    notifyListeners();
  }

  // Publish product method placeholder
  void publishProduct() {
    debugPrint('Publishing product...');
    debugPrint('Name: ${addProductTextFields[0].controller.text}');
    debugPrint('Description: ${addProductTextFields[1].controller.text}');
    debugPrint('Price: ${addProductTextFields[2].controller.text}');
    debugPrint('Discount: ${discountController.text}');
    debugPrint('Stock: ${stockController.text}');
    debugPrint('Tax Included: $_taxIncluded');
    debugPrint('Status: $_status');
  }

  // Add attributes method placeholder
  void addAttributes() {
    debugPrint('Adding attributes...');
  }
}
