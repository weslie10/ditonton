import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';
import 'package:series/presentation/bloc/now_playing_series/now_playing_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_series_test.mocks.dart';

@GenerateMocks([GetNowPlayingSeries])
void main() {
  late NowPlayingSeriesBloc detailSeriesBloc;
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;

  setUp(() {
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    detailSeriesBloc = NowPlayingSeriesBloc(mockGetNowPlayingSeries);
  });

  test('initial state should be empty', () {
    expect(detailSeriesBloc.state, NowPlayingSeriesEmpty());
  });

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(testListSeries));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingSeriesData()),
    expect: () => [
      NowPlayingSeriesLoading(),
      NowPlayingSeriesHasData(testListSeries),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingSeries.execute());
    },
  );

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
    'Should emit [Loading, Error] when get detail movies is unsuccessful',
    build: () {
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingSeriesData()),
    expect: () => [
      NowPlayingSeriesLoading(),
      NowPlayingSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingSeries.execute());
    },
  );
}
