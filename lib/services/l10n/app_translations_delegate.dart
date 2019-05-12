import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localization_app/services/l10n/app_translations.dart';
import 'package:localization_app/application.dart';

class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  final Locale newLocale;

  const AppTranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return application.supportedLocaleCodes.contains(locale.languageCode + '_' + locale.countryCode);
  }

  @override
  Future<AppTranslations> load(Locale locale) {
    return AppTranslations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppTranslations> old) {
    return true;
  }
}