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

String? validateCouponName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "coupon_name");
  }
  return null;
}

String? validateOfferName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "offer_name");
  }
  return null;
}


String? validateCouponCode(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "coupon_code");
  }
  return null;
}

String? validateMin(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "min");
  }
  return null;
}

String? validateMax(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "max");
  }
  return null;
}

String? validateCount(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "count");
  }
  return null;
}

String? validateTitle(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "title_required");
  }
  return null;
}

String? validateDescription(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "description_required");
  }
  return null;
}

String? validatePrice(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "price_required");
  }
  return null;
}

String? validateCostPrice(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "price_cost_required");
  }
  return null;
}

String? validateOfferPrice(String? value) {
  if (value!.isNotEmpty && num.tryParse(value) == null) {
    return LanguageProvider.translate("validation", "value_invalid");
  }
  return null;
}


String? validateSku(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "sku_required");
  }
  return null;
}

String? validateBio(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "bio");
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

String? validateAddress(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "address");
  }
  return null;

}
String? validateOpenDate(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "open_date");
  }
  return null;
}

String? validateAdminName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "admin_name");
  }
  return null;
}

String? validateId(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "national_id");
  }
  return null;
}


String? validateBankAccount(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "bank_account");
  }
  return null;
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


String? validateUserName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "store_user_name");
  }
  return null;
}