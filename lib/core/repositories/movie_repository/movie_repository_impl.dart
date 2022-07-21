import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:movie_bloc/core/data_sources/movies/movies_local_data_source.dart';
import 'package:movie_bloc/core/data_sources/movies/movies_remote_data_source.dart';
import 'package:movie_bloc/core/exceptions/cache_exception.dart';
import 'package:movie_bloc/core/exceptions/network_exception.dart';
import 'package:movie_bloc/core/exceptions/repository_exception.dart';
import 'package:movie_bloc/core/models/movie_trailer/trailer_model.dart';
import 'package:movie_bloc/core/models/trending_movies/movie_response.dart';
import 'package:movie_bloc/core/repositories/movie_repository/movie_repository.dart';
import 'package:movie_bloc/core/services/connectivity/connectivity_service.dart';
import 'package:movie_bloc/locator.dart';

part "movie_data_state.dart";

class MovieRepositoryImpl extends Cubit<MovieDataState>
    implements MovieRepository {
  final MoviesRemoteDataSource? remoteDataSource =
      locator<MoviesRemoteDataSource>();
  final MoviesLocalDataSource? localDataSource =
      locator<MoviesLocalDataSource>();
  final ConnectivityService? connectivityService =
      locator<ConnectivityService>();

  final _log = Logger('MovieRepositoryImpl');

  MovieRepositoryImpl() : super(MovieDataLoading()) {
    fetchTrendingMovies();
  }

  Result recommendedMovie = Result();

  @override
  Future<List<Result>> fetchTrendingMovies() async {
    emit(MovieDataLoading());
    try {
      if (await connectivityService!.isConnected) {
        final moviesList = await remoteDataSource!.fetchMovies();
        await localDataSource!.cacheMovies(moviesList);
        _log.fine("Test: ${moviesList.toString()}");
        recommendedMovie = moviesList[Random().nextInt(moviesList.length)];
        emit(MovieDataSuccess(
            movieList: moviesList, recommendedMovie: recommendedMovie));
        return moviesList;
      } else {
        final moviesList = await localDataSource!.fetchMovies();
        _log.fine("Test: ${moviesList.toList()}");
        recommendedMovie = moviesList[Random().nextInt(moviesList.length)];
        emit(MovieDataSuccess(
            movieList: moviesList, recommendedMovie: recommendedMovie));
        return moviesList;
      }
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch movies list remotely');
      emit(MovieDataError());
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch movies list locally');
      emit(MovieDataError());
      throw RepositoryException(e.message);
    }
  }

  @override
  Future<List<Result>> fetchPopularMovies() {
    // TODO: implement fetchPopularMovies
    throw UnimplementedError();
  }

  @override
  Future<TrailerModel> fetchTrailer(int movieId) async {
    try {
      final trailerData = await remoteDataSource!.fetchTrailer(movieId);
      _log.fine("Test: ${trailerData.toString()}");
      return trailerData;
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch trailer remotely');
      throw RepositoryException(e.message);
    }
  }
}
