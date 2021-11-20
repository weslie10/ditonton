import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/remove_watchlist_movies.dart';
import 'package:core/domain/usecases/save_watchlist_movies.dart';
import 'package:core/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_test.mocks.dart';

@GenerateMocks([GetWatchlist, RemoveWatchlist, SaveWatchlist])
void main() {
  late WatchListBloc watchListBloc;
  late MockGetWatchlist mockGetWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;

  setUp(() {
    mockGetWatchlist = MockGetWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    watchListBloc =
        WatchListBloc(mockGetWatchlist, mockRemoveWatchlist, mockSaveWatchlist);
  });

  group("get watchlist", () {
    test('initial state should be empty', () {
      expect(watchListBloc.state, WatchListEmpty());
    });

    blocTest<WatchListBloc, WatchListState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlist.execute())
            .thenAnswer((_) async => Right(testWatchlist));
        return watchListBloc;
      },
      act: (bloc) => bloc.add(GetWatchListData()),
      expect: () => [
        WatchListLoading(),
        WatchListHasData(testWatchlist),
      ],
      verify: (bloc) {
        verify(mockGetWatchlist.execute());
      },
    );

    blocTest<WatchListBloc, WatchListState>(
      'Should emit [Loading, Error] when get detail movies is unsuccessful',
      build: () {
        when(mockGetWatchlist.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchListBloc;
      },
      act: (bloc) => bloc.add(GetWatchListData()),
      expect: () => [
        WatchListLoading(),
        WatchListError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlist.execute());
      },
    );
  });
}
