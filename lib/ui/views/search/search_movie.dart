import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc/core/models/search_movie/search_movie.dart';
import 'package:movie_bloc/core/models/trending_movies/movie_response.dart';
import 'package:movie_bloc/core/navigation/navigation.dart';
import 'package:movie_bloc/core/repositories/movie_detail/search_repository_impl.dart';
import 'package:movie_bloc/core/utils/debounce.dart';
import 'package:movie_bloc/ui/widgets/movie_card.dart';
import 'package:movie_bloc/ui/widgets/search_text_field.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    SearchRepositoryImpl searchCubit =
        BlocProvider.of<SearchRepositoryImpl>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Platform.isAndroid
                        ? Icons.arrow_back
                        : CupertinoIcons.back)),
                Expanded(
                  child: SearchTextField(
                      fillColor: Colors.grey[900]!,
                      hintText: 'Search for a movie.',
                      searchCallback: (String value) => EasyDebounce.debounce(
                          'search',
                          const Duration(milliseconds: 300),
                          () => searchCubit.searchMovie(query: value)),
                      controller: _controller),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<SearchRepositoryImpl, SearchMovieState>(
                  builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ));
                } else if (state is SearchSuccess) {
                  return searchResult(
                      searchList: state.searchList, orientation: orientation);
                } else if (state is SearchError) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: Text(
                      'Error in loading data!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchResult(
      {required List<Movie> searchList, required Orientation orientation}) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0),
          child: Text(
            'Top Results',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        GridView.builder(
            itemCount: searchList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: orientation == Orientation.portrait ? 3 : 6,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 2 / 3),
            itemBuilder: (BuildContext context, int index) {
              return InkResponse(
                enableFeedback: true,
                child: MovieCard(url: searchList[index].posterPath ?? ''),
                onTap: () => Navigate.openDetailPage(
                    context: context,
                    recommendedMovie: Result(
                      id: searchList[index].id,
                      title: searchList[index].title,
                      adult: searchList[index].adult,
                      backdropPath: searchList[index].backdropPath,
                      firstAirDate: searchList[index].firstAirDate,
                      genreIds: List.generate(
                          searchList[index].genreIds!.length,
                          (i) => searchList[index].genreIds![i]),
                      mediaType: searchList[index].mediaType,
                      name: searchList[index].name,
                      originalLanguage: searchList[index].originalLanguage,
                      originalTitle: searchList[index].originalTitle,
                      overview: searchList[index].overview,
                      popularity: searchList[index].popularity!.toDouble(),
                      posterPath: searchList[index].posterPath,
                      releaseDate: searchList[index].releaseDate,
                      video: searchList[index].video,
                      voteAverage: searchList[index].voteAverage!.toDouble(),
                      voteCount: searchList[index].voteCount,
                    )),
              );
            })
      ],
    );
  }
}
