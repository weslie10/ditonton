import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/presentation/bloc/popular_series/popular_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_series_test.mocks.dart';

@GenerateMocks([GetPopularSeries])
void main() {
  late PopularSeriesBloc detailSeriesBloc;
  late MockGetPopularSeries mockGetPopularSeries;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    detailSeriesBloc = PopularSeriesBloc(mockGetPopularSeries);
  });

  test('initial state should be empty', () {
    expect(detailSeriesBloc.state, PopularSeriesEmpty());
  });

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(testListSeries));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(GetPopularSeriesData()),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesHasData(testListSeries),
    ],
    verify: (bloc) {
      verify(mockGetPopularSeries.execute());
    },
  );

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'Should emit [Loading, Error] when get detail movies is unsuccessful',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(GetPopularSeriesData()),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularSeries.execute());
    },
  );
}
