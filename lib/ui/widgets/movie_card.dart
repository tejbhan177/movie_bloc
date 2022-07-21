import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_bloc/core/constant/colors.dart';
import 'package:movie_bloc/core/constant/env.dart';
import 'package:movie_bloc/ui/widgets/shimmer/shimmer.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: black,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Stack(
          children: [
            url.isEmpty
                ? shimmer(size: MediaQuery.of(context).size)
                : CachedNetworkImage(
                    imageUrl: Env.imageBaseUrlW400 + url,
                    fit: BoxFit.cover,
                  ),
            const Align(
              alignment: Alignment.center,
              child: Center(
                child: Icon(
                  CupertinoIcons.play_circle,
                  color: white,
                  size: 50.0,
                ),
              ),
            ),
          ],
        ));
  }
}
