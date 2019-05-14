import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppTranslations {
  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;
  
  AppTranslations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

  static Future<AppTranslations> load(Locale locale) async {
    AppTranslations appTranslations = AppTranslations(locale);
    String _filePath = "assets/l10n/${locale.languageCode}_${locale.countryCode}.json";
    String jsonContent = await rootBundle.loadString(_filePath);
    _localizedValues = json.decode(jsonContent);
    return appTranslations;
  }

  get currentLanguage => locale.languageCode;
  get currentCountry => locale.countryCode;

  String text(String key) {
    if (_localizedValues != null && _localizedValues.containsKey(key)) {
      return _localizedValues[key];
    }
    return '...';
  }
}
