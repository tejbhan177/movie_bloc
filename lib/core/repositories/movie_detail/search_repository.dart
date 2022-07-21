import 'package:movie_bloc/core/models/trending_movies/movie_response.dart';

abstract class SearchRepository {
  Future<List<Result>> searchMovie({required String query});
}
