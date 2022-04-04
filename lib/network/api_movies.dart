
import 'dart:convert';

import 'package:moviephoria/models/Movie.dart';
import 'package:http/http.dart' as http;

import '../models/Cast.dart';

class ApiMovies {

  static Future<List<Movie>?> getAllMovies() async {
    var URL = Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=2f8c837bf1075e4af51d748e03796cf1&sort_by=popularity.desc&page=1');
    var response = await http.get(URL);
    if (response.statusCode == 200) {
      var movies = jsonDecode(response.body)['results'] as List;
      return movies.map((movie) => Movie.fromMap(movie)).toList();
    }
    else {
      return null;
    }
  }

  static Future<Movie?> getMovieDetails(int idMovie) async {
    var URL = Uri.parse(
      'https://api.themoviedb.org/3/movie/$idMovie?api_key=2f8c837bf1075e4af51d748e03796cf1&language=en-US'
    );
    var response = await http.get(URL);
    if (response.statusCode == 200) {
      var movie = jsonDecode(response.body);
      return Movie.fromMap(movie);
    }
    else {
      return null;
    }
  }

  static Future<String?> getMovieTrailer(int idMovie) async {
    var URL = Uri.parse(
      'https://api.themoviedb.org/3/movie/$idMovie/videos?api_key=2f8c837bf1075e4af51d748e03796cf1&language=en-US'
    );
    var response = await http.get(URL);
    if (response.statusCode == 200) {
      var movieVideo = jsonDecode(response.body)['results'] as List;
      for (var element in movieVideo) {
        if (element['type'] == 'Trailer' && element['official'] == true) {
          return element['key'];
        }
      }
      return 'VUArb3AIpm4&t';
    }
    else {
      return null;
    }
  }

  static Future<List<Cast>?> getCast(int idMovie) async {
    var URL = Uri.parse(
      'https://api.themoviedb.org/3/movie/$idMovie/credits?api_key=2f8c837bf1075e4af51d748e03796cf1&language=en-US'
    );
    var response = await http.get(URL);
    if (response.statusCode == 200) {
      var cast = jsonDecode(response.body)['cast'] as List;
      return cast.map((c) => Cast.fromMap(c)).toList();
    }
    else {
      return null;
    }
  }
}