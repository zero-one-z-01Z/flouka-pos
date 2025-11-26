// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/dialog/confirm_dialog.dart';
import '../../../../core/dialog/confirm_pop_up_dialog.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/api.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../../core/helper_function/text_form_field_validation.dart';
import '../../../../core/models/text_field_model.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/user_usecases.dart';
import '../views/login_view.dart';

class AuthProvider extends ChangeNotifier {
  UserEntity? userEntity;
  final AuthUseCase userUseCase;

  bool isUser = true;

  AuthProvider(this.userUseCase);

  void goToLoginView() {
    navPR(const LoginView());
  }

  /// ----------- Login Logic -----------
  Future<void> socialLogin({required String loginFrom}) async {
    Map<String, dynamic> data = {};
    data['login_from'] = loginFrom;
    if (loginFrom == 'google') {
      data['name'] = googleUser!.displayName;
      data['email'] = googleUser!.email;
      data['image'] = googleUser!.photoUrl;
    }
    data['token'] = await FirebaseMessaging.instance.getToken() ?? "123";
    loading();
    final result = await userUseCase.socialLogin(data);
    navPop();
    result.fold((l) => showToast(l.message!), (r) {
      loginSuccess(r);
      userEntity = r;
    });
  }

  Future<void> deleteAccount() async {
    loading();
    await userUseCase.deleteAccount();
    await sharedPreferences.remove('token');
    navPop();
    ApiHandel.getInstance.updateHeader('');
    goToLoginView();
  }

  void loginSuccess(UserEntity userEntity) {
    if (userEntity.token != null) {
      ApiHandel.getInstance.updateHeader(userEntity.token!);
      sharedPreferences.setString('token', userEntity.token!);
    }
  }

  void rebuild() {
    notifyListeners();
  }

  /// ----------- Google Login (new API v7) -----------
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  GoogleSignInAccount? googleUser;
  bool _isGoogleInitialized = false;

  Future<void> _initGoogle() async {
    if (!_isGoogleInitialized) {
      await _googleSignIn.initialize();
      _isGoogleInitialized = true;
    }
  }

  Future<void> googleLogin() async {
    await _initGoogle();
    try {
      await _googleSignIn.signOut();
      googleUser = await _googleSignIn.authenticate();
      log("message");
      socialLogin(loginFrom: 'google');
    } catch (error) {
      log(error.toString());
    }
  }

  Future getProfile() async {
    final result = await userUseCase.getProfile();
    result.fold(
      (l) {
        showToast(l.message!);
        if (userEntity == null) {
          goToLoginView();
        }
      },
      (r) {
        loginSuccess(r);
      },
    );
  }

  Future refreshToken() async {
    String token = sharedPreferences.getString('token')!;
    Map<String, dynamic> data = {'token': token};
    final result = await userUseCase.refreshToken(data);
    result.fold((l) => showToast(l.message!), (r) {
      sharedPreferences.setString('token', r);
      ApiHandel.getInstance.updateHeader(r);
    });
  }

  showLogoutDialog() {
    showPopUpDialog(
      title: LanguageProvider.translate('global', 'تسجيل الخروج'),
      onConfirm: () {
        final result = userUseCase.logout({
          "token": FirebaseMessaging.instance.getToken(),
        });
        successLogout();
      },
    );
  }

  List<TextFieldModel> loginTextFieldList = [
    TextFieldModel(
      label: LanguageProvider.translate("inputs", "Number"),
      key: "name",
      controller: TextEditingController(),
      textInputType: TextInputType.name,
      validator: (value) => validatePhone(value),
    ),
    TextFieldModel(
      label: LanguageProvider.translate("inputs", "Password"),
      controller: TextEditingController(),
      textInputType: const TextInputType.numberWithOptions(),
      validator: (value) => validatePassword(value),
      key: "phone",
    ),
  ];

  List<TextFieldModel> registerTextFieldList = [
    TextFieldModel(
      label: LanguageProvider.translate("inputs", "Number"),
      controller: TextEditingController(),
      textInputType: const TextInputType.numberWithOptions(),
      validator: (value) => validatePhone(value),
      key: "phone",
    ),
  ];

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  Future<void> login() async {
    Map<String, dynamic> data = {};
    data["token"] = await FirebaseMessaging.instance.getToken() ?? "123";
    for (var element in loginTextFieldList) {
      data[element.key] = element.controller.text.trim();
    }
    loading();
    final result = await userUseCase.login(data);
    navPop();
    result.fold(
      (l) {
        showToast(l.message!);
      },
      (r) {
        loginSuccess(r);
      },
    );
  }

  void successLogout() {
    sharedPreferences.remove('login');
    sharedPreferences.remove('phone');
    sharedPreferences.remove('token');
    userEntity = null;
    goToLoginView();
  }

  void confirmDeleteAccount() {
    confirmDialog(
      LanguageProvider.translate('settings', "delete_account"),
      LanguageProvider.translate('settings', "delete"),
      () {
        deleteAccount();
      },
    );
  }
}
