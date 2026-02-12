import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../core/models/text_field_model.dart';
import '../../../../core/helper_function/navigation.dart';
import '../views/register_view.dart';
import '../../../language/presentation/provider/language_provider.dart';

class RegisterProvider extends ChangeNotifier {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  // Step tracking
  int currentStep = 1; // 1,2,3

  // Text fields (all fields are on step 1)
  final List<TextFieldModel> registerTextFieldList = [
    TextFieldModel(
      key: 'first_name',
      label: LanguageProvider.translate('inputs', 'first_name'),
      controller: TextEditingController(),
      validator: (value) => value?.isEmpty ?? true ? 'Enter first name' : null,
    ),
    TextFieldModel(
      key: 'last_name',
      label: LanguageProvider.translate('inputs', 'last_name'),
      controller: TextEditingController(),
      validator: (value) => value?.isEmpty ?? true ? 'Enter last name' : null,
    ),
    TextFieldModel(
      key: 'phone',
      label: LanguageProvider.translate('inputs', 'phone_number'),
      controller: TextEditingController(),
      validator: (value) => value?.isEmpty ?? true ? 'Enter phone' : null,
    ),
    TextFieldModel(
      key: 'email',
      label: LanguageProvider.translate('inputs', 'email'),
      controller: TextEditingController(),
      validator: (value) => value?.isEmpty ?? true ? 'Enter email' : null,
    ),
    TextFieldModel(
      key: 'password',
      label: LanguageProvider.translate('inputs', 'password'),
      controller: TextEditingController(),
      validator: (value) => value?.isEmpty ?? true ? 'Enter password' : null,
    ),
    TextFieldModel(
      key: 'password_confirmation',
      label: LanguageProvider.translate('inputs', 'confirm_password'),
      controller: TextEditingController(),
      validator: (value) => value?.isEmpty ?? true ? 'Confirm password' : null,
    ),
  ];

  // Account type (for step 2 or 3)
  final List<String> accountTypes = ["Admin", "Merchant", "Cashier"];
  String? selectedAccountType;

  void setAccountType(String type) {
    selectedAccountType = type;
    notifyListeners();
  }

  void nextStep() {
    if (currentStep < 3) {
      currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (currentStep > 1) {
      currentStep--;
      notifyListeners();
    }
  }

  void goToRegisterView() {
    navPR(const RegisterView());
  }

  File? idFront;
  File? idBack;

  void setIdFront(File? file) {
    idFront = file;
    notifyListeners();
  }

  void setIdBack(File? file) {
    idBack = file;
    notifyListeners();
  }

  List<TextFieldModel> registerPage2TextFields = [
    TextFieldModel(key: 'national_id', label: 'National ID Number', controller: TextEditingController(), validator: (value) => value?.isEmpty ?? true ? 'Enter ID number' : null),
    TextFieldModel(key: 'city', label: 'City', controller: TextEditingController(), validator: (value) => value?.isEmpty ?? true ? 'Enter city' : null),
    TextFieldModel(key: 'address', label: 'Address', controller: TextEditingController(), validator: (value) => value?.isEmpty ?? true ? 'Enter address' : null),
    TextFieldModel(key: 'company_name', label: 'Company Name', controller: TextEditingController(), validator: (value) => value?.isEmpty ?? true ? 'Enter company name' : null),
    TextFieldModel(key: 'bank_account', label: 'Bank Account Number',  controller: TextEditingController()),
    TextFieldModel(key: 'business_license', label: 'Business License', controller: TextEditingController()),
  ];
}
