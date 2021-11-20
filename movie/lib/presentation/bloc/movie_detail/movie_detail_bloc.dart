import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/get_watchlist_status_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _movieDetail;
  final GetWatchListStatus _watchListStatus;

  MovieDetailBloc(this._movieDetail, this._watchListStatus)
      : super(MovieDetailEmpty());

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if (event is MovieDetailIdEvent) {
      final id = event.id;
      yield MovieDetailLoading();
      final result = await _movieDetail.execute(id);
      final status = await _watchListStatus.execute(id, "movie");

      yield* result.fold(
        (failure) async* {
          yield MovieDetailError(failure.message);
        },
        (data) async* {
          yield MovieDetailHasData(data, status);
        },
      );
    }
  }
}
