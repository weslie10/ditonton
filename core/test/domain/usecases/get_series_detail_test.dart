import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/series/get_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesDetail usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetSeriesDetail(mockMovieRepository);
  });

  final tId = 1;

  test('should get series detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getSeriesDetail(tId))
        .thenAnswer((_) async => Right(testSeriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testSeriesDetail));
  });
}
