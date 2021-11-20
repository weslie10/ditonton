import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_series_episode.dart';
import 'package:series/presentation/bloc/series_episode/series_episode_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'series_episode_test.mocks.dart';

@GenerateMocks([GetSeriesEpisode])
void main() {
  late SeriesEpisodeBloc detailSeriesBloc;
  late MockGetSeriesEpisode mockGetSeriesEpisode;

  setUp(() {
    mockGetSeriesEpisode = MockGetSeriesEpisode();
    detailSeriesBloc = SeriesEpisodeBloc(mockGetSeriesEpisode);
  });

  test('initial state should be empty', () {
    expect(detailSeriesBloc.state, SeriesEpisodeEmpty());
  });

  blocTest<SeriesEpisodeBloc, SeriesEpisodeState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetSeriesEpisode.execute(1, 1))
          .thenAnswer((_) async => Right(testSeriesEpisode));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(SeriesEpisodeIdEvent(1, 1)),
    expect: () => [
      SeriesEpisodeLoading(),
      SeriesEpisodeHasData(testSeriesEpisode),
    ],
    verify: (bloc) {
      verify(mockGetSeriesEpisode.execute(1, 1));
    },
  );

  blocTest<SeriesEpisodeBloc, SeriesEpisodeState>(
    'Should emit [Loading, Error] when get detail movies is unsuccessful',
    build: () {
      when(mockGetSeriesEpisode.execute(1, 1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(SeriesEpisodeIdEvent(1, 1)),
    expect: () => [
      SeriesEpisodeLoading(),
      SeriesEpisodeError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetSeriesEpisode.execute(1, 1));
    },
  );
}
