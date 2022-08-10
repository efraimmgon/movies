import 'package:flutter/material.dart';
import 'http_helper.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final String iconBase = "https://image.tmdb.org/t/p/w92/";
  final String defaultImage =
      "https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg";
  String result = "";
  late HttpHelper helper;
  late int moviesCount;
  List? movies;

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
        appBar: AppBar(title: const Text('Movies')),
        body: ListView.builder(
          itemCount: moviesCount,
          itemBuilder: (BuildContext context, int position) {
            var movie = movies![position];
            if (movie.posterPath != null) {
              image = NetworkImage(iconBase + movie.posterPath);
            } else {
              image = NetworkImage(defaultImage);
            }
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(movie.title),
                subtitle: Text(
                  "Released: ${movie.releaseDate}"
                  " - Vote: ${movie.voteAverage.toString()}",
                ),
                leading: CircleAvatar(backgroundImage: image),
              ),
            );
          },
        ));
  }

  Future initialize() async {
    movies = [];
    movies = await helper.getUpcoming();
    setState(() {
      moviesCount = movies!.length;
      movies = movies;
    });
  }
}
