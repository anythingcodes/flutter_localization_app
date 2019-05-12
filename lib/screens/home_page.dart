import 'package:flutter/material.dart';
import 'package:localization_app/movie_list.dart';
import 'package:localization_app/movie_model.dart';
import 'package:localization_app/application.dart';
import 'package:localization_app/services/l10n/app_translations.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static final List<String> localeCodes = application.supportedLocaleCodes;
  static final List<String> localeStrings = application.supportedLocaleStrings;

  // TODO: Make length dynamic
  final Map<dynamic, dynamic> localeMap = {
    localeStrings[0]: localeCodes[0],
    localeStrings[1]: localeCodes[1],
    localeStrings[2]: localeCodes[2],
    localeStrings[3]: localeCodes[3],
    localeStrings[4]: localeCodes[4],
  };


  String _value;

  var initialMovies = <Movie>[]
    ..add(new Movie('Island', 'Ludvig Christian Næsted Poulsen',
        'An elderly man leaves the main country and his deceased spouse Kristian, in their old house. Hoping to retrieve his spirit, he travels to the island, where the couple spent their younghood together. While reliving strong memories from their life on the island, the old man makes a series of phone calls to his deceased husband back home. He reflects on his life and wonders whether there is one beyond the love he has experienced.'))
    ..add(new Movie('Mission: Impossible - Fallout', 'Christopher McQuarrie', 'Ethan Hunt and his IMF team, along with some familiar allies, race against time after a mission gone wrong.'))
    ..add(new Movie('Numéro Deux', 'Jean-Luc Godard', 'An analysis of the power relations in an ordinary family.'));

  @override
  Widget build(BuildContext context) {
    GlobalKey key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: key,
      appBar: new AppBar(
        title: Text(AppTranslations.of(context).text('app_title')),
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.black,
            fontFamily: 'Avenir',
            fontSize: 26
          )
        ),
        elevation: 0.0,
        actions: [
          new DropdownButton<String>(
            // TODO: Set locale strings in one location
            
            style: TextStyle(
              color: Colors.grey,

            ),
            items: localeStrings.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState((){
                _value = value;
              });
              Locale newLocale = application.stringToLocale(localeMap[value]);
              application.onLocaleChanged(newLocale);
            },
            // TODO: Fix default value
            value: _value == null ? 'English (US)' : _value,
          )
        ],
      ),
      
      body: new Container(
        // TODO: Grey home background
        // decoration: new BoxDecoration(
        //   gradient: new LinearGradient(
        //     begin: Alignment.topRight,
        //     end: Alignment.bottomLeft,
        //     stops: [0.1, 0.5, 0.7, 0.9],
        //     colors: [
        //       Colors.indigo[800],
        //       Colors.indigo[700],
        //       Colors.indigo[600],
        //       Colors.indigo[400],
        //     ],
        //   ),
        // ),
        child: new Center(
          child: new MovieList(initialMovies),
        ),
      ),
    );
  }
  
}
