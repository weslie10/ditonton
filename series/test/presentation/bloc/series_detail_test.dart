import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_watchlist_status_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/presentation/bloc/series_detail/series_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'series_detail_test.mocks.dart';

@GenerateMocks([GetSeriesDetail, GetWatchListStatus])
void main() {
  late SeriesDetailBloc detailSeriesBloc;
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetWatchListStatus = MockGetWatchListStatus();
    detailSeriesBloc =
        SeriesDetailBloc(mockGetSeriesDetail, mockGetWatchListStatus);
  });

  test('initial state should be empty', () {
    expect(detailSeriesBloc.state, SeriesDetailEmpty());
  });

  const tId = 1;

  blocTest<SeriesDetailBloc, SeriesDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testSeriesDetail));
      when(mockGetWatchListStatus.execute(tId, "movie"))
          .thenAnswer((_) async => false);
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(SeriesDetailIdEvent(tId)),
    expect: () => [
      SeriesDetailLoading(),
      SeriesDetailHasData(testSeriesDetail, false),
    ],
    verify: (bloc) {
      verify(mockGetSeriesDetail.execute(tId));
    },
  );

  blocTest<SeriesDetailBloc, SeriesDetailState>(
    'Should emit [Loading, Error] when get detail movies is unsuccessful',
    build: () {
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetWatchListStatus.execute(tId, "movie"))
          .thenAnswer((_) async => true);
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(SeriesDetailIdEvent(tId)),
    expect: () => [
      SeriesDetailLoading(),
      SeriesDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetSeriesDetail.execute(tId));
    },
  );
}
