import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:movie_bloc/core/data_sources/movies/movies_remote_data_source.dart';
import 'package:movie_bloc/core/exceptions/network_exception.dart';
import 'package:movie_bloc/core/exceptions/repository_exception.dart';
import 'package:movie_bloc/core/models/search_movie/search_movie.dart';
import 'package:movie_bloc/core/repositories/search_repository/search_repository.dart';
import 'package:movie_bloc/locator.dart';

part 'search_movie_state.dart';

class SearchRepositoryImpl extends Cubit<SearchMovieState>
    implements SearchRepository {
  final MoviesRemoteDataSource? remoteDataSource =
      locator<MoviesRemoteDataSource>();

  final _log = Logger('SearchMovieImpl');

  SearchRepositoryImpl() : super(SearchInitial());

  @override
  Future<void> searchMovie({required String query}) async {
    emit(SearchLoading());
    try {
      final searchResult = await remoteDataSource!.searchMovie(query);
      _log.fine("Test: ${searchResult.toString()}");
      emit(SearchSuccess(searchList: searchResult));
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch search result remotely');
      emit(SearchError());
      throw RepositoryException(e.message);
    }
  }
}
