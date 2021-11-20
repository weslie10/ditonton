import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tEpisodeModel = EpisodeModel(
    airDate: "2020-01-01",
    seasonNumber: 1,
    stillPath: "stillPath",
    overview: "overview",
    name: "name",
    id: 1,
    voteAverage: 1,
    voteCount: 1,
    episodeNumber: 1,
  );

  final tEpisode = Episode(
    airDate: "2020-01-01",
    seasonNumber: 1,
    stillPath: "stillPath",
    overview: "overview",
    name: "name",
    id: 1,
    voteAverage: 1,
    voteCount: 1,
    episodeNumber: 1,
  );

  test('should be a subclass of Episode entity', () async {
    final result = tEpisodeModel.toEntity();
    expect(result, tEpisode);
  });
}
