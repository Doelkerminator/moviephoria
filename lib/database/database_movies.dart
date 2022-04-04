import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/Movie.dart';

class DatabaseMovies {
  static const _nameDB = 'MoviesDB';
  static const _versionDB = 1;

  static Database? _database;
  static Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  static _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String routeDB = join(folder.path, _nameDB);
    return await openDatabase(
      routeDB,
      version: _versionDB,
      onCreate: _createTables,
    );
  }

  static _createTables(Database db, int version) {
    db.execute(
      "CREATE TABLE fav_movies ("
          "backdrop_path varchar(150),"
          "id integer primary key,"
          "original_language varchar(30),"
          "original_title varchar(50),"
          "overview varchar(500),"
          "popularity real,"
          "poster_path varchar(60),"
          "release_date varchar(15),"
          "title varchar(40),"
          "vote_average real,"
          "vote_count integer);"
    );
  }

  static void insert(Map<String, dynamic> row) async {
    var dbConnection = await database;
    dbConnection!.insert("fav_movies", row);
  }

  static void delete(int idMovie) async {
    var dbConnection = await database;
    dbConnection!.delete("fav_movies", where: "id = ?", whereArgs: [idMovie]);
  }

  static Future<List<Movie>> getAllFavMovies() async {
    var dbConnection = await database;
    var result = await dbConnection!.query("fav_movies");
    return result.map((movie) => Movie.fromMap(movie)).toList();
  }

  static Future<bool> isFavorite(int idMovie) async {
    var dbConnection = await database;
    int? ye = Sqflite.firstIntValue(await dbConnection!.rawQuery('SELECT COUNT(*) FROM fav_movies WHERE id = $idMovie'));
    if(ye == 1) {
      return true;
    }
    else {
      return false;
    }
  }
}