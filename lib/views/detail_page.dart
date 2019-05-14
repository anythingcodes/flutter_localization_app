import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization_app/models/movie.dart';
import 'package:localization_app/styles/text.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 
import 'package:localization_app/services/l10n/app_translations.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;

  DetailPage(this.movie);

  @override
  _DetailPageState createState() => new _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double moviePosterWidth = 233.333;
  double moviePosterHeight = 350.0;

  String _localeString;
  String _rentPrefix;
  String _rentSuffix;
  String _aboutHeading;
  String _currencyCode;
  String _dialogHeading;
  String _dialogContent;

  String formatCurrency(price) {
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: _localeString, name: null, decimalDigits: 2);
    return _rentPrefix + formatter.format(price) + _rentSuffix;
  }

  Widget get moviePoster {
    return new Stack (
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(bottom: 50.0),
          child: new Hero(
            tag: widget.movie,
            child: new Container(
              height: moviePosterHeight,
              width: moviePosterWidth,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(
                  const Radius.circular(8.0),
                ),
                boxShadow: [
                  const BoxShadow(
                      offset: const Offset(1.0, 2.0),
                      blurRadius: 2.0,
                      spreadRadius: -1.0,
                      color: const Color(0x33000000)),
                  const BoxShadow(
                      offset: const Offset(2.0, 1.0),
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                      color: const Color(0x24000000)),
                  const BoxShadow(
                      offset: const Offset(3.0, 1.0),
                      blurRadius: 4.0,
                      spreadRadius: 2.0,
                      color: const Color(0x1F000000)),
                ],
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(widget.movie.imageUrl ?? ''),
                ),
              ),
            ),
          ),
          
      ),
      Positioned(
        right: 0,
        left: 0,
        bottom: 0,
        child: RaisedButton(
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                title: new Text(_dialogHeading),
                content: new Text(_dialogContent),
              ),
            );
          },
          textColor: Colors.white,
          color: Colors.red,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            formatCurrency(widget.movie.prices[_currencyCode]),
            style: buttonStyle
          ),
        )
      )
      ]
    );
  }

  Widget get movieDetails {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 32.0, horizontal: 32),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/detail-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: <Widget>[
          moviePoster,
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 25.0),
            child: new Text(
              widget.movie.title,
              textAlign: TextAlign.center,
              style: headingStyle
            ),
          ),          
          new Text(
            widget.movie.genres,
            style: microcopyStyle
          ),
          new Text(
            widget.movie.releaseDate,
            style: microcopyStyle
          ),
          rating
        ],
      ),
    );
  }


  Widget get movieDescription {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 32),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
            child: new Text(
              _aboutHeading,
              style: headingStyle
            )
          ),
          new Text(
            widget.movie.description,
            style: bodyStyle
          ),
        ],
      )
    );
  }

  Widget get rating {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new SmoothStarRating(
          allowHalfRating: true,
          starCount: 5,
          rating: widget.movie.ratingDouble != null ? widget.movie.ratingDouble : 4,
          size: 20.0,
          color: Colors.orange,
          borderColor: Colors.orange,
        ),
        new Text(
          widget.movie.ratingString,
          style: Theme.of(context).textTheme.display2
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _localeString = AppTranslations.of(context).text('locale');
      _rentPrefix = AppTranslations.of(context).text('rent_prefix');
      _rentSuffix = AppTranslations.of(context).text('rent_suffix');
      _aboutHeading = AppTranslations.of(context).text('about_heading');
      _currencyCode = AppTranslations.of(context).text('currency_code');
      _dialogHeading = AppTranslations.of(context).text('dialog_heading');
      _dialogContent = AppTranslations.of(context).text('dialog_content');
    });
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.movie.title),
      ),
      body: new ListView(
        children: <Widget>[
          movieDetails,
          movieDescription
        ],
      ),
    );
  }
}
