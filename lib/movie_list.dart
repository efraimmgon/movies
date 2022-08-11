import 'package:flutter/material.dart';
import 'http_helper.dart';
import 'movie_detail.dart';

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
  Icon visibleIcon = const Icon(Icons.search);
  Widget searchBar = const Text("Movies");

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
        appBar: AppBar(
          title: searchBar,
          actions: [
            IconButton(
              icon: visibleIcon,
              onPressed: () {
                setState(() {
                  if (visibleIcon.icon == Icons.search) {
                    visibleIcon = const Icon(Icons.cancel);
                    searchBar = TextField(
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      onSubmitted: (String text) {
                        search(text);
                      },
                    );
                  } else {
                    setState(() {
                      visibleIcon = const Icon(Icons.search);
                      searchBar = const Text('Movies');
                    });
                  }
                });
              },
            )
          ],
        ),
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
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (_) => MovieDetail(movie));
                  Navigator.push(context, route);
                },
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

  Future search(text) async {
    movies = await helper.findMovies(text);
    setState(() {
      moviesCount = movies!.length;
      movies = movies;
    });
  }
}
