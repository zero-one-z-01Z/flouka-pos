import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flouka_pos/features/auth/domain/entities/user_entity.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/models/text_field_model.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../domain/usecases/user_usecases.dart';
import '../views/login_view.dart';
import '../views/register_view.dart';
import '../../../language/presentation/provider/language_provider.dart';

class RegisterProvider extends ChangeNotifier {
  // ── Form keys ─────────────────────────────────────────────────────────────
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>(); // page 1
  final GlobalKey<FormState> registerForm2Key = GlobalKey<FormState>(); // page 2

  UserEntity? userEntity;
  final AuthUseCase userUseCase;

  // ── Step tracking ──────────────────────────────────────────────────────────
  int currentStep = 1; // 1, 2, 3

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

  // ── Page 1 persistent controllers ─────────────────────────────────────────

  // Page 1 field models — getter labels are fine (lazy), controllers are persistent
  List<TextFieldModel> registerTextFieldList = [];

  // ── Account type ───────────────────────────────────────────────────────────
  final List<String> accountTypes = ["company", "personal"];

  String? selectedAccountType;

  void setAccountType(String type) {
    selectedAccountType = type;
    notifyListeners();
  }

  // ── Page 2 persistent controllers ─────────────────────────────────────────
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController bankAccountController = TextEditingController();
  final TextEditingController businessLicenseController = TextEditingController();

  // Page 2 field models — persistent controllers
  List<TextFieldModel> get registerPage2TextFields => [
    TextFieldModel(
      key: 'national_id',
      label: 'National ID Number',
      controller: nationalIdController,
      width: 25.w,
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter ID number' : null,
    ),
    TextFieldModel(
      key: 'city',
      label: 'City',
      controller: cityController,
      width: 25.w,
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter city' : null,
    ),
    TextFieldModel(
      key: 'address',
      label: 'Address',
      width: 25.w,
      controller: addressController,
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter address' : null,
    ),
    TextFieldModel(
      key: 'company_name',
      label: 'Company Name',
      width: 25.w,
      controller: companyNameController,
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'Enter company name' : null,
    ),
    TextFieldModel(
      key: 'bank_account',
      label: 'Bank Account Number',
      controller: bankAccountController,
      width: 25.w,
    ),
    TextFieldModel(
      key: 'business_license',
      label: 'Business License',
      width: 25.w,
      controller: businessLicenseController,
    ),
  ];

  // ── ID images ──────────────────────────────────────────────────────────────
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

  // ── Build data map from persistent controllers ─────────────────────────────
  Future<Map<String, dynamic>> buildRegisterDataMap() async {
    final Map<String, dynamic> data = {
      'national_id_number': nationalIdController.text.trim(),
      'city_id': 1,
      'address': addressController.text.trim(),
      'company_name': companyNameController.text.trim(),
      'bank_account_number': bankAccountController.text.trim(),
      // 'business_license': businessLicenseController.text.trim(),
    };

    for (var element in registerTextFieldList) {
      data[element.key] = element.controller.text;
    }

    if (selectedAccountType != null) {
      data['type'] = "company";
    }

    if (idFront != null) {
      data['front_id_card_image'] = await MultipartFile.fromFile(idFront!.path);
    }
    if (idBack != null) {
      data['back_id_card_image'] = await MultipartFile.fromFile(idBack!.path);
    }

    return data;
  }

  // ── Register ───────────────────────────────────────────────────────────────
  Future<void> register() async {
    // Validate page 2 form first — stop if invalid
    if (!(registerForm2Key.currentState?.validate() ?? false)) return;

    // Advance to step 3 (loading screen) immediately
    nextStep();

    loading();
    try {
      final dataMap = await buildRegisterDataMap();

      // 🔍 Debug: log everything sent to the register API
      log('📤 Register payload: $dataMap', name: 'RegisterProvider');

      final result = await userUseCase.register(dataMap);

      navPop(); // dismiss loading
      result.fold(
        (l) {
          showToast(l.message ?? 'Registration failed');
          previousStep(); // go back to step 2 on failure
        },
        (r) {
          showToast('Registration successful!');
          navPR(const LoginView());
        },
      );
    } catch (e) {
      navPop();
      showToast('Something went wrong: $e');
      previousStep(); // go back to step 2 on error
    }
  }

  void goToRegisterView() {
    registerTextFieldList = [
      TextFieldModel(
          key: 'first_name',
          label: LanguageProvider.translate('inputs', 'first_name'),
          controller: TextEditingController(),
          width: 25.w,
          validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter first name' : null
      ),
      TextFieldModel(
        key: 'last_name',
        label: LanguageProvider.translate('inputs', 'last_name'),
        controller: TextEditingController(),
        width: 25.w,
        validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter last name' : null,
      ),
      TextFieldModel(
        key: 'phone',
        label: LanguageProvider.translate('inputs', 'phone_number'),
        controller: TextEditingController(),
        textInputType: TextInputType.phone,
        width: 25.w,
        validator: (v) =>
        (v == null || v.trim().isEmpty) ? 'Enter phone number' : null,
      ),
      TextFieldModel(
        key: 'email',
        label: LanguageProvider.translate('inputs', 'email'),
        controller: TextEditingController(),
        textInputType: TextInputType.emailAddress,
        width: 25.w,
        validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter email' : null,
      ),
      TextFieldModel(
        key: 'password',
        label: LanguageProvider.translate('inputs', 'password'),
        controller: TextEditingController(),
        textInputType: TextInputType.visiblePassword,
        width: 25.w,
        validator: (v) => (v == null || v.length < 8) ? 'Min 8 characters' : null,
      ),
      TextFieldModel(
        key: 'password_confirmation',
        label: LanguageProvider.translate('inputs', 'confirm_password'),
        controller: TextEditingController(),
        textInputType: TextInputType.visiblePassword,
        width: 25.w,
        validator: (v) {
          if(v != registerTextFieldList.firstWhere((element) => element.key=="password",).controller.text){
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    ];
    navPR(const RegisterView());
  }

  RegisterProvider({required this.userUseCase});

  @override
  void dispose() {
    for(var element in registerTextFieldList){
      element.controller.dispose();
    }
    nationalIdController.dispose();
    cityController.dispose();
    addressController.dispose();
    companyNameController.dispose();
    bankAccountController.dispose();
    businessLicenseController.dispose();
    super.dispose();
  }
}
