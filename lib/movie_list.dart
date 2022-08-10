import 'package:flutter/material.dart';
import 'http_helper.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
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
    return Scaffold(
        appBar: AppBar(title: const Text('Movies')),
        body: ListView.builder(
          itemCount: moviesCount,
          itemBuilder: (BuildContext context, int position) {
            var movie = movies![position];
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(movie.title),
                subtitle: Text(
                  "Released: ${movie.releaseDate}"
                  " - Vote: ${movie.voteAverage.toString()}",
                ),
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
