import 'package:equatable/equatable.dart';

import 'package:series/data/models/episode_model.dart';
import 'package:series/domain/entities/episode_enitity.dart';

class EpisodeResponseModel extends Equatable {
  EpisodeResponseModel({
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String airDate;
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final int id;
  final String posterPath;
  final int seasonNumber;

  factory EpisodeResponseModel.fromJson(Map<String, dynamic> json) =>
      EpisodeResponseModel(
        airDate: json["air_date"],
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        id: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": id,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  EpisodeEntity toEntity() {
    return EpisodeEntity(
      airDate: this.airDate,
      episodes: this.episodes.map((episode) => episode.toEntity()).toList(),
      name: this.name,
      overview: this.overview,
      id: this.id,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodes,
        name,
        overview,
        id,
        posterPath,
        seasonNumber,
      ];
}
