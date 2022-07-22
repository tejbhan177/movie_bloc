import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_bloc/core/navigation/navigation.dart';

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
          onPressed: () => Navigate.openSearchPage(context),
          icon: const Icon(CupertinoIcons.search)),
      IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.sort_down))
    ],
  );
}
