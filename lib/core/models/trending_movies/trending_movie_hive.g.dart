// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_movie_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrendingMoviesHiveAdapter extends TypeAdapter<TrendingMoviesHive> {
  @override
  final int typeId = 1;

  @override
  TrendingMoviesHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrendingMoviesHive(
      vote_count: fields[0] as int?,
      id: fields[1] as int?,
      video: fields[2] as bool?,
      vote_average: fields[3] as double?,
      title: fields[4] as String?,
      name: fields[14] as String?,
      popularity: fields[5] as double?,
      poster_path: fields[6] as String?,
      original_language: fields[7] as String?,
      original_title: fields[8] as String?,
      genre_ids: (fields[9] as List?)?.cast<int>(),
      backdrop_path: fields[10] as String?,
      adult: fields[11] as bool?,
      overview: fields[12] as String?,
      first_air_date: fields[15] as String?,
      release_date: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TrendingMoviesHive obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.vote_count)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.video)
      ..writeByte(3)
      ..write(obj.vote_average)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.popularity)
      ..writeByte(6)
      ..write(obj.poster_path)
      ..writeByte(7)
      ..write(obj.original_language)
      ..writeByte(8)
      ..write(obj.original_title)
      ..writeByte(9)
      ..write(obj.genre_ids)
      ..writeByte(10)
      ..write(obj.backdrop_path)
      ..writeByte(11)
      ..write(obj.adult)
      ..writeByte(12)
      ..write(obj.overview)
      ..writeByte(13)
      ..write(obj.release_date)
      ..writeByte(14)
      ..write(obj.name)
      ..writeByte(15)
      ..write(obj.first_air_date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrendingMoviesHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
