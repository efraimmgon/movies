import 'dart:io';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String urlKey = 'api_key=API_KEY';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';

  Future<String?> getUpcoming() async {
    final Uri upcoming = (urlBase + urlUpcoming + urlKey + urlLanguage) as Uri;
    http.Response result = await http.get(upcoming);
    if (result.statusCode == HttpStatus.ok) {
      return result.body;
    } else {
      return null;
    }
  }
}
