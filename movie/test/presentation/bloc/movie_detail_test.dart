import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_watchlist_status_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetWatchListStatus])
void main() {
  late MovieDetailBloc detailMoviesBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchListStatus = MockGetWatchListStatus();
    detailMoviesBloc =
        MovieDetailBloc(mockGetMovieDetail, mockGetWatchListStatus);
  });

  test('initial state should be empty', () {
    expect(detailMoviesBloc.state, MovieDetailEmpty());
  });

  const tId = 1;

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetWatchListStatus.execute(tId, "movie"))
          .thenAnswer((_) async => false);
      return detailMoviesBloc;
    },
    act: (bloc) => bloc.add(MovieDetailIdEvent(tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailHasData(testMovieDetail, false),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when get detail movies is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetWatchListStatus.execute(tId, "movie"))
          .thenAnswer((_) async => true);
      return detailMoviesBloc;
    },
    act: (bloc) => bloc.add(MovieDetailIdEvent(tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );
}
