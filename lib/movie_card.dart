import 'package:flutter/material.dart';
import 'package:localization_app/views/detail_page.dart';
import 'package:localization_app/models/movie.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 
import 'package:localization_app/styles/text.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;

  MovieCard(this.movie);

  @override
  MovieCardState createState() {
    return new MovieCardState(movie);
  }
}

class MovieCardState extends State<MovieCard> {
  Movie movie;
  String renderUrl;
  String renderTitle;
  String renderGenres;
  var renderPrices;
  String renderRatingString;
  double renderRatingDouble;

  MovieCardState(this.movie);

  void initState() {
    super.initState();
    renderMovie();
  }

  void renderMovie() async {
    await movie.getMovieData();
    if (this.mounted) {
      setState(() {
        renderTitle = movie.title;
        renderUrl = movie.imageUrl;        
        renderRatingString = movie.ratingString;
        renderRatingDouble = movie.ratingDouble;
        renderPrices = movie.prices;
        renderGenres = movie.genres;   
      });
    }
  }

  Widget get movieImage {
    var moviePoster = new Hero(
      tag: movie,
      child: new Container(
        width: 150,
        height: 225,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(
            const Radius.circular(8.0),
          ),
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new NetworkImage(renderUrl ?? ''),
          ),
        ),
      ),
    );

    var placeholder = new Container(
        height: 225,
        decoration: new BoxDecoration(
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
        ),
        alignment: Alignment.center);

    var crossFade = new AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: moviePoster,
      crossFadeState: renderUrl == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: new Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  Widget get movieMetadata {

    if (renderTitle == null || renderUrl == null) {
      return Center(
        child: CircularProgressIndicator()
      );
    }

    return new Container( 
        width: 290.0,
        //height: 115.0,
        child: new Card(
          color: Colors.white,
          child: new Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              left: 10.0,
              right: 10.0,
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text(
                  renderTitle ?? '',
                  style: headingStyle
                ),
                new Text(
                  renderGenres ?? '',
                  style: microcopyStyle
                ),
                new Row(
                  children: <Widget>[
                    SmoothStarRating(
                      allowHalfRating: true,
                      starCount: 5,
                      rating: renderRatingDouble ?? 0,
                      size: 20.0,
                      color: Colors.orange,
                      borderColor: Colors.orange,
                    ),
                    new Text(
                      renderRatingString ?? '',
                      style: bodyStyle 
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => showDetailPage(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0
        ),
        child: new IntrinsicHeight(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Expanded(
                flex: 2,
                child: movieImage
              ),
              new Expanded(
                flex: 3,
                child: movieMetadata
              )
            ],
          )
        ),
      ),
    );
  }

  showDetailPage() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new DetailPage(movie);
    }));
  }
}
