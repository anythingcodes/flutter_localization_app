import 'package:flutter/material.dart';
import 'package:localization_app/movie_card.dart';
import 'package:localization_app/models/movie.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  ListView _buildList(context) {
    return new ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, int) { 
        // Generate each movie card on home view       
        return new MovieCard(movies[int]);
      },
    );
  }

  @override
  Widget build(BuildContext context) { 
    return _buildList(context);
  }
}
