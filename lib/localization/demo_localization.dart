import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalization {
  final Locale locale;
  DemoLocalization(this.locale);
  static DemoLocalization of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  Map<String, String> _localizedValues;

  Future load() async {
    String jsonStringValues = 
    await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value));
  }

  String getTransaltedValue(String key) {
    return _localizedValues[key];
  }

  // stat
  static const LocalizationsDelegate<DemoLocalization> delegate = DemoLocalizationsDelegate();
}

class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalization> {
  const DemoLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) =>
   ['en', 'ar'].contains(locale.languageCode);
  

  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization localization = new DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}