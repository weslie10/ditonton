import 'package:core/domain/usecases/save_watchlist_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = SaveWatchlist(mockWatchlistRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockWatchlistRepository.saveWatchlist(testMovieTable))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testMovieTable);
    // assert
    verify(mockWatchlistRepository.saveWatchlist(testMovieTable));
    expect(result, Right('Added to Watchlist'));
  });
}
