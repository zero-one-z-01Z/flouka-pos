import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flouka_pos/features/auth/domain/entities/user_entity.dart';
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
  final GlobalKey<FormState> registerForm2Key =
      GlobalKey<FormState>(); // page 2

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
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Page 1 field models — getter labels are fine (lazy), controllers are persistent
  List<TextFieldModel> get registerTextFieldList => [
    TextFieldModel(
      key: 'first_name',
      label: LanguageProvider.translate('inputs', 'first_name'),
      controller: firstNameController,
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'Enter first name' : null,
    ),
    TextFieldModel(
      key: 'last_name',
      label: LanguageProvider.translate('inputs', 'last_name'),
      controller: lastNameController,
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'Enter last name' : null,
    ),
    TextFieldModel(
      key: 'phone',
      label: LanguageProvider.translate('inputs', 'phone_number'),
      controller: phoneController,
      textInputType: TextInputType.phone,
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'Enter phone number' : null,
    ),
    TextFieldModel(
      key: 'email',
      label: LanguageProvider.translate('inputs', 'email'),
      controller: emailController,
      textInputType: TextInputType.emailAddress,
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter email' : null,
    ),
    TextFieldModel(
      key: 'password',
      label: LanguageProvider.translate('inputs', 'password'),
      controller: passwordController,
      textInputType: TextInputType.visiblePassword,
      validator: (v) => (v == null || v.length < 6) ? 'Min 6 characters' : null,
    ),
    TextFieldModel(
      key: 'password_confirmation',
      label: LanguageProvider.translate('inputs', 'confirm_password'),
      controller: confirmPasswordController,
      textInputType: TextInputType.visiblePassword,
      validator: (v) =>
          v != passwordController.text ? 'Passwords do not match' : null,
    ),
  ];

  // ── Account type ───────────────────────────────────────────────────────────
  final List<String> accountTypes = ["Admin", "Merchant", "Cashier"];
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
  final TextEditingController businessLicenseController =
      TextEditingController();

  // Page 2 field models — persistent controllers
  List<TextFieldModel> get registerPage2TextFields => [
    TextFieldModel(
      key: 'national_id',
      label: 'National ID Number',
      controller: nationalIdController,
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'Enter ID number' : null,
    ),
    TextFieldModel(
      key: 'city',
      label: 'City',
      controller: cityController,
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter city' : null,
    ),
    TextFieldModel(
      key: 'address',
      label: 'Address',
      controller: addressController,
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'Enter address' : null,
    ),
    TextFieldModel(
      key: 'company_name',
      label: 'Company Name',
      controller: companyNameController,
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'Enter company name' : null,
    ),
    TextFieldModel(
      key: 'bank_account',
      label: 'Bank Account Number',
      controller: bankAccountController,
    ),
    TextFieldModel(
      key: 'business_license',
      label: 'Business License',
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
      'first_name': firstNameController.text.trim(),
      'last_name': lastNameController.text.trim(),
      'phone': phoneController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
      'password_confirmation': confirmPasswordController.text.trim(),
      'national_id': nationalIdController.text.trim(),
      'city': cityController.text.trim(),
      'address': addressController.text.trim(),
      'company_name': companyNameController.text.trim(),
      'bank_account': bankAccountController.text.trim(),
      'business_license': businessLicenseController.text.trim(),
    };

    if (selectedAccountType != null) {
      data['type'] = selectedAccountType;
    }

    if (idFront != null) {
      data['front_id_card_image'] = base64Encode(await idFront!.readAsBytes());
    }
    if (idBack != null) {
      data['back_id_card_image'] = base64Encode(await idBack!.readAsBytes());
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
    navPR(const RegisterView());
  }

  RegisterProvider({required this.userUseCase});

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nationalIdController.dispose();
    cityController.dispose();
    addressController.dispose();
    companyNameController.dispose();
    bankAccountController.dispose();
    businessLicenseController.dispose();
    super.dispose();
  }
}
