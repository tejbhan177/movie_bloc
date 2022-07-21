import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:movie_bloc/core/data_sources/movies/movies_remote_data_source.dart';
import 'package:movie_bloc/core/exceptions/network_exception.dart';
import 'package:movie_bloc/core/exceptions/repository_exception.dart';
import 'package:movie_bloc/core/models/trending_movies/movie_response.dart';
import 'package:movie_bloc/core/repositories/movie_detail/search_repository.dart';
import 'package:movie_bloc/locator.dart';

part 'search_movie_state.dart';

class SearchRepositoryImpl extends Cubit<SearchMovieState>
    implements SearchRepository {
  final MoviesRemoteDataSource? remoteDataSource =
      locator<MoviesRemoteDataSource>();

  final _log = Logger('SearchMovieImpl');

  SearchRepositoryImpl() : super(SearchInitial());

  @override
  Future<List<Result>> searchMovie({required String query}) async {
    emit(SearchLoading());
    try {
      final trailerData = await remoteDataSource!.searchMovie(query);
      _log.fine("Test: ${trailerData.toString()}");
      emit(SearchSuccess(searchList: trailerData));
      return trailerData;
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch search result remotely');
      emit(SearchError());
      throw RepositoryException(e.message);
    }
  }
}