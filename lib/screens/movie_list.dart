
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviephoria/database/database_movies.dart';
import 'package:moviephoria/network/api_movies.dart';
import 'package:moviephoria/views/movie_card.dart';


import '../models/Movie.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key : key);

  @override
  State<MovieList> createState() => _MoviePopular();
}

// State
class _MoviePopular extends State<MovieList> {

  //Variables
  int _selectedIndex = 0;
  String appBarTitle = 'Popular Movies';

  //State related methods
  @override
  void initState() {
    super.initState();
  }

  void _changeScreen(int index) {
    setState(() {
      _selectedIndex = index;
      if(index == 0) {
        appBarTitle = 'Popular Movies';
      }
      else {
        appBarTitle = 'Favorite Movies';
      }
    });
  }

  //List of Widgets (Popular and Favorite movies)
  static final List<Widget> _widgetOptions = <Widget> [
    FutureBuilder(
      future: ApiMovies.getAllMovies(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>?> snapshot) {
        if(snapshot.hasError) {
          return oopsAnErrorHappened();
        }
        else {
          if (snapshot.connectionState == ConnectionState.done) {
            return _listMovies(snapshot.data);
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      }
    ),
    FutureBuilder(
        future: DatabaseMovies.getAllFavMovies(),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>?> snapshot) {
          if(snapshot.hasError) {
            return oopsAnErrorHappened();
          }
          else {
            if (snapshot.connectionState == ConnectionState.done) {
              return _listMovies(snapshot.data);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        }
    ),
  ];

  //Widget when an error happens
  static Widget oopsAnErrorHappened() {
    return Center (
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(
            image: AssetImage('assets/images/error.png'),
            height: 200,
            width: 200,
          ),
          Text(
            'Error',
            style: TextStyle(
                fontFamily: 'Inlanders',
                color: Colors.white,
                fontSize: 80
            ),
          ),
          Text('Could not retrieve data', style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }

  //Widget of movie list
  static Widget _listMovies(List<Movie>? movies) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            Movie movie = movies![index];
            return CardMovie(movie: movie);
          },
          separatorBuilder: (_, __) => const Divider(height: 10),
          itemCount: movies!.length)
    );
  }

  //Main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      appBar: AppBar(
        title: Text(appBarTitle),
        elevation: 1,
        backgroundColor: const Color(0xFF363637),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh))
        ],
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Popular Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
        ],
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[600],
        unselectedItemColor: Colors.white24,
        onTap: _changeScreen,
      ),
    );
  }
}