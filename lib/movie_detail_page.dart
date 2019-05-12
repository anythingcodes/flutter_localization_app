import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localization_app/movie_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 


class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  _MovieDetailPageState createState() => new _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  double moviePosterWidth = 150.0;
  double moviePosterHeight = 200.0;

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
      // TODO: Add unsplash background image
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
        new SmoothStarRating(
          allowHalfRating: true,
          starCount: 5,
          rating: widget.movie.rating.toDouble(),
          size: 20.0,
          color: Colors.orange,
          borderColor: Colors.orange,
        ),
        new Text(
          widget.movie.rating.toString(),
          style: Theme.of(context).textTheme.display2
        ),
      ],
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
