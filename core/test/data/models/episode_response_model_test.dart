import 'dart:convert';

import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/episode_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../core/test/json_reader.dart';

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
  final tEpisodeResponseModel = EpisodeResponseModel(
    airDate: "2020-01-01",
    episodes: <EpisodeModel>[tEpisodeModel],
    name: "name",
    overview: "overview",
    id: 1,
    posterPath: "posterPath",
    seasonNumber: 1,
  );
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/series_episode.json'));
      // act
      final result = EpisodeResponseModel.fromJson(jsonMap);
      // assert
      expect(result, tEpisodeResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tEpisodeResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "air_date": '2020-01-01',
        "episodes": [
          {
            "air_date": '2020-01-01',
            "episode_number": 1,
            "id": 1,
            "name": "name",
            "overview": "overview",
            "season_number": 1,
            "still_path": "stillPath",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
        "name": "name",
        "overview": "overview",
        "id": 1,
        "poster_path": "posterPath",
        "season_number": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}
