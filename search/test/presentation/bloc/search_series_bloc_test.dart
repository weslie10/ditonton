import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:search/domain/usecases/search_series.dart';
import 'package:search/presentation/bloc/search_series_bloc.dart';

import 'search_series_bloc_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late SearchSeriesBloc searchBloc;
  late MockSearchSeries mockSearchSeries;

  final tSeriesModel = Series(
    backdropPath: "/9OYu6oDLIidSOocW3JTGtd2Oyqy.jpg",
    firstAirDate: "2017-09-25",
    genreIds: [18],
    id: 71712,
    name: "The Good Doctor",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The Good Doctor",
    overview:
        "Shaun Murphy, a young surgeon with autism and savant syndrome, relocates from a quiet country life to join a prestigious hospital's surgical unit. Unable to personally connect with those around him, Shaun uses his extraordinary medical gifts to save lives and challenge the skepticism of his colleagues.",
    popularity: 890.186,
    posterPath: "/cXUqtadGsIcZDWUTrfnbDjAy8eN.jpg",
    voteAverage: 8.6,
    voteCount: 9771,
  );
  final tSeriesList = <Series>[tSeriesModel];
  final tQuery = 'good doctor';

  setUp(() {
    mockSearchSeries = MockSearchSeries();
    searchBloc = SearchSeriesBloc(mockSearchSeries);
  });

  test('inital data should be empty', () {
    expect(searchBloc.state, SearchSeriesEmpty());
  });

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tSeriesList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchSeriesLoading(),
      SearchSeriesHasData(tSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute(tQuery));
    },
  );

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchSeriesLoading(),
      SearchSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute(tQuery));
    },
  );
}
