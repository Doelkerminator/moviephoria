
import 'package:flutter/cupertino.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({Key? key}) : super(key : key);

  @override
  State<MovieDetail> createState() => _MovieDetail();
}

class _MovieDetail extends State<MovieDetail> {

  @override
  Widget build(BuildContext context) {

    final idMovie = ((ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map)['idMovie'];

    return Column(
      children: [
        Center(
          child: Text('Recibí esta wea de: $idMovie \nNo se que sea'),
        )
      ],
    );
  }
}