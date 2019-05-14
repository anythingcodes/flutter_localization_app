import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization_app/movie_list.dart';
import 'package:localization_app/models/movie.dart';
import 'package:localization_app/application.dart';
import 'package:localization_app/services/l10n/app_translations.dart';
import 'package:localization_app/styles/text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Initialize Search input controller
  TextEditingController controller = new TextEditingController();

  // Initial movies pulled by ID from the TMDb API
  // TODO: Set default locale
  List<Movie> _displayedMovies = <Movie>[]
    ..add(new Movie(11, new Locale('en', 'US')))
    ..add(new Movie(372355, new Locale('en', 'US')))
    ..add(new Movie(411, new Locale('en', 'US')))
    ..add(new Movie(12444, new Locale('en', 'US')))
    ..add(new Movie(112823, new Locale('en', 'US')))
    ..add(new Movie(329, new Locale('en', 'US')))
    ..add(new Movie(601, new Locale('en', 'US')))
    ..add(new Movie(12, new Locale('en', 'US')))
    ..add(new Movie(287947, new Locale('en', 'US')))
    ..add(new Movie(120, new Locale('en', 'US')))
    ..add(new Movie(4645, new Locale('en', 'US')))
    ..add(new Movie(14161, new Locale('en', 'US')))
    ..add(new Movie(353081, new Locale('en', 'US')))
    ..add(new Movie(550, new Locale('en', 'US')))
    ..add(new Movie(10193, new Locale('en', 'US')))
    ..add(new Movie(14160, new Locale('en', 'US')))
    ..add(new Movie(10192, new Locale('en', 'US')))
    ..add(new Movie(76323, new Locale('en', 'US')));

  List<Movie> _allMovies;

  static final List<String> localeCodes = application.supportedLocaleCodes;
  static final List<String> localeStrings = application.supportedLocaleStrings;

  static final GlobalKey inputKey = new GlobalKey<_HomePageState>();

  // TODO: Make length dynamic
  final Map<dynamic, dynamic> localeMap = {
    localeStrings[0]: localeCodes[0],
    localeStrings[1]: localeCodes[1],
    localeStrings[2]: localeCodes[2],
    localeStrings[3]: localeCodes[3],
    localeStrings[4]: localeCodes[4],
  };

  List<Movie> changeMovieLocale(Locale newLocale) {
    _displayedMovies = _displayedMovies.map((movie) => new Movie(movie.id, newLocale)).toList();
    return _displayedMovies;
  }

  String _value;

  @override
  Widget build(BuildContext context) {

    GlobalKey key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: key,
      appBar: new AppBar(
        title: Text(AppTranslations.of(context).text('app_title')),
        textTheme: TextTheme(
          title: appTitleStyle
        ),
        elevation: 0.0,
        actions: [
          new DropdownButton<String>(
            // TODO: Set locale strings in one location
            style: microcopyStyle,
            items: localeStrings.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,                
                child: new Text(value),
              );
            }).toList(),
            onChanged: (value) {
              Locale newLocale = application.stringToLocale(localeMap[value]);
              
              // Clear search input
              controller.clear();
              onSearchTextChanged('');

              // Set locale value and displayed movies
              setState((){
                _value = value;
                _displayedMovies = changeMovieLocale(newLocale);
                _allMovies = null;
              });
              
              // Trigger delegation
              application.onLocaleChanged(newLocale);
            },
            // TODO: Fix default value
            value: _value == null ? localeMap[0] : _value,
          )
        ],
      ),
      
      body: new Container(        
        child: new Flex(
          direction: Axis.vertical,
          // mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Card(
              child: new ListTile(
                  //leading: new Decoration(),
                  title: new TextField(
                    key: inputKey,
                    controller: controller,
                    decoration: new InputDecoration(
                      hintText: AppTranslations.of(context).text('search_placeholder'),
                      border: InputBorder.none
                    ),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
              )
            ),
            new Expanded(child: new MovieList(_displayedMovies)),
          ]
        ),
      ),
    );
  }

  onSearchTextChanged(String searchText) async {
    if (_allMovies == null) {
      // Initialize original list of movies
      setState(() {
        _allMovies = new List<Movie>.from(_displayedMovies);
      });
    }

    // If search text blank, reset state to _allMovies and return
    if (searchText.isEmpty) {
      setState(() {
        // Reset to list of all movies
        _displayedMovies = _allMovies;
      });
      return;
    }

    // Filter displayed movies by if searchText in title
    setState(() {
      _displayedMovies = _allMovies.where((movie) => movie.title != null && movie.title.toLowerCase().contains(searchText.toLowerCase())).toList();
    });    
  }
}
