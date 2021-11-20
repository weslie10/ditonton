import 'package:core/domain/usecases/get_watchlist_status_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatus usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetWatchListStatus(mockWatchlistRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockWatchlistRepository.isAddedToWatchlist(1, "movie"))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1, "movie");
    // assert
    expect(result, true);
  });
}
