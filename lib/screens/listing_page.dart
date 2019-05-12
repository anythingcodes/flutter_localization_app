import 'package:flutter/material.dart';
import 'package:localization_app/movie_list.dart';
import 'package:localization_app/movie_model.dart';
import 'package:localization_app/l10n/l10n.dart';

class ListingPage extends StatefulWidget {
  ListingPage({Key key, this.title }) : super(key: key);

  final String title;

  @override
  _ListingPageState createState() => new _ListingPageState();

}

class _ListingPageState extends State<ListingPage> {

  final List<String> _items = ['en_US', 'es_ES', 'de_DE', 'de_CH', 'ne_NP'].toList();
  Locale _currentLocale = new Locale('en', 'US');

  //@override
  //void initState() {
    //_currentLocale = 
    //super.initState();
  //}

  var initialMovies = <Movie>[]
    ..add(new Movie('Ruby', 'Portland, OR, USA',
        'Ruby is a very good girl. Yes: Fetch, loungin\'. No: Movies who get on furniture.'))
    ..add(new Movie('Mission: Impossible - Fallout', 'Christopher McQuarrie', 'A Very Good Boy'))
    ..add(new Movie('Rod Stewart', 'Prague, CZ', 'A Very Good Boy'))
    ..add(new Movie('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'))
    ..add(new Movie('Buddy', 'North Pole, Earth', 'A Very Good Boy'));
  

  @override
  Widget build(BuildContext context) {
    
    print("Current locale is ");
    print(_currentLocale);

    GlobalKey key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: key,
      appBar: new AppBar(
        title: Text(AppLocalizations.of(context).translate('title')),
        actions: [
          new DropdownButton<String>(
            // TODO: Set locale strings in one location
            value: _currentLocale.toString(),
            style: TextStyle(
              color: Colors.grey
            ),
            items: _items.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (value) {
              print('==> changed!');
              print(value);
              List<String> codes = value.split('_');
              print(codes);
              Locale newLocale = new Locale(codes[0], codes[1]);
              print(newLocale);
              // _currentLocale = newLocale;
              // print(_currentLocale);
              setState(() {
                _currentLocale = newLocale;
              });
              
            },
          )
          // new IconButton(
          //   icon: new Icon(Icons.add),
          //   onPressed: () => _showNewMovieForm(),
          // ),
        ],
      ),
      
      body: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.indigo[800],
              Colors.indigo[700],
              Colors.indigo[600],
              Colors.indigo[400],
            ],
          ),
        ),
        child: new Center(
          child: new MovieList(initialMovies),
        ),
      ),
    );
  }
  
}
