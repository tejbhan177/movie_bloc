import 'package:movie_bloc/core/constant/api_routes.dart';
import 'package:movie_bloc/core/models/movie_trailer/trailer_model.dart';
import 'package:movie_bloc/core/services/http/http_service.dart';
import 'package:movie_bloc/locator.dart';
import '../../models/trending_movies/movie_response.dart';

abstract class MoviesRemoteDataSource {
  Future<List<Result>> fetchMovies();

  Future<TrailerModel> fetchTrailer(int movieId);

  Future<List<Result>> searchMovie(String query);
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final HttpService? httpService = locator<HttpService>();

  @override
  Future<List<Result>> fetchMovies() async {
    final moviesJsonData =
        await httpService!.getHttp(route: ApiRoutes.getTrendingMovies);
    TrendingMovies movies = TrendingMovies.fromJson(moviesJsonData);
    return movies.results!;
  }

  @override
  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response =
        await httpService!.getHttp(route: ApiRoutes.movieDetail(movieId));
    TrailerModel model = TrailerModel.fromJson(response);
    return model;
  }

  @override
  Future<List<Result>> searchMovie(String query) async {
    Map<String, dynamic> searchQuery = {};
    searchQuery['query'] = query;
    final response = await httpService!
        .getHttp(route: ApiRoutes.searchMovies, query: searchQuery);
    List<Result> model = TrendingMovies.fromJson(response).results!;
    return model;
  }
}
