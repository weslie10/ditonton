import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/presentation/bloc/top_rated_series/top_rated_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_series_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late TopRatedSeriesBloc detailSeriesBloc;
  late MockGetTopRatedSeries mockGetTopRatedSeries;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    detailSeriesBloc = TopRatedSeriesBloc(mockGetTopRatedSeries);
  });

  test('initial state should be empty', () {
    expect(detailSeriesBloc.state, TopRatedSeriesEmpty());
  });

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(testListSeries));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedSeriesData()),
    expect: () => [
      TopRatedSeriesLoading(),
      TopRatedSeriesHasData(testListSeries),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSeries.execute());
    },
  );

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'Should emit [Loading, Error] when get detail movies is unsuccessful',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedSeriesData()),
    expect: () => [
      TopRatedSeriesLoading(),
      TopRatedSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSeries.execute());
    },
  );
}
