import 'package:flutter/cupertino.dart';

class Movie {
  String? backdropPath;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  double? voteAverage;
  int? voteCount;

  Movie({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
        backdropPath: map['backdrop_path'] ?? '',
        id: map['id'],
        originalLanguage: map['original_language'],
        originalTitle: map['original_title'],
        overview: map['overview'],
        popularity: map['popularity'],
        posterPath: map['poster_path'] ?? '',
        releaseDate: map['release_date'],
        title: map['title'],
        voteAverage: map['vote_average'] is int
            ? (map['vote_average'] as int).toDouble()
            : map['vote_average'],
        voteCount: map['vote_count']);
  }

  Map<String, dynamic> toMap() {
    return {
      'backdropPath' : backdropPath,
      'id' : id,
      'originalLanguage' : originalLanguage,
      'originalTitle' : originalTitle,
      'overview' : overview,
      'popularity' : popularity,
      'posterPath' : posterPath,
      'releaseDate' : releaseDate,
      'title' : title,
      'voteAverage' : voteAverage,
      'voteCount' : voteCount,
    };
  }
}