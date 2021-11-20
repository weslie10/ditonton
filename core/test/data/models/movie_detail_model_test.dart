import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../core/test/json_reader.dart';

void main() {
  final testMovieDetail = MovieDetail(
    adult: false,
    backdropPath: '/path.jpg',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview',
    posterPath: '/path.jpg',
    releaseDate: "2020-05-05",
    runtime: 120,
    title: 'Title',
    voteAverage: 1,
    voteCount: 1,
  );

  final testMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: "/path.jpg",
    budget: 100,
    genres: [GenreModel(id: 1, name: "Action")],
    homepage: "https://google.com",
    id: 1,
    imdbId: "imdb1",
    originalLanguage: "en",
    originalTitle: "Original Title",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2020-05-05",
    revenue: 12000,
    runtime: 120,
    status: "Status",
    tagline: "Tagline",
    title: "Title",
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('should be a subclass of Genre entity', () async {
    final result = testMovieDetailResponse.toEntity();
    expect(result, testMovieDetail);
  });
  test('should return a valid model from JSON', () async {
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/movie_detail.json'));
    // act
    final result = MovieDetailResponse.fromJson(jsonMap);
    // assert
    expect(result, testMovieDetailResponse);
  });
  test('should return a JSON map containing proper data', () async {
    final result = testMovieDetailResponse.toJson();
    // assert
    final expectedJsonMap = {
      "adult": false,
      "backdrop_path": "/path.jpg",
      "budget": 100,
      "genres": [
        {"id": 1, "name": "Action"}
      ],
      "homepage": "https://google.com",
      "id": 1,
      "imdb_id": "imdb1",
      "original_language": "en",
      "original_title": "Original Title",
      "overview": "Overview",
      "popularity": 1.0,
      "poster_path": "/path.jpg",
      "release_date": "2020-05-05",
      "revenue": 12000,
      "runtime": 120,
      "status": "Status",
      "tagline": "Tagline",
      "title": "Title",
      "video": false,
      "vote_average": 1.0,
      "vote_count": 1
    };
    expect(result, expectedJsonMap);
  });
}
