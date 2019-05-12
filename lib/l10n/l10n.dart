import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en_US': {
      'title': 'Rent a Movie',
    },
    'de': {
      'title': 'Ihre Online Videothek',
    },
    'es_ES': {
      'title': 'Alquilar películas',
    },
    'ne_NP': {
      'title': 'चलचित्र भाडामा लिनुहोस्',
    },
  };

  String translate(key) {
    // Return locale (country and language code) value if available
    String localeTitle = _localizedValues[locale.languageCode + '_' + locale.countryCode][key];
    if (localeTitle != null) {
      return localeTitle;
    }
    String languageTitle = _localizedValues[locale.languageCode][key];
    if (languageTitle == null) {
      // Return default en_US value
      return _localizedValues['en_US'][key];
    }
    return languageTitle;
  }

  
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
