/// List of api end points
class ApiRoutes {
  ApiRoutes._();

  static const getTrendingMovies = "/trending/all/week";
  static const searchMovies = "/search/movie";
  static movieDetail(id) => "/movie/$id/videos";
}
