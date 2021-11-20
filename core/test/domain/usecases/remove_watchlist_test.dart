import 'package:core/domain/usecases/remove_watchlist_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = RemoveWatchlist(mockWatchlistRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockWatchlistRepository.removeWatchlist(testMovieTable))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testMovieTable);
    // assert
    verify(mockWatchlistRepository.removeWatchlist(testMovieTable));
    expect(result, Right('Removed from watchlist'));
  });
}
