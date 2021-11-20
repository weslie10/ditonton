import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';
import 'package:series/presentation/bloc/series_recommendations/series_recommendations_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'series_recommendations_test.mocks.dart';

@GenerateMocks([GetSeriesRecommendations])
void main() {
  late SeriesRecommendationsBloc detailSeriesBloc;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;

  setUp(() {
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    detailSeriesBloc = SeriesRecommendationsBloc(mockGetSeriesRecommendations);
  });

  test('initial state should be empty', () {
    expect(detailSeriesBloc.state, SeriesRecommendationsEmpty());
  });

  const tId = 1;

  blocTest<SeriesRecommendationsBloc, SeriesRecommendationsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testListSeries));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(SeriesRecommendationsIdEvent(tId)),
    expect: () => [
      SeriesRecommendationsLoading(),
      SeriesRecommendationsHasData(testListSeries),
    ],
    verify: (bloc) {
      verify(mockGetSeriesRecommendations.execute(tId));
    },
  );

  blocTest<SeriesRecommendationsBloc, SeriesRecommendationsState>(
    'Should emit [Loading, Error] when get detail movies is unsuccessful',
    build: () {
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(SeriesRecommendationsIdEvent(tId)),
    expect: () => [
      SeriesRecommendationsLoading(),
      SeriesRecommendationsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetSeriesRecommendations.execute(tId));
    },
  );
}
