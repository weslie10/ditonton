import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';

class SeriesModel extends Equatable {
  SeriesModel({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final String? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  factory SeriesModel.fromJson(Map<String, dynamic> json) => SeriesModel(
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        id: json["id"],
        originalName: json["original_name"],
        originalLanguage: json["original_language"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "id": id,
        "original_name": originalName,
        "original_language": originalLanguage,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  Series toEntity() {
    return Series(
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      originalName: this.originalName,
      originalLanguage: this.originalLanguage,
      originCountry: this.originCountry,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      firstAirDate: this.firstAirDate,
      name: this.name,
      voteAverage: this.voteAverage.toDouble(),
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        originalName,
        originalLanguage,
        originCountry,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
      ];
}
