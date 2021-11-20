import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_series_episode.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesEpisode usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetSeriesEpisode(mockSeriesRepository);
  });

  final tId = 1;
  final seasons = 1;

  test('should get series episode from the repository', () async {
    // arrange
    when(mockSeriesRepository.getSeriesEpisode(tId, seasons))
        .thenAnswer((_) async => Right(testSeriesEpisode));
    // act
    final result = await usecase.execute(tId, seasons);
    // assert
    expect(result, Right(testSeriesEpisode));
  });
}
