
import 'package:flutter/material.dart';

import '../models/Movie.dart';

class CardMovie extends StatelessWidget {
  CardMovie({Key? key, this.movie}) : super(key : key);

  Movie? movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0.0, 5.0),
            blurRadius: 2.5
          )
        ]
      ),
      child: ClipRect(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/loading.gif'),
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${movie!.backdropPath}'),
                fadeInDuration: const Duration(milliseconds: 1000),
              ),
            ),
            Opacity(
              opacity: .5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 60,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      movie!.title!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/detail',
                              arguments: {
                                'idMovie': movie!.id,
                                'title': movie!.title
                              });
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}