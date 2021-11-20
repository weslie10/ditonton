import 'package:equatable/equatable.dart';

class Seasons extends Equatable {
  Seasons({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episodeCount,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  @override
  List<Object> get props => [
        id,
        name,
        airDate,
        episodeCount,
        overview,
        posterPath,
        seasonNumber,
      ];
}
