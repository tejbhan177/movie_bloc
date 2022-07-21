import 'package:flutter/material.dart';
import 'package:movie_bloc/core/models/trending_movies/movie_response.dart';
import 'package:movie_bloc/ui/shared/fade_page_route.dart';
import 'package:movie_bloc/ui/views/movie_detail/movie_detail.dart';

class Navigate {
  static openDetailPage(
      {required BuildContext context, required Result recommendedMovie}) {
    Navigator.push(
        context,
        FadePageRoute(
            fullscreenDialog: true,
            builder: (_) => MovieDetail(detail: recommendedMovie)));
  }
}
