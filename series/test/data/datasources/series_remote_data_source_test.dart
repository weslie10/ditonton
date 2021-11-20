import 'dart:convert';
import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:series/data/datasources/series_remote_data_source.dart';
import 'package:series/data/models/episode_response.dart';
import 'package:series/data/models/series_detail_model.dart';
import 'package:series/data/models/series_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late SeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Tv Show', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series_now_playing.json')))
        .seriesList;

    test('should return list of Tv Show Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/series_now_playing.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      // act
      final result = await dataSource.getNowPlayingSeries();
      // assert
      expect(result, equals(tSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Show', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series_popular.json')))
        .seriesList;

    test('should return list of tv show when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/series_popular.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      // act
      final result = await dataSource.getPopularSeries();
      // assert
      expect(result, tSeriesList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Show', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series_top_rated.json')))
        .seriesList;

    test('should return list of tv show when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/series_top_rated.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      // act
      final result = await dataSource.getTopRatedSeries();
      // assert
      expect(result, tSeriesList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show detail', () {
    final tId = 90462;
    final tSeriesDetail = SeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/series_detail.json')));

    test('should return tv show detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/series_detail.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      // act
      final result = await dataSource.getSeriesDetail(tId);
      // assert
      expect(result, equals(tSeriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show episode', () {
    final tId = 90462;
    final seasons = 1;
    final tSeriesDetail = EpisodeResponseModel.fromJson(
        json.decode(readJson('dummy_data/series_episode.json')));

    test(
        'should return tv show episode seasons 1 when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/season/$seasons?$API_KEY')))
          .thenAnswer(
        (_) async =>
            http.Response(readJson('dummy_data/series_episode.json'), 200),
      );
      // act
      final result = await dataSource.getSeriesEpisode(tId, seasons);
      // assert
      expect(result, equals(tSeriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/season/$seasons?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesEpisode(tId, seasons);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show recommendations', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series_recommendations.json')))
        .seriesList;
    final tId = 90462;

    test('should return list of Tv Show Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/series_recommendations.json'), 200));
      // act
      final result = await dataSource.getSeriesRecommendations(tId);
      // assert
      expect(result, equals(tSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv show', () {
    final tSearchResult = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_good_doctor_series.json')))
        .seriesList;
    final tQuery = 'Good Doctor';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_good_doctor_series.json'), 200));
      // act
      final result = await dataSource.searchSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
