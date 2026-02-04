import 'package:flouka_pos/core/models/text_field_model.dart';
import 'package:flutter/material.dart';

class AddProductProvider extends ChangeNotifier {
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
    // TextFieldModel(
    //   label: 'Discounted Price (Optional)',
    //   controller: TextEditingController(),
    //   key: '',
    // ),
    // TextFieldModel(
    //   label: 'Tax Included',
    //   controller: TextEditingController(),
    //   key: '',
    // ),
    // TextFieldModel(
    //   label: 'Product Categories',
    //   controller: TextEditingController(),
    //   key: '',
    // ),
    // TextFieldModel(
    //   label: 'Brand',
    //   controller: TextEditingController(),
    //   key: '',
    // ),
  ];
}
