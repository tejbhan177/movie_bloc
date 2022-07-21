part of 'search_repository_impl.dart';

@immutable
abstract class SearchMovieState {}

class SearchLoading extends SearchMovieState {}

class SearchError extends SearchMovieState {}

class SearchInitial extends SearchMovieState {}

class SearchSuccess extends SearchMovieState {
  final List<Result> searchList;

  SearchSuccess({required this.searchList});
}
