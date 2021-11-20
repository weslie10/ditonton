import 'package:ditonton/domain/usecases/watchlist/get_watchlist_status_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatus usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchListStatus(mockMovieRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlist(1,"movie"))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1,"movie");
    // assert
    expect(result, true);
  });
}
