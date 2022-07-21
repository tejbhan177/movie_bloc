import 'package:hive/hive.dart';
import 'movie_response.dart';

part 'trending_movie_hive.g.dart';

/// A Hive Database compatible Movie List Model
///   - @HiveType(typeId: unique) is necessary for each HiveObject
///   - @HiveField(unique) is necessary if you need the object to persist
@HiveType(typeId: 1)
class TrendingMoviesHive extends HiveObject {
  @HiveField(0)
  final int? vote_count;

  @HiveField(1)
  final int? id;

  @HiveField(2)
  final bool? video;

  @HiveField(3)
  final double? vote_average;

  @HiveField(4)
  final String? title;

  @HiveField(5)
  final double? popularity;

  @HiveField(6)
  final String? poster_path;

  @HiveField(7)
  final String? original_language;

  @HiveField(8)
  final String? original_title;

  @HiveField(9)
  final List<int>? genre_ids;

  @HiveField(10)
  final String? backdrop_path;

  @HiveField(11)
  final bool? adult;

  @HiveField(12)
  final String? overview;

  @HiveField(13)
  final String? release_date;

  @HiveField(14)
  final String? name;

  @HiveField(15)
  final String? first_air_date;

  TrendingMoviesHive(
      {this.vote_count,
      this.id,
      this.video,
      this.vote_average,
      this.title,
      this.name,
      this.popularity,
      this.poster_path,
      this.original_language,
      this.original_title,
      this.genre_ids,
      this.backdrop_path,
      this.adult,
      this.overview,
      this.first_air_date,
      this.release_date});

  factory TrendingMoviesHive.fromModel(Result movies) {
    return TrendingMoviesHive(
      vote_count: movies.voteCount,
      id: movies.id,
      video: movies.video,
      vote_average: movies.voteAverage,
      title: movies.title,
      name: movies.name,
      popularity: movies.popularity,
      poster_path: movies.posterPath,
      original_language: movies.originalLanguage,
      original_title: movies.originalTitle,
      genre_ids: movies.genreIds,
      backdrop_path: movies.backdropPath,
      adult: movies.adult,
      overview: movies.overview,
      first_air_date: movies.firstAirDate,
      release_date: movies.releaseDate,
    );
  }

  factory TrendingMoviesHive.fromMap(Map<String, dynamic> map) {
    return TrendingMoviesHive(
        vote_count: map['vote_count'],
        id: map['id'],
        video: map['video'],
        vote_average: map['vote_average'],
        title: map['title'],
        name: map['name'],
        popularity: map['popularity'],
        poster_path: map['poster_path'],
        original_language: map['original_language'],
        original_title: map['original_title'],
        genre_ids: map['genre_ids'],
        backdrop_path: map['backdrop_path'],
        adult: map['adult'],
        overview: map['overview'],
        first_air_date: map['first_air_date'],
        release_date: map['release_date']);
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['vote_count'] = vote_count;
    map['id'] = id;
    map['video'] = video;
    map['vote_average'] = vote_average;
    map['title'] = title;
    map['name'] = name;
    map['popularity'] = popularity;
    map['poster_path'] = poster_path;
    map['original_language'] = original_language;
    map['original_title'] = original_title;
    map['genre_ids'] = genre_ids;
    map['backdrop_path'] = backdrop_path;
    map['adult'] = adult;
    map['overview'] = overview;
    map['first_air_date'] = first_air_date;
    map['release_date'] = release_date;
    return map;
  }

  @override
  int get hashCode =>
      vote_count.hashCode ^
      id.hashCode ^
      video.hashCode ^
      vote_average.hashCode ^
      title.hashCode ^
      name.hashCode ^
      popularity.hashCode ^
      poster_path.hashCode ^
      original_language.hashCode ^
      original_title.hashCode ^
      genre_ids.hashCode ^
      backdrop_path.hashCode ^
      adult.hashCode ^
      overview.hashCode ^
      first_air_date.hashCode ^
      release_date.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrendingMoviesHive &&
          runtimeType == other.runtimeType &&
          vote_count == other.vote_count &&
          id == other.id &&
          video == other.video &&
          vote_average == other.vote_average &&
          title == other.title &&
          name == other.name &&
          popularity == other.popularity &&
          poster_path == other.poster_path &&
          original_language == other.original_language &&
          original_title == other.original_title &&
          genre_ids == other.genre_ids &&
          backdrop_path == other.backdrop_path &&
          adult == other.adult &&
          overview == other.overview &&
          first_air_date == other.first_air_date &&
          release_date == other.release_date;
}
