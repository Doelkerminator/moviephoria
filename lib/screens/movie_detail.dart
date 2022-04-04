
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviephoria/database/database_movies.dart';
import 'package:moviephoria/network/api_movies.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/Cast.dart';
import '../models/Movie.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({Key? key}) : super(key : key);

  @override
  State<MovieDetail> createState() => _MovieDetail();
}

class _MovieDetail extends State<MovieDetail> {
  //Variables
  int idMovie = 0;
  bool isFavorite = false;
  String titleMovie = 'E';

  //Error widget
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
                fontSize: 80
            ),
          ),
          Text('Could not retrieve data')
        ],
      ),
    );
  }

  //Video widget
  Widget _trailerVideo(String trailerId) {
    YoutubePlayerController _youtubeController = YoutubePlayerController(
      initialVideoId: trailerId,
      flags: const YoutubePlayerFlags (
          autoPlay: true,
      )
    );

    return YoutubePlayer(
      controller: _youtubeController,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber[600],
      progressColors: ProgressBarColors (
        playedColor: Colors.amber[600],
        handleColor: Colors.white38,
        backgroundColor: Colors.grey[900],
      ),
      bottomActions: [
        CurrentPosition(),
        ProgressBar(isExpanded: true)
      ],
    );
  }

  //Cast list widget
  Widget _castList(List<Cast>? casting) {
    return Padding (
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Cast cast = casting![index];
          return Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.lightBlue,
                backgroundImage: NetworkImage('https://image.tmdb.org/t/p/w500/${cast.profile_path}'),
                radius: 20,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    '${cast.name} (${cast.character})',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13
                    ),
                  ),
                )
              ),
            ],
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 7),
        itemCount: casting!.length
      )
    );
  }

  //Details Widget
  Widget _details(Movie? movie) {
    return Stack(
      children: [
        Container (
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie!.posterPath}'),
              fit: BoxFit.fill,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container (
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              //Trailer
              SizedBox(
                child: FutureBuilder(
                  future: ApiMovies.getMovieTrailer(idMovie),
                  builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    if(snapshot.hasError) {
                      return const Text("Wut? Somethin' happ'nd");
                    }
                    else {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return _trailerVideo(snapshot.data!);
                      }
                      else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                  }
                )
              ),
              //Title and favorite toggle
              Row(
                children: [
                  SizedBox(
                      child: Row(
                        children: [
                          RatingBarIndicator(
                            rating: movie.voteAverage!,
                            direction: Axis.horizontal,
                            itemCount: 10,
                            itemSize: 18,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber[600],
                            ),
                            unratedColor: Colors.white30,
                          ),
                          Text(
                            '${movie.voteAverage!} (${movie.voteCount!})',
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          )
                        ],
                      )
                  ),
                  const Spacer(),
                  FutureBuilder(
                      future: DatabaseMovies.isFavorite(idMovie),
                      builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                        if(snapshot.hasError) {
                          return const Text("E");
                        }
                        else {
                          if (snapshot.connectionState == ConnectionState.done) {
                            isFavorite = snapshot.data!;
                            return IconButton(
                                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline),
                                iconSize: 20,
                                color: Colors.white,
                                onPressed: () {
                                  if(!isFavorite) {
                                    DatabaseMovies.insert(movie.toMap());
                                  }
                                  else {
                                    DatabaseMovies.delete(idMovie);
                                  }
                                  setState(() {
                                    isFavorite = !isFavorite;
                                  });
                                }
                            );
                          }
                          else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        }
                      }
                  ),
                ]
              ),
              Flexible(
                child: Text(
                  movie.overview!,
                  style: const TextStyle(
                    color: Colors.white
                  ),
                  textAlign: TextAlign.justify,
                )
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'Cast',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.left,
                )
              ),
              Expanded(
                flex: 4,
                child: SizedBox(
                  child: FutureBuilder(
                    future: ApiMovies.getCast(idMovie),
                    builder: (BuildContext context, AsyncSnapshot<List<Cast>?> snapshot) {
                      if(snapshot.hasError) {
                        return oopsAnErrorHappened();
                      }
                      else {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return _castList(snapshot.data!);
                        }
                        else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      }
                    },
                  )
                )
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    idMovie = ((ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map)['idMovie'];
    titleMovie = ((ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map)['title'];
    //_getIfFavorite();

    return Scaffold(
      appBar: AppBar(
        title: Text(titleMovie),
        elevation: 1,
        backgroundColor: const Color(0xFF363637),
      ),
      body: FutureBuilder(
          future: ApiMovies.getMovieDetails(idMovie),
          builder: (BuildContext context, AsyncSnapshot<Movie?> snapshot) {
            if(snapshot.hasError) {
              return oopsAnErrorHappened();
            }
            else {
              if (snapshot.connectionState == ConnectionState.done) {
                return _details(snapshot.data);
              }
              else {
                return const Center(child: CircularProgressIndicator());
              }
            }
          }
      ),
    );
  }
}