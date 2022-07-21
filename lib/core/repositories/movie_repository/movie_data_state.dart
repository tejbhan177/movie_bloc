part of 'movie_repository_impl.dart';

@immutable
abstract class MovieDataState {}

class MovieDataLoading extends MovieDataState {}

class MovieDataError extends MovieDataState {}

class MovieDataSuccess extends MovieDataState {
  final List<Result> movieList;
  final Result recommendedMovie;

  MovieDataSuccess({required this.movieList, required this.recommendedMovie});
}
