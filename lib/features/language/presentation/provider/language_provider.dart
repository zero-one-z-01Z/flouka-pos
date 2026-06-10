import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/dialog/custom_alert_dialog.dart';
import '../../../../../core/helper_function/api.dart';
import '../../../../../core/helper_function/prefs.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../splash/views/splash_view.dart';
import '../../domain/use_cases/translate_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  late Locale
  language; // use this var when control state of language widget then use it for change language
  Locale _appLocale = const Locale('en');
  static const List<Locale> languages = [Locale('ar', ''), Locale("en", "")];
  Locale get appLocal => _appLocale;
  static String? languageCode() {
    return sharedPreferences.getString('language_code');
  }

  static bool isAr() {
    return languageCode() == 'ar';
  }

  Future<String?> checkLanguageCode() async {
    String? language = sharedPreferences.getString('language_code');
    return language;
  }

  static TextDirection direction() {
    if (sharedPreferences.getString("language_code") == "ar") {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }

  Future fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('language_code');
    _appLocale = Locale(language ?? "en");
    notifyListeners();
  }

  Future changeLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    _appLocale = language;
    await prefs.setString('language_code', language.languageCode);
    notifyListeners();
    afterChangeLanguage();
  }

  void setLanguage(Locale locale, {bool rebuild = true}) {
    language = locale;
    if (rebuild) notifyListeners();
  }

  void rebuild() {
    notifyListeners();
  }

  String getTranslate(String key, value) {
    Map localizedStrings =
        ApiHandel.getInstance.languages[_appLocale.languageCode];
    if (localizedStrings.containsKey(key) &&
        localizedStrings[key].containsKey(value)) {
      return localizedStrings[key][value];
    }
    return value;
  }

  static String translate(String key, String value) {
    // ignore: unused_local_variable
    LanguageProvider languageCubit = Provider.of(
      Constants.globalContext(),
      listen: false,
    );
    // return languageCubit.getTranslate(key,value);
    return Translate.translate(key, value);
  }

  Future afterChangeLanguage() async {
    navPARU(const SplashView());
  }

  void showLanguageDialog() {
    customAlertDialog(
      title: translate('global', "choose_lang"),
      content: translate('global', "choose_lang_content"),
      top: -15.h,
      backConfirm: const Color(0xff11683D),
      backCancel: const Color(0xff0E5196),
      color: Colors.white,
      confirm: 'العربية 🇸🇦',
      confirmTap: () {
        setLanguage(const Locale("ar"), rebuild: true);
        changeLanguage();
      },
      cancel: 'English 🇺🇸',
      padding: 2.w,
      cancelTap: () {
        setLanguage(const Locale("en"), rebuild: true);
        changeLanguage();
      },
    );
  }
}
