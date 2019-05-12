import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localization_app/movie_model.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  _MovieDetailPageState createState() => new _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  double moviePosterWidth = 150.0;
  double moviePosterHeight = 200.0;
  double _sliderValue = 10.0;

  Widget get moviePoster {
    return new Hero(
      tag: widget.movie,
      child: new Container(
        height: moviePosterHeight,
        width: moviePosterWidth,
        constraints: new BoxConstraints(),
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
    );
  }

  Widget get movieDetails {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 32.0),
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
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          moviePoster,
          new Text(
            widget.movie.name,
            style: new TextStyle(fontSize: 32.0),
          ),
          new Text(
            widget.movie.location,
            style: new TextStyle(fontSize: 20.0),
          ),
          new Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: new Text(widget.movie.description),
          ),
          rating
        ],
      ),
    );
  }

  Widget get rating {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          Icons.star,
          size: 40.0,
        ),// TODO: replace with correct icon
        new Text(
          widget.movie.rating.toString(),
          style: Theme.of(context).textTheme.display2
        ),
      ],
    );
  }

  Widget get addYourRating {
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Flexible(
                flex: 1,
                child: new Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 15.0,
                  onChanged: (newRating) => updateSlider(newRating),
                  value: _sliderValue,
                ),
              ),
              new Container(
                width: 50.0,
                alignment: Alignment.center,
                child: new Text('${_sliderValue.toInt()}',
                    style: Theme.of(context).textTheme.display1),
              ),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  Widget get submitRatingButton {
    return new RaisedButton(
      onPressed: updateRating,
      child: new Text('Submit'),
      color: Colors.indigoAccent,
    );
  }

  void updateSlider(double newRating) {
    setState(() => _sliderValue = newRating);
  }

  void updateRating() {
    if (_sliderValue < 10) {
      _ratingErrorDialog();
    } else {
      setState(() => widget.movie.rating = _sliderValue.toInt());
    }
  }

  Future<Null> _ratingErrorDialog() async {
    return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Error!'),
        content: new Text("Placeholders for days"),
        actions: [
          new FlatButton(
            child: new Text('Try Again'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: Colors.black87,
      appBar: new AppBar(
        //backgroundColor: Colors.black87,
        title: new Text(widget.movie.name),
      ),
      body: new ListView(
        children: <Widget>[movieDetails],
      ),
    );
  }
}
