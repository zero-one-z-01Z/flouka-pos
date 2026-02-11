import 'package:flouka_pos/features/auth/presentation/views/register_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper_function/navigation.dart';
import '../../../../core/models/text_field_model.dart';

class RegisterProvider extends ChangeNotifier {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final List<TextFieldModel> registerTextFieldList = [
    TextFieldModel(
      key: 'first_name',
      controller: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
    ),
    TextFieldModel(
      key: 'last_name',
      controller: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    ),
    TextFieldModel(
      key: 'phone',
      controller: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone';
        }
        return null;
      },
    ),
    TextFieldModel(
      key: 'email',
      controller: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    ),
    TextFieldModel(
      key: 'password',
      controller: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    ),
    TextFieldModel(
      key: 'password_confirmation',
      controller: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    ),
  ];

  void goToRegisterView() {
    navPR(const RegisterView());
  }
}
