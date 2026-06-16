import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/dialog/custom_alert_dialog.dart';
import '../../../../../core/helper_function/api.dart';
import '../../../../../core/helper_function/prefs.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../splash/views/splash_view.dart';
import '../../domain/use_cases/translate_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  late Locale
  language; // use this var when control state of language widget then use it for change language
  Locale _appLocale = const Locale('fr');
  static const List<Locale> languages = [Locale('ar', ''), Locale("en", ""),Locale("fr", "")];
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
    _appLocale = Locale(language ?? "fr");
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
    return languageCubit.getTranslate(key,value);
    // return Translate.translate(key, value);
  }

  Future afterChangeLanguage() async {
    navPARU(const SplashView());
  }

  // void showLanguageDialog() {
  //   customAlertDialog(
  //     title: translate('global', "choose_lang"),
  //     content: translate('global', "choose_lang_content"),
  //     top: -15.h,
  //     backConfirm: const Color(0xff11683D),
  //     backCancel: const Color(0xff0E5196),
  //     color: Colors.white,
  //     confirm: 'العربية 🇸🇦',
  //     confirmTap: () {
  //       setLanguage(const Locale("ar"), rebuild: true);
  //       changeLanguage();
  //     },
  //     cancel: 'English 🇺🇸',
  //     padding: 2.w,
  //     cancelTap: () {
  //       setLanguage(const Locale("en"), rebuild: true);
  //       changeLanguage();
  //     },
  //   );
  // }
  void showLanguageDialog() {
    showDialog(
      context: Constants.globalContext(),
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          content: Padding(padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 2.h,),
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              clipBehavior: Clip.none,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 1.h),

                    Text(
                      LanguageProvider.translate('global', 'choose_lang'),
                      style: TextStyleClass.normalStyle(),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(LanguageProvider.translate('global', 'choose_lang_content',),
                      style: TextStyleClass.normalStyle(color:  const Color(0xff656363),).copyWith(height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 3.h),
                    SizedBox(width: 100.w,
                      child: Wrap(runSpacing: 1.h,spacing: 2.w,crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.center,alignment: WrapAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setLanguage(const Locale("ar"), rebuild: true);
                              changeLanguage();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 1.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(8),
                                color: const Color(0xff11683D),
                              ),
                              child: Text(
                                LanguageProvider.translate('buttons', 'العربية 🇸🇦',),
                                style: TextStyleClass.semiHeadStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setLanguage(const Locale("fr"), rebuild: true);
                              changeLanguage();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 1.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(8),
                                color: const Color(0xFFCE1126),
                              ),
                              child: Text(
                                LanguageProvider.translate('buttons', 'French 🇫🇷',),
                                style: TextStyleClass.semiHeadStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setLanguage(const Locale("en"), rebuild: true);
                              changeLanguage();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 1.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(8),
                                color:const Color(0xff0E5196),
                              ),
                              child: Text(
                                LanguageProvider.translate('buttons', 'English 🇺🇸',),
                                style: TextStyleClass.headStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     onPressed: cancelTap,
          //     child: Text(cancel),
          //   ),
          //   ElevatedButton(
          //     onPressed: confirmTap,
          //     child: Text(confirm),
          //   ),
          // ],
        );
      },
    );
  }
}
