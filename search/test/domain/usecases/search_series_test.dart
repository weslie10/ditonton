import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_series.dart';
import 'package:series/domain/entities/series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchSeries usecase;
  late MockSeriesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockSeriesRepository();
    usecase = SearchSeries(mockMovieRepository);
  });

  final tSeries = <Series>[];
  final tQuery = 'Good Doctor';

  test('should get list of series from the repository', () async {
    // arrange
    when(mockMovieRepository.searchSeries(tQuery))
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tSeries));
  });
}
