import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Movie {
  final double id;
  Locale locale;
  String description;
  String imageUrl;
  var movieData;
  String title;
  String releaseDate;
  String genres;
  String ratingString;
  double ratingDouble;
  int runtime;
  var prices;

  Movie(this.id, this.locale);

  Future getMovieData() async {
    if (movieData != null) {
      return;
    }
    // Get an Image
    HttpClient http = new HttpClient();
    try {
      var uri = new Uri.https('tmdb-rest-api.herokuapp.com', '/movie/' + id.toString(), {
        'locale': locale.toString()
      });        
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      var decoded = json.decode(responseBody);
      imageUrl = 'http://image.tmdb.org/t/p/w342' + decoded['poster_path'];
      title = decoded['title'];
      

      DateTime resReleaseDate = DateTime.parse(decoded['release_date']);
      DateFormat dateFormatter = new DateFormat('yMMMd', locale.toString());
      releaseDate = dateFormatter.format(resReleaseDate);

      genres = decoded['genres'].map((genre) => genre['name']).join(', ');
      prices = decoded['prices'];
      ratingDouble = decoded['vote_average'] / 10 * 5;
      ratingString = NumberFormat.decimalPattern(locale.toString()).format(ratingDouble);      
      runtime = decoded['runtime'];
      description = decoded['overview'];
      movieData = decoded;
    } catch (exception) {
      print(exception);
    }
  }
}
