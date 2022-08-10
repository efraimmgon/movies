import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'movie.dart';

class HttpHelper {
  final String urlKey = 'api_key=API_KEY';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';

  /// Access the DB API and get movies json data.
  /// Returns a list of movies.
  Future<List?> getUpcoming() async {
    final Uri upcoming = (urlBase + urlUpcoming + urlKey + urlLanguage) as Uri;
    http.Response result = await http.get(upcoming);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesResult = jsonResponse['results'];
      List movies = moviesResult.map((m) => Movie.fromJson(m)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
