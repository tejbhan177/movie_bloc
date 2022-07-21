import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:movie_bloc/core/constant/local_storage_keys.dart';
import 'package:movie_bloc/core/exceptions/cache_exception.dart';
import 'package:movie_bloc/core/models/trending_movies/movie_response.dart';
import 'package:movie_bloc/core/models/trending_movies/trending_movie_hive.dart';
import 'package:movie_bloc/core/utils/file_helper.dart';
import 'package:movie_bloc/locator.dart';

abstract class MoviesLocalDataSource {
  Future<void> init();

  Future<List<Result>> fetchMovies();

  Future<void> cacheMovies(List<Result> movieList);
}

class MoviesLocalDataSourceImpl implements MoviesLocalDataSource {
  final FileHelper? _fileHelper = locator<FileHelper>();
  final HiveInterface? _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen =>
      _hiveService!.isBoxOpen(LocalStorageKeys.trendingMovie);

  Box<TrendingMoviesHive> get _moviesBox =>
      _hiveService!.box<TrendingMoviesHive>(LocalStorageKeys.trendingMovie);

  @override
  Future<void> init() async {
    final path = await _fileHelper!.getApplicationDocumentsDirectoryPath();
    _hiveService!.init(path);
    _hiveService!
        .registerAdapter<TrendingMoviesHive>(TrendingMoviesHiveAdapter());

    if (!_isBoxOpen) {
      await _hiveService!
          .openBox<TrendingMoviesHive>(LocalStorageKeys.trendingMovie);
    }
  }

  @override
  Future<List<Result>> fetchMovies() async {
    if (!_isBoxOpen) {
      await _hiveService!
          .openBox<TrendingMoviesHive>(LocalStorageKeys.trendingMovie);
    }
    if (_moviesBox.isEmpty) {
      throw const CacheException('No movie list found in cache');
    }
    return _moviesBox.values
        .map<Result>(
            (trendingMovieHive) => Result.fromMap(trendingMovieHive.toMap()))
        .toList();
  }

  @override
  Future<void> cacheMovies(List<Result> movieList) async {
    final moviesMap = <int, TrendingMoviesHive>{};
    for (var movie in movieList) {
      moviesMap.addAll({movie.id!: TrendingMoviesHive.fromModel(movie)});
    }
    await _moviesBox.putAll(moviesMap);
  }
}
