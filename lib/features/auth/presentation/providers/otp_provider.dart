import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flouka_pos/features/auth/presentation/providers/register_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/custom_snack_bar.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../../core/helper_function/text_form_field_validation.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/user_usecases.dart';
import 'auth_provider.dart';

class OtpProvider extends ChangeNotifier {
  String? hashedCode;
  int counter = 60 * 5;
  Timer? timer;
  TextEditingController otpController = TextEditingController();
  bool lastSendOk = false;
  bool emailed = false;

  Future reSend() async {
    startTimer();
    await sendOtp(isResend: true, isReg: true);
  }

  void checkCode({required bool login, bool changePhone = false}) async {
    AuthProvider authProvider =
        Provider.of(Constants.globalContext(), listen: false);
    Map<String, dynamic> data = {};
    data['code'] = otpController.text;
    data['hashed_code'] = hashedCode;
    data['phone'] = otpNumber;
    data['token'] = kIsWeb
        ? '123'
        : (await FirebaseMessaging.instance.getToken() ?? "123");
    if (!changePhone) {
      if (login) {
        data['register'] = 1;
      } else {
        data['reset_password'] = 1;
      }
    }
  }

  void startTimer() {
    counter = 60 * 5;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (e) {
      if (timer?.isActive ?? false) {
        try {
          counter--;
          notifyListeners();
        } catch (e) {
          debugPrint("$e");
        }
      }
      if (counter == 0) {
        e.cancel();
      }
    });
    notifyListeners();
  }

  String otpNumber = '';

  String _normalizeTnPhone(String raw) {
    var d = raw.replaceAll(RegExp(r'\D'), '');
    if (d.startsWith('0')) d = d.substring(1);
    if (d.isNotEmpty && !d.startsWith('216')) d = '216$d';
    return d;
  }

  /// Returns true when API accepted the OTP send.
  Future<bool> sendOtp({bool? isResend, bool isReg = false}) async {
    lastSendOk = false;
    emailed = false;
    Map<String, dynamic> data = {};
    if (isReg) loading();
    RegisterProvider registerProvider =
        Provider.of(Constants.globalContext(), listen: false);
    if (isReg) {
      final phoneCtrl = registerProvider.registerTextFieldList
          .firstWhere((element) => element.key == "phone")
          .controller;
      otpNumber = _normalizeTnPhone(phoneCtrl.text);
      phoneCtrl.text = otpNumber;

      final email = registerProvider.registerTextFieldList
          .firstWhere((element) => element.key == "email")
          .controller
          .text
          .trim();
      final name = registerProvider.registerTextFieldList
          .firstWhere((element) => element.key == "name")
          .controller
          .text
          .trim();
      data['email'] = email;
      data['name'] = name;
    }
    data['phone'] = otpNumber;
    Either<DioException, String> login =
        await AuthUseCase(sl()).sendOtp(data);
    if (isReg) navPop();
    login.fold((l) {
      lastSendOk = false;
      showToast(l.message ?? "");
    }, (r) async {
      lastSendOk = true;
      emailed = true;
      hashedCode = r;
      startTimer();
      if (isResend == null) {
        otpController = TextEditingController();
      }
      notifyListeners();
    });
    return lastSendOk;
  }
}
