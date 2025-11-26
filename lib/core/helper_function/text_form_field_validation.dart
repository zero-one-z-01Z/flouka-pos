import '../../features/language/presentation/provider/language_provider.dart';

final RegExp emailValid = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);

bool validEnglish(String value) {
  RegExp regex = RegExp(r'/^[A-Za-z0-9]*$');
  return (regex.hasMatch(value));
}

String? validatePhone(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "phone_required");
  }
  if (value.length < 5) {
    return LanguageProvider.translate("validation", "phone_invalid");
  }
  if (validEnglish(value)) {
    return LanguageProvider.translate("validation", "english_phone");
  }
  return null;
}

String? validateName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "name_required");
  }
  return null;
}

String? validateEmail(String? value) {
  if (!emailValid.hasMatch(value!)) {
    if (value.isEmpty) {
      return LanguageProvider.translate("validation", "empty_email");
    } else {
      return LanguageProvider.translate("validation", "incorrect_email");
    }
  }
  return null;
}

String? validateOtp(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "otp_required");
  }
  return null;
}

String? validatePassword(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "password_required");
  }
  return null;
}

String validateCity() {
  return LanguageProvider.translate("validation", "government");
}

String validateAddress() {
  return LanguageProvider.translate("validation", "address");
}

String validateArea() {
  return LanguageProvider.translate("validation", "area");
}

String? validatePart() {
  return LanguageProvider.translate("validation", "part");
}

String? validateFirstName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "first_name");
  }
  return null;
}

String? validateLastName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "last_name");
  }
  return null;
}

String? validateApartment(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "apartment");
  }
  return null;
}

String? validateBuilding(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "building");
  }
  return null;
}

String? validateAddressName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "address_name");
  }
  return null;
}

String? validateStreetName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "street_name");
  }
  return null;
}

String? validateConfirmPassword(String? value, String? confirmPassword) {
  if (value == null || value.isEmpty) {
    return LanguageProvider.translate("validation", "please_retype_password");
  }
  if (value != confirmPassword) {
    return LanguageProvider.translate("validation", "confirm_password");
  }
  return null;
}
