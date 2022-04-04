import 'package:flutter/material.dart';
import 'package:moviephoria/routes/routes.dart';
import 'package:moviephoria/screens/movie_list.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: getApplicationRoutes(),
      home: SplashScreenView(
        navigateRoute: const MovieList(),
        duration: 800,
        imageSize: 150,
        imageSrc: "assets/images/popcorn.png",
        text: 'MoviePhoria',
        textType: TextType.ColorizeAnimationText,
        textStyle: const TextStyle(
          fontSize: 80.0,
          fontFamily: 'Aestethicc'
        ),
        colors: const [
          Colors.white,
          Colors.white54,
          Colors.white,
          Colors.white
        ],
        backgroundColor: const Color(0xFF1F1F1F),
      )
    );
  }
}
