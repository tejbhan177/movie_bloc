import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc/core/constant/env.dart';
import 'package:movie_bloc/core/models/trending_movies/movie_response.dart';
import 'package:movie_bloc/core/repositories/movie_repository/movie_repository_impl.dart';
import 'package:movie_bloc/core/services/connectivity/connectivity_service.dart';
import 'package:movie_bloc/locator.dart';
import 'package:movie_bloc/ui/shared/fade_page_route.dart';
import 'package:movie_bloc/ui/views/movie_detail/movie_detail.dart';
import 'package:movie_bloc/ui/widgets/app_bar.dart';
import 'package:movie_bloc/ui/widgets/movie_card.dart';
import 'package:movie_bloc/ui/widgets/shimmer/shimmer_home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ConnectivityService? connectivityService =
      locator<ConnectivityService>();

  @override
  void initState() {
    super.initState();
    _deleteImageFromCache();
  }

  Future _deleteImageFromCache() async {
    if (await connectivityService!.isConnected) {
      await CachedNetworkImage.evictFromCache('main');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar(context),
      body: SafeArea(
        child: BlocBuilder<MovieRepositoryImpl, MovieDataState>(
            builder: (context, state) {
          if (state is MovieDataLoading) {
            return const HomeShimmer();
          } else if (state is MovieDataSuccess) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                suggestMovie(size, state.recommendedMovie),
                const SizedBox(height: 30),
                buildList(state.movieList),
              ],
            );
          } else {
            return errorWidget(size);
          }
        }),
      ),
    );
  }

  Widget buildList(List<Result> movieList) {
    return GridView.builder(
        itemCount: movieList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 2 / 3),
        itemBuilder: (BuildContext context, int index) {
          return InkResponse(
            enableFeedback: true,
            child: MovieCard(url: movieList[index].posterPath!),
            onTap: () => openDetailPage(movieList[index]),
          );
        });
  }

  Widget suggestMovie(Size size, Result recommendedMovie) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => openDetailPage(recommendedMovie),
            child: CachedNetworkImage(
              cacheKey: 'main',
              imageUrl: Env.imageBaseUrlW500 + recommendedMovie.posterPath!,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 30,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black, spreadRadius: 40, blurRadius: 30),
              ]),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                    ),
                    Text(
                      recommendedMovie.voteAverage!.toStringAsFixed(1),
                      style:
                          const TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => openDetailPage(recommendedMovie),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    textStyle: Theme.of(context).textTheme.displayMedium,
                  ),
                  child: const Text(
                    'Play',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                    ),
                    Text(
                      'Info',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget errorWidget(Size size) {
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 35,),
          const SizedBox(
            height: 20,
          ),
          Text("Error in data loading",
              style: Theme.of(context).textTheme.headline5),
        ],
      ),
    );
  }

  openDetailPage(Result recommendedMovie) {
    Navigator.push(
        context,
        FadePageRoute(
            fullscreenDialog: true,
            builder: (_) => MovieDetail(detail: recommendedMovie)));
  }
}
