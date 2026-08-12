import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flouka_pos/core/constants/app_images.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/dialog/custom_snack_bar.dart';
import 'package:flouka_pos/core/dialog/date_dialog.dart';
import 'package:flouka_pos/core/dialog/success_dialog.dart';
import 'package:flouka_pos/core/helper_function/convert.dart';
import 'package:flouka_pos/core/helper_function/text_form_field_validation.dart';
import 'package:flouka_pos/features/auth/presentation/providers/account_type_provider.dart';
import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flouka_pos/features/auth/presentation/providers/otp_provider.dart';
import 'package:flouka_pos/features/zone/presentation/providers/area_provider.dart';
import 'package:flouka_pos/features/zone/presentation/providers/city_provider.dart';
import 'package:flouka_pos/features/zone/presentation/providers/neighborhood_provider.dart';
import 'package:flutter/material.dart';
import 'package:flouka_pos/features/auth/domain/entities/user_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/dialog/drop_down_dialog.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/image.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/location.dart';
import '../../../../core/models/text_field_model.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../domain/usecases/user_usecases.dart';
import '../views/login_view.dart';
import '../views/register_view.dart';
import '../../../language/presentation/provider/language_provider.dart';

class RegisterProvider extends ChangeNotifier {
  // ── Form keys ─────────────────────────────────────────────────────────────
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>(); // page 1
  final GlobalKey<FormState> registerForm2Key = GlobalKey<FormState>(); // page 2


  final AuthUseCase userUseCase;

  // ── Step tracking ──────────────────────────────────────────────────────────
  int currentStep = 1; // 1, 2, 3

  LatLng? latlng;

  void nextStep() async{
    if(currentStep == 1){
      // OTP is sent when reaching the last page (phone verification last).
      AuthProvider authProvider = Provider.of(Constants.globalContext(),listen: false);
      CityProvider cityProvider = Provider.of(Constants.globalContext(),listen: false);
      AreaProvider areaProvider = Provider.of(Constants.globalContext(),listen: false);
      NeighborhoodProvider neighborhoodProvider = Provider.of(Constants.globalContext(),listen: false);
      final accountType = Constants.globalContext().read<AccountTypeProvider>();
      cityProvider.clear();
      areaProvider.clear();
      neighborhoodProvider.clear();
      unawaited(cityProvider.getCities());
      print("userEntity?.address");
      print(authProvider.userEntity?.address);
      registerPage2TextFields = [
        TextFieldModel(
          key: 'address',
          label: 'address',
          width: 25.w,
          controller: TextEditingController(text: authProvider.userEntity?.address),
          validator: (value) =>validateAddress(value) ,
        ),
        TextFieldModel(
            key: 'open_date',
            label: 'open_date',
            controller: TextEditingController(text: authProvider.userEntity?.openDate),
            readOnly: true,
            width: 25.w,
            validator: (value) => validateOpenDate(value),
            onTap: (){
              selectDate(dateTime: authProvider.userEntity?.openDate==null?null:
              DateTime.parse(authProvider.userEntity!.openDate!),firstDate: DateTime(1900)).then((value){
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
          controller: TextEditingController(text: authProvider.userEntity?.adminName),
          validator: (value) => validatePhone(value),
        ),
        TextFieldModel(
          key: 'admin_phone',
          label: 'admin_phone',
          width: 25.w,
          validator: (value) => validatePhone(value),

          controller: TextEditingController(text: authProvider.userEntity?.adminPhone),
        ),
        TextFieldModel(
          key: 'national_id',
          label: 'national_id',
          controller: TextEditingController(text: authProvider.userEntity?.nationalId),
          width: 25.w,
          validator: (v) =>validateId(v),
        ),
        TextFieldModel(
          key: 'bank_account',
          label: 'bank_account',
          controller: TextEditingController(text: authProvider.userEntity?.bankNumber),
          width: 25.w,
          validator: (v) =>validateBankAccount(v),

        ),
        if(accountType.value()=='individual')...[
          TextFieldModel(
              key: 'city',
              label: 'cities',
              controller: TextEditingController(text: cityProvider.displayedName()),
              readOnly: true,
              width: 25.w,
              onTap: (){
                showDropDownDialog(cityProvider).then((value){
                  cityProvider = Provider.of(Constants.globalContext(),listen: false);
                  int index = registerPage2TextFields.indexWhere((e)=>e.key=='city');
                  print([index,cityProvider.displayedName()]);
                  if(index!=-1){
                    registerPage2TextFields[index].controller.text = cityProvider.displayedName();
                    notifyListeners();
                  }
                });
              }
          ),
          TextFieldModel(
              key: 'area',
              label: 'areas',
              controller: TextEditingController(text: areaProvider.displayedName()),
              readOnly: true,
              width: 25.w,
              onTap: (){
                showDropDownDialog(areaProvider).then((value){
                  areaProvider = Provider.of(Constants.globalContext(),listen: false);
                  int index = registerPage2TextFields.indexWhere((e)=>e.key=='area');
                  if(index!=-1){
                    registerPage2TextFields[index].controller.text = areaProvider.displayedName();
                    notifyListeners();
                  }
                });
              }
          ),
          TextFieldModel(
              key: 'neighborhood',
              label: 'neighborhood',
              controller: TextEditingController(text: neighborhoodProvider.displayedName()),
              readOnly: true,
              width: 25.w,
              onTap: (){
                showDropDownDialog(neighborhoodProvider).then((value){
                  neighborhoodProvider = Provider.of(Constants.globalContext(),listen: false);
                  int index = registerPage2TextFields.indexWhere((e)=>e.key=='neighborhood');
                  if(index!=-1){
                    registerPage2TextFields[index].controller.text = neighborhoodProvider.displayedName();
                    notifyListeners();
                  }
                });
              }
          ),
        ],
      ];

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
  bool acceptedTerms = false;

  void setAcceptedTerms(bool value) {
    acceptedTerms = value;
    notifyListeners();
  }

  TextFieldModel field(String key) {
    for (final list in [registerTextFieldList, registerPage2TextFields]) {
      final i = list.indexWhere((e) => e.key == key);
      if (i != -1) return list[i];
    }
    throw StateError('Unknown register field $key');
  }

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
    if(latlng!=null){
      data['lat'] = latlng!.latitude;
      data['lng'] = latlng!.longitude;
    }
    for (var element in registerPage2TextFields) {
      if(!['city','area','neighborhood'].contains(element.key)){
        data[element.key] = element.controller.text;
      }
    }
    AccountTypeProvider accountTypeProvider = Provider.of(Constants.globalContext(),listen: false);

    if(accountTypeProvider.value()=='individual'){
      CityProvider cityProvider = Provider.of(Constants.globalContext(),listen: false);
      AreaProvider areaProvider = Provider.of(Constants.globalContext(),listen: false);
      NeighborhoodProvider neighborhoodProvider = Provider.of(Constants.globalContext(),listen: false);
      data['neighborhood_id'] = neighborhoodProvider.value();
      data['area_id'] = areaProvider.value();
      data['city_id'] = cityProvider.value();
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

    if(!AuthProvider.isLogin()){
      OtpProvider otpProvider =Provider.of(Constants.globalContext(),listen: false);
      data['otp_type'] = "register";
      data['otp'] = otpProvider.otpController.text;
    }

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
          // nextStep();
        successDialog(msg: LanguageProvider.translate('auth', 'account_under_review'),then: (){
          sharedPreferences.setBool('isStore', false);
          Constants.globalContext().read<AuthProvider>().loginSuccess(r);
        });
        },
      );
    } catch (e) {
      navPop();
      showToast('Something went wrong: $e');
      previousStep(); // go back to step 2 on error
    }
  }



  void updateProfile() async {

    loading();
    try {
      final dataMap = await buildRegisterDataMap();

      final result = await userUseCase.updateProfile(dataMap);

      navPop();
      result.fold(
            (l) {
          showToast(l.message ?? 'Registration failed');
        }, (r) {

              AuthProvider authProvider = Constants.globalContext().read();
              authProvider.updateUser(r);
        successDialog(then: (){
          navPU();
        });
      },
      );
    } catch (e) {
      navPop();
      showToast('Something went wrong: $e');
      previousStep(); // go back to step 2 on error
    }
  }

  void onCameraMoveEnd() {
    notifyListeners();
  }
  Timer? _timer;
  void onCameraMove(CameraPosition position) {
    latlng = position.target;
    if (_timer?.isActive ?? false) return;

    _timer = Timer(
      const Duration(milliseconds: 200),
          () => notifyListeners(),
    );
  }

  void goToRegisterView() async{
    latlng = null;
    currentStep = 1;
    acceptedTerms = false;
    AuthProvider authProvider = Provider.of(Constants.globalContext(),listen: false);
    AccountTypeProvider accountTypeProvider = Provider.of(Constants.globalContext(),listen: false);
    accountTypeProvider.clear();
    UserEntity? userEntity = authProvider.userEntity;
    if(userEntity!=null){
      if(userEntity!.storeEntity?.lat!=null){
        latlng = LatLng(userEntity.storeEntity!.lat!, userEntity.storeEntity!.lng!);
        if (userEntity!.storeEntity!.areaId != null) {
          CityProvider cityProvider = Provider.of(Constants.globalContext(),listen: false);
          AreaProvider areaProvider = Provider.of(Constants.globalContext(),listen: false);
          NeighborhoodProvider neighborhoodProvider = Provider.of(Constants.globalContext(),listen: false);
          final accountType = Constants.globalContext().read<AccountTypeProvider>();
          cityProvider.clear();
          areaProvider.clear();
          neighborhoodProvider.clear();

          cityProvider.cityEntity = cityProvider.cities.firstWhere(
                (element) => element.id == userEntity!.storeEntity!.cityId,
          );
          await areaProvider.getArea(id: cityProvider.cityEntity!.id, fromAddress: true);
          areaProvider.areaEntity = areaProvider.areas.firstWhere(
                (element) => element.id == userEntity!.storeEntity!.areaId,
          );
          await neighborhoodProvider.getNeighborhood(id: areaProvider.areaEntity!.id, fromAddress: true);
          neighborhoodProvider.neighborhood = neighborhoodProvider.neighborhoods.firstWhere(
                (element) => element.id == userEntity!.storeEntity!.neighborhoodId,
          );
        }
      }
      accountTypeProvider.onTap(userEntity!.accountType);



    }else{
      accountTypeProvider.onTap('individual');
    }
    registerTextFieldList = [
      TextFieldModel(
          key: 'name',
          label: "name",
          controller: TextEditingController(text: userEntity?.name),
          width: 25.w,
          validator: (value) => validateName(value),
      ),
      TextFieldModel(
        key: 'bio',
        label: "bio",
        controller: TextEditingController(text: userEntity?.bio),
        width: 25.w,
        validator: (value) => validateBio(value),
      ),
      TextFieldModel(
        key: 'phone',
        label: "phone_number",
        controller: TextEditingController(text: userEntity?.phone),
        textInputType: TextInputType.phone,
        width: 25.w,
        validator: (value) => validatePhone(value),
      ),
      TextFieldModel(
        key: 'email',
        label: 'email',
        controller: TextEditingController(text: userEntity?.email),
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
        validator: (value) {
          if(userEntity!=null){
            return null;
          }
          return validatePassword(value);
        },
      ),
      if(!AuthProvider.isLogin())TextFieldModel(
          key: 'account_type',
          label: 'account_type',
          controller: TextEditingController(text: accountTypeProvider.displayedName()),
          readOnly: true,
          width: 25.w,
          onTap: (){
            showDropDownDialog(accountTypeProvider).then((value){
              accountTypeProvider = Provider.of(Constants.globalContext(),listen: false);
              int index = registerTextFieldList.indexWhere((e)=>e.key=='account_type');
              if(index!=-1){
                registerTextFieldList[index].controller.text = accountTypeProvider.displayedName();
                notifyListeners();
              }
            });
          }
      ),
      // TextFieldModel(
      //   key: 'password_confirmation',
      //   label: 'confirm_password',
      //   obscureText: true,
      //
      //   controller: TextEditingController(),
      //   textInputType: TextInputType.visiblePassword,
      //   width: 25.w,
      //   validator: (v) {
      //     if(v != registerTextFieldList.firstWhere((element) => element.key=="password",).controller.text){
      //       return 'Passwords do not match';
      //     }
      //     return null;
      //   },
      // ),
    ];
    logo = null;
    cover = null;
    frontIdCard = null;
    backIdCard = null;
    businessLicense = null;
    navP(const RegisterView());
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
  File? frontIdCard;
  File? backIdCard;
  File? businessLicense;



  // bool logoUpdated = false;
  // bool coverUpdated = false;
  // bool frontIdCardUpdated = false;
  // bool backIdCardUpdated=false;
  // bool businessLicenseUpdate=false;


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
  // Future selectFrontIdCardImage() async {
  //   FocusScope.of(Constants.globalContext()).unfocus();
  //   XFile? image = await chooseImage();
  //   if (image != null) {
  //     updateFrontIdCard(image);
  //   }
  // }
  // Future selectBackIdCardImage() async {
  //   FocusScope.of(Constants.globalContext()).unfocus();
  //   XFile? image = await chooseImage();
  //   if (image != null) {
  //     updateBackIdCard(image);
  //   }
  // }
  // Future selectBusinessLicenseImage() async {
  //   FocusScope.of(Constants.globalContext()).unfocus();
  //   XFile? image = await chooseImage();
  //   if (image != null) {
  //     updateBusinessLicense(image);
  //   }
  // }


  void selectFrontIdCardImage(File file) {
    frontIdCard = file;
    notifyListeners();
  }

  void selectBackIdCardImage(File file) {
    backIdCard = file;
    notifyListeners();
  }

  void selectBusinessLicenseImage(File file) {
    businessLicense = file;
    notifyListeners();
  }

  void removeFrontIdCard() {
    frontIdCard = null;
    notifyListeners();
  }

  void removeBackIdCard() {
    backIdCard = null;
    notifyListeners();
  }

  void removeBusinessLicense() {
    businessLicense = null;
    notifyListeners();
  }
  Future selectCoverImage() async {
    FocusScope.of(Constants.globalContext()).unfocus();
    XFile? image = await chooseImage();
    if (image != null) {
      updateCover(image);
    }
  }


  void updateLogo(XFile image) {
    // logoUpdated = true;
    this.logo = image;
    notifyListeners();
  }

  // void updateFrontIdCard(XFile image) {
  //   // frontIdCardUpdated = true;
  //   this.frontIdCard = image;
  //   notifyListeners();
  // }
  //
  // void updateBackIdCard(XFile image) {
  //   // backIdCardUpdated = true;
  //   this.backIdCard = image;
  //   notifyListeners();
  // }
  //
  // void updateBusinessLicense(XFile image) {
  //   // businessLicenseUpdate = true;
  //   this.businessLicense = image;
  //   notifyListeners();
  // }

  void updateCover(XFile image) {
    // coverUpdated = true;
    this.cover = image;
    notifyListeners();
  }



  TextEditingController passwordController = TextEditingController();
  void showPasswordDialog({bool isDismissible =false}){
    showDialog(
      context: Constants.globalContext(),
      barrierDismissible: isDismissible,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          // contentPadding: const EdgeInsets.all(20),
          child: InkWell(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Container(
              width: 40.w,height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Column(mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LanguageProvider.translate("auth", "assign_password"),
                    textAlign: TextAlign.center,
                    style: TextStyleClass.semiHeadStyle(),
                  ),
                  SizedBox(height: 2.h,),
                  TextFieldWidget(controller: passwordController, color: Colors.grey.shade200,
                    borderColor: Colors.grey.shade200,width: 30.w,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                    child: ButtonWidget(
                      onTap: (){
                        if(passwordController.text.isNotEmpty && passwordController.text.length>5){
                          updatePassword();
                        }else{
                          showToast(LanguageProvider.translate("validation", "enter_pass"));
                        }
                      },
                      text:  "save",
                    ),
                  ),
                ],
              ),
            ),
          ),

        );
      },
    );
  }

  Future updatePassword() async {
    Map<String, dynamic> data = {};
    data['password']= passwordController.text;
    loading();
    var login = await userUseCase.updateProfile(data);
    navPop();
    login.fold((l) {
      showToast(l.message!);
    }, (r) async {
      navPop();
      successDialog();
      // sharedPreferences.setString('checker_pass', passwordController.text);
    });
  }


}
