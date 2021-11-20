import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/seasons.dart';

class SeriesDetail extends Equatable {
  SeriesDetail({
    required this.backdropPath,
    required this.firstAirDate,
    required this.episodeRunTime,
    required this.genres,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.seasons,
    required this.voteAverage,
    required this.voteCount,
  });

  final String backdropPath;
  final String firstAirDate;
  final List<int> episodeRunTime;
  final List<Genre> genres;
  final List<Seasons> seasons;
  final int id;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        episodeRunTime,
        genres,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        posterPath,
        seasons,
        voteAverage,
        voteCount,
      ];
}
