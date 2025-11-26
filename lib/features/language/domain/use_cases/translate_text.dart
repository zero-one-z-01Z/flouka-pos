import '../../../../../core/constants/constants.dart';
import '../entities/app_localizations.dart';

class Translate{
  static String translate(String key,String value){
    return AppLocalizations.of(Constants.globalContext())!.
    translate(key, value);
  }
}