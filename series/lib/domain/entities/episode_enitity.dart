import 'package:equatable/equatable.dart';

import 'episode.dart';

class EpisodeEntity extends Equatable {
  EpisodeEntity({
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String airDate;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final int id;
  final String posterPath;
  final int seasonNumber;

  @override
  List<Object> get props => [
        airDate,
        episodes,
        name,
        overview,
        id,
        posterPath,
        seasonNumber,
      ];
}
