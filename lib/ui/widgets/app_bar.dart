import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_bloc/ui/shared/fade_page_route.dart';
import 'package:movie_bloc/ui/views/search/search_movie.dart';

PreferredSizeWidget customAppBar(BuildContext context) {
  return AppBar(
    title: Image.asset(
      'assets/images/logo.png',
      height: 30,
    ),
    centerTitle: true,
    backgroundColor: Colors.black,
    actions: [
      IconButton(
          onPressed: () => Navigator.push(
              context,
              FadePageRoute(
                  fullscreenDialog: true, builder: (_) => const SearchMovie())),
          icon: const Icon(CupertinoIcons.search)),
      IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.sort_down))
    ],
  );
}
