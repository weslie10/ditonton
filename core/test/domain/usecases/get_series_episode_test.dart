import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/series/get_series_episode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesEpisode usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetSeriesEpisode(mockMovieRepository);
  });

  final tId = 1;
  final seasons = 1;

  test('should get series episode from the repository', () async {
    // arrange
    when(mockMovieRepository.getSeriesEpisode(tId, seasons))
        .thenAnswer((_) async => Right(testSeriesEpisode));
    // act
    final result = await usecase.execute(tId, seasons);
    // assert
    expect(result, Right(testSeriesEpisode));
  });
}
