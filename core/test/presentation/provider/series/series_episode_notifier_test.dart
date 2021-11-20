import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/episode_enitity.dart';
import 'package:ditonton/domain/usecases/series/get_series_episode.dart';
import 'package:ditonton/presentation/provider/series/series_episode_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'series_episode_notifier_test.mocks.dart';

@GenerateMocks([GetSeriesEpisode])
void main() {
  late MockGetSeriesEpisode mockGetSeriesEpisode;
  late SeriesEpisodeNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeriesEpisode = MockGetSeriesEpisode();
    notifier = SeriesEpisodeNotifier(getSeriesEpisode: mockGetSeriesEpisode)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tSeries = EpisodeEntity(
    airDate: "2020-01-01",
    episodes: [
      Episode(
        airDate: "2020-01-01",
        seasonNumber: 1,
        stillPath: "stillPath",
        overview: "overview",
        name: "name",
        id: 1,
        voteAverage: 1,
        voteCount: 1,
        episodeNumber: 1,
      )
    ],
    name: "name",
    overview: "overview",
    id: 1,
    posterPath: "posterPath",
    seasonNumber: 1,
  );
  final id = 90462;
  final seasons = 1;

  final tSeriesList = <EpisodeEntity>[tSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetSeriesEpisode.execute(id, seasons))
        .thenAnswer((_) async => Right(tSeries));
    // act
    notifier.fetchSeriesEpisode(id, seasons);
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change series data when data is gotten successfully', () async {
    // arrange
    when(mockGetSeriesEpisode.execute(id, seasons))
        .thenAnswer((_) async => Right(tSeries));
    // act
    await notifier.fetchSeriesEpisode(id, seasons);
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.series, tSeries);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetSeriesEpisode.execute(id, seasons))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchSeriesEpisode(id, seasons);
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
