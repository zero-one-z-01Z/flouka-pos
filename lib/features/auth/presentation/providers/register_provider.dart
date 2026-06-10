import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flouka_pos/core/constants/app_images.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/dialog/date_dialog.dart';
import 'package:flouka_pos/core/helper_function/convert.dart';
import 'package:flouka_pos/core/helper_function/text_form_field_validation.dart';
import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flouka_pos/features/auth/presentation/providers/otp_provider.dart';
import 'package:flutter/material.dart';
import 'package:flouka_pos/features/auth/domain/entities/user_entity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/image.dart';
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

  void nextStep() async{
    if(currentStep == 1){
      OtpProvider otpProvider = Provider.of(Constants.globalContext(),listen: false);
      await otpProvider.sendOtp(isReg: true);
    }
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

  // Page 2 field models — persistent controllers
  List<TextFieldModel>  registerPage2TextFields = [];
  TextEditingController controller =TextEditingController();

  // ── Build data map from persistent controllers ─────────────────────────────
  Future<Map<String, dynamic>> buildRegisterDataMap() async {
    final Map<String, dynamic> data = {};
    for (var element in registerTextFieldList) {
      if(element.key != "password_confirmation"){
        data[element.key] = element.controller.text;
      }
    }

    for (var element in registerPage2TextFields) {
      data[element.key] = element.controller.text;
    }

    if (logo != null) {
      data['logo'] = await MultipartFile.fromFile(logo!.path);
    }
    if (cover != null) {
      data['cover'] = await MultipartFile.fromFile(cover!.path);
    }
    if (frontIdCard != null) {
      data['front_id_card'] = await MultipartFile.fromFile(frontIdCard!.path);
    }
    if (backIdCard != null) {
      data['back_id_card'] = await MultipartFile.fromFile(backIdCard!.path);
    }
    if (businessLicense != null) {
      data['business_license'] = await MultipartFile.fromFile(businessLicense!.path);
    }

    OtpProvider otpProvider =Provider.of(Constants.globalContext(),listen: false);
    data['otp_type'] = "register";
    data['otp'] = otpProvider.otpController.text;

    return data;
  }

  // ── Register ───────────────────────────────────────────────────────────────
  Future<void> register() async {

    loading();
    try {
      final dataMap = await buildRegisterDataMap();

      final result = await userUseCase.checkCode(dataMap);

      navPop(); // dismiss loading
      result.fold(
        (l) {
          showToast(l.message ?? 'Registration failed');
        }, (r) {
          nextStep();
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
          key: 'name',
          label: "name",
          controller: TextEditingController(),
          width: 25.w,
          validator: (value) => validateName(value),
      ),
      TextFieldModel(
        key: 'bio',
        label: "bio",
        controller: TextEditingController(),
        width: 25.w,
        validator: (value) => validateBio(value),
      ),
      TextFieldModel(
        key: 'phone',
        label: "phone_number",
        controller: TextEditingController(),
        textInputType: TextInputType.phone,
        width: 25.w,
        validator: (value) => validatePhone(value),
      ),
      TextFieldModel(
        key: 'email',
        label: 'email',
        controller: TextEditingController(),
        textInputType: TextInputType.emailAddress,
        width: 25.w,
        validator: (value) => validateEmail(value),
      ),
      TextFieldModel(
        key: 'password',
        label: 'password',
        controller: TextEditingController(),
        textInputType: TextInputType.visiblePassword,
        obscureText: true,
        width: 25.w,
        validator: (value) => validatePassword(value),
      ),
      TextFieldModel(
        key: 'password_confirmation',
        label: 'confirm_password',
        obscureText: true,

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
    registerPage2TextFields = [
      TextFieldModel(
        key: 'address',
        label: 'Address',
        width: 25.w,
        controller: TextEditingController(),
        validator: (value) =>validateAddress(value) ,
      ),
      TextFieldModel(
          key: 'open_date',
          label: 'open_date',
          controller: TextEditingController(),
          readOnly: true,
          width: 25.w,
          validator: (value) => validateOpenDate(value),
          onTap: (){
            selectDate().then((value){
              if(value !=null){
                registerPage2TextFields.firstWhere((element) => element.key=="open_date",)
                    .controller.text = convertDateToStringYMD(value);
              }
            });
          }
      ),
      TextFieldModel(
        key: 'admin_name',
        label: 'admin_name',
        width: 25.w,
        controller: TextEditingController(),
        validator: (value) => validatePhone(value),
      ),
      TextFieldModel(
        key: 'admin_phone',
        label: 'admin_phone',
        width: 25.w,
        validator: (value) => validatePhone(value),

        controller: TextEditingController(),
      ),
      TextFieldModel(
        key: 'national_id',
        label: 'national_id',
        controller: TextEditingController(),
        width: 25.w,
        validator: (v) =>validateId(v),
      ),
      TextFieldModel(
        key: 'bank_account',
        label: 'Bank Account Number',
        controller: TextEditingController(),
        width: 25.w,
        validator: (v) =>validateBankAccount(v),

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
    for(var element in registerPage2TextFields){
      element.controller.dispose();
    }
    super.dispose();
  }


  XFile? logo;
  XFile? cover;
  XFile? frontIdCard;
  XFile? backIdCard;
  XFile? businessLicense;
  bool logoUpdated = false;
  bool coverUpdated = false;
  bool frontIdCardUpdated = false;
  bool backIdCardUpdated=false;
  bool businessLicenseUpdate=false;


  showLogoImage() {
    AuthProvider authProvider = Provider.of(Constants.globalContext(),listen: false);
    if (authProvider.userEntity?.logo != null || logo != null) {
      if (logo != null) {
        return FileImage(File(logo!.path));
      } else {
        return CachedNetworkImageProvider(authProvider.userEntity!.logo!);
      }
    } else {
      return const AssetImage(Images.floukaLogo);
    }
  }

  showCoverImage() {
    AuthProvider authProvider = Provider.of(Constants.globalContext(),listen: false);
    if (authProvider.userEntity?.cover != null || cover != null) {
      if (cover != null) {
        return FileImage(File(cover!.path));
      } else if (authProvider.userEntity?.cover != null) {
        return CachedNetworkImageProvider(authProvider.userEntity!.cover!);
      }
    } else {
      return const AssetImage(Images.floukaLogo);
    }
  }
  showBackIdCardImage() {
    AuthProvider authProvider = Provider.of(Constants.globalContext(),listen: false);
    if (authProvider.userEntity?.backIdCard != null ||backIdCard != null) {
      if (backIdCard != null) {
        return FileImage(File(backIdCard!.path));
      } else if (authProvider.userEntity?.backIdCard != null) {
        return CachedNetworkImageProvider(authProvider.userEntity!.backIdCard!);
      }
    } else {
      return const AssetImage(Images.floukaLogo);
    }
  }

  showFrontIdCardImage() {
    AuthProvider authProvider = Provider.of(Constants.globalContext(),listen: false);
    if (authProvider.userEntity?.frontIdCard != null ||frontIdCard != null) {
      if (frontIdCard != null) {
        return FileImage(File(frontIdCard!.path));
      } else if (authProvider.userEntity?.frontIdCard != null) {
        return CachedNetworkImageProvider(authProvider.userEntity!.frontIdCard!);
      }
    } else {
      return const AssetImage(Images.floukaLogo);
    }
  }

  showBusinessLicenseImage() {
    AuthProvider authProvider = Provider.of(Constants.globalContext(),listen: false);
    if (authProvider.userEntity?.businessLicense != null ||businessLicense != null) {
      if (businessLicense != null) {
        return FileImage(File(businessLicense!.path));
      } else if (authProvider.userEntity?.businessLicense != null) {
        return CachedNetworkImageProvider(authProvider.userEntity!.businessLicense!);
      }
    } else {
      return const AssetImage(Images.floukaLogo);
    }
  }

  Future selectLogoImage() async {
    FocusScope.of(Constants.globalContext()).unfocus();
    XFile? image = await chooseImage();
    if (image != null) {
      updateLogo(image);
    }
  }

  Future selectFrontIdCardImage() async {
    FocusScope.of(Constants.globalContext()).unfocus();
    XFile? image = await chooseImage();
    if (image != null) {
      updateFrontIdCard(image);
    }
  }

  Future selectBackIdCardImage() async {
    FocusScope.of(Constants.globalContext()).unfocus();
    XFile? image = await chooseImage();
    if (image != null) {
      updateBackIdCard(image);
    }
  }


  Future selectCoverImage() async {
    FocusScope.of(Constants.globalContext()).unfocus();
    XFile? image = await chooseImage();
    if (image != null) {
      updateCover(image);
    }
  }

  Future selectBusinessLicenseImage() async {
    FocusScope.of(Constants.globalContext()).unfocus();
    XFile? image = await chooseImage();
    if (image != null) {
      updateBusinessLicense(image);
    }
  }
  void updateLogo(XFile image) {
    logoUpdated = true;
    this.logo = image;
    notifyListeners();
  }

  void updateFrontIdCard(XFile image) {
    frontIdCardUpdated = true;
    this.frontIdCard = image;
    notifyListeners();
  }

  void updateBackIdCard(XFile image) {
    backIdCardUpdated = true;
    this.backIdCard = image;
    notifyListeners();
  }

  void updateBusinessLicense(XFile image) {
    businessLicenseUpdate = true;
    this.businessLicense = image;
    notifyListeners();
  }

  void updateCover(XFile image) {
    coverUpdated = true;
    this.cover = image;
    notifyListeners();
  }


}
