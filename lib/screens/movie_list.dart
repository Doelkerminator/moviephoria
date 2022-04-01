
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviephoria/network/api_movies.dart';

import '../models/Movie.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key : key);

  @override
  State<MovieList> createState() => _MoviePopular();
}

class _MoviePopular extends State<MovieList> {

  int _selectedIndex = 0;

  void _changeScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      appBar: AppBar(
        title: const Text('Popular Movies'),
        elevation: 1,
        backgroundColor: const Color(0xFF363637),
      ),
      body: Container(
        
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