import 'package:flutter/material.dart';
import 'package:localization_app/movie_detail_page.dart';
import 'package:localization_app/movie_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 

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

  MovieCardState(this.movie);

  void initState() {
    super.initState();
    renderMoviePic();
  }

  void renderMoviePic() async {
    await movie.getImageUrl();
    if (this.mounted) {
      setState(() {
        renderUrl = movie.imageUrl;
      });
    }
  }

  Widget get movieImage {
    var moviePoster = new Hero(
      tag: movie,
      child: new Container(
        width: 150.0,
        height: 200.0,
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
        width: 150.0,
        height: 200.0,
        decoration: new BoxDecoration(
          //shape: BoxShape.circle,
          
          //shape: BoxShape.circle,
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

  Widget get movieCard {

    final _headingStyle = new TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.w400,
      fontFamily: "Avenir",
      color: Colors.black,
    );

    final _bodyStyle = new TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      fontFamily: "Avenir",
      color: Colors.black,
    );

    final _microcopyStyle = new TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      fontFamily: "Avenir",
      color: Colors.grey,
    );

    return new Positioned(
      right: 0,
      bottom: 0,
      child: new Container( 
        width: 290.0,
        //height: 115.0,
        child: new Card(
          color: Colors.white,
          child: new Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              left: 80.0,
              right: 10.0,
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text(
                  widget.movie.name,
                  style: _headingStyle
                  //style: Theme.of(context).textTheme.headline,
                ),
                new Text(
                  widget.movie.location,
                  style: _microcopyStyle
                ),
                new Row(
                  children: <Widget>[
                    SmoothStarRating(
                      allowHalfRating: true,
                      starCount: 5,
                      rating: widget.movie.rating.toDouble(),
                      size: 20.0,
                      color: Colors.orange,
                      borderColor: Colors.orange,
                    ),
                    new Text(
                      widget.movie.rating.toString(),
                      style: _bodyStyle
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => showMovieDetailPage(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0
        ),
        child: new Container(
          height: 200.0,
          child: new Stack(
            children: <Widget>[
              movieCard,
              new Positioned(
                //top: 7.5,
                //top: 0.0,
                left: 0.0,
                child: movieImage
              ),
            ],
          ),
        ),
      ),
    );
  }

  showMovieDetailPage() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new MovieDetailPage(movie);
    }));
  }
}
