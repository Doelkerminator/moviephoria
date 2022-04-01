import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/Movie.dart';

class DatabaseMovies {
  static const _nameDB = 'MovieDB';
  static const _versionDB = 1;

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String routeDB = join(folder.path, _nameDB);
    return await openDatabase(
      routeDB,
      version: _versionDB,
      onCreate: _createTables,
    );
  }

  _createTables(Database db, int version) {
    db.execute(
      "CREATE TABLE fav_movies (backdropPath varchar(150),"
          "id integer primary key,"
          "originalLanguage varchar(30),"
          "originalTitle varchar(50),"
          "overview varchar(500),"
          "popularity real,"
          "posterPath varchar(60),"
          "releaseDate varchar(15),"
          "title varchar(40),"
          "voteAverage real,"
          "voteCount integer)"
    );
  }

  Future<int> insert(Map<String, dynamic> row) async {
    var dbConnection = await database;
    return dbConnection!.insert("fav_movies", row);
  }

  Future<int> delete(int idMovie) async {
    var dbConnection = await database;
    return dbConnection!
        .delete("fav_movies", where: "idMovie = ?", whereArgs: [idMovie]);
  }

  Future<List<Movie>> getAllFavMovies() async {
    var dbConnection = await database;
    var result = await dbConnection!.query("fav_movies");
    return result.map((movie) => Movie.fromMap(movie)).toList();
  }
}