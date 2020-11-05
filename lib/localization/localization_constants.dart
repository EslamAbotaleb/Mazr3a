import 'package:flutter/material.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTransalted(BuildContext context, String key) {
  return DemoLocalization.of(context).getTransaltedValue(key);
}

// language code 
const String English = 'en';
const String Arabic  = 'ar';

const String Language_Code = 'LanguageCode';
Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(Language_Code, languageCode);
  return _locale(languageCode);
}

Locale _locale(String language) {
   Locale _temp;
    switch (language) {
      case English:
      _temp = Locale(language, 'US');
      break;
      case Arabic:
            _temp = Locale(language, 'SA');
      break;
      
}
return _temp;
}

   Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(Language_Code) ?? "English";
  return _locale(languageCode);
}


