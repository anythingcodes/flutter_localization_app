import 'dart:ui';

class Application {

  static final Application _application = Application._internal();

  // Manages application states and locale switching
  factory Application() {
    return _application;
  }

  Application._internal();

  final List<String> supportedLocaleCodes = [
    "de_CH",
    "de_DE",
    "en_US",
    "es_ES",
    "ne_NP"
  ];

  final List<String> supportedLocaleStrings = [
    "Deutsch (Schweiz)",
    "Deutsch (Deutschland)",
    "English (US)",
    "Español (España)",
    "नेपाली (नेपाल)"
  ];

  Locale stringToLocale(str) {
    var _arr = str.split('_');
    Locale _newLocale = new Locale(_arr[0], _arr[1]);
    return _newLocale;
  } 

  // Returns the formatted list of supported Locales
  Iterable<Locale> supportedLocales() => supportedLocaleCodes.map<Locale>((localeString) => stringToLocale(localeString));

  //function to be invoked when changing the language
  LocaleChangeCallback onLocaleChanged;
}

Application application = Application();

typedef void LocaleChangeCallback(Locale locale);