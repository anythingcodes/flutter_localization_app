import 'package:flutter/material.dart';
import 'package:localization_app/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization_app/services/l10n/app_translations_delegate.dart';
import 'package:localization_app/screens/listing_page.dart';
import 'package:localization_app/services/l10n/application.dart';

void main() {
  runApp(new MovieApp());
}

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}


class _MovieAppState extends State<MovieApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new ListingPage(),
      theme: ThemeData(
        primaryColor: Color(0xFFFFFFFF)
      ),
      localizationsDelegates: [
        _newLocaleDelegate,
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: application.supportedLocales(),
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}
