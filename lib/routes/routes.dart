
import 'package:flutter/cupertino.dart';
import 'package:moviephoria/screens/movie_detail.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder> {
    '/detail' : (BuildContext context) => const MovieDetail()
  };
}