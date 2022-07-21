import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_bloc/core/constant/env.dart';
import 'package:movie_bloc/core/data_sources/movies/movies_remote_data_source.dart';
import 'package:movie_bloc/core/models/movie_trailer/trailer_model.dart';
import 'package:movie_bloc/core/models/trending_movies/movie_response.dart';
import 'package:movie_bloc/locator.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({Key? key, required this.detail}) : super(key: key);

  final Result detail;

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final MoviesRemoteDataSource? remoteDataSource =
      locator<MoviesRemoteDataSource>();

  @override
  Widget build(BuildContext context) {
    var info = widget.detail;
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  elevation: 0.0,
                  flexibleSpace: FlexibleSpaceBar(
                      background: CachedNetworkImage(
                    imageUrl: Env.imageBaseUrlW500 + info.posterPath!,
                    fit: BoxFit.cover,
                  )),
                ),
              ];
            },
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(margin: const EdgeInsets.only(top: 5.0)),
                      Text(
                        info.title ?? info.name ?? 'Movie',
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(left: 1.0, right: 1.0),
                          ),
                          Text(
                            info.voteAverage!.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                          ),
                          Text(
                            info.releaseDate ?? info.firstAirDate ?? '-/-/-',
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                      Text(info.overview!),
                      Container(
                          margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                      const Text(
                        "Trailer",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                      FutureBuilder(
                        future:
                            remoteDataSource!.fetchTrailer(widget.detail.id!),
                        builder:
                            (context, AsyncSnapshot<TrailerModel> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.results.isNotEmpty) {
                              return trailerLayout(snapshot.data!);
                            } else {
                              return noTrailer();
                            }
                          } else if (snapshot.hasError) {
                            return noTrailer();
                          } else {
                            return const Center(
                                child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.red),
                            ));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget noTrailer() {
    return const Center(
      child: Text("No trailer available"),
    );
  }

  Widget trailerLayout(TrailerModel data) {
    return GridView.builder(
        itemCount: data.results.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 16 / 10),
        itemBuilder: (BuildContext context, int index) {
          return trailerItem(data.results[index]);
        });
  }

  trailerItem(TrailerResult data) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(5.0),
            color: Colors.grey,
            child: const Center(child: Icon(Icons.play_circle_filled)),
          ),
        ),
        Text(
          data.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
