import 'package:movie_bloc/core/models/movie_trailer/trailer_model.dart';
import 'package:movie_bloc/core/models/trending_movies/movie_response.dart';

abstract class MovieRepository {
  Future<List<Result>> fetchTrendingMovies();
  Future<List<Result>> fetchPopularMovies();
  Future<TrailerModel> fetchTrailer(int movieId);
}
