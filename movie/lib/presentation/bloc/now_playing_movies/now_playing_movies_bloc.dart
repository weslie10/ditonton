import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _nowPlayingMovies;

  NowPlayingMoviesBloc(this._nowPlayingMovies) : super(NowPlayingMoviesEmpty());

  @override
  Stream<NowPlayingMoviesState> mapEventToState(
      NowPlayingMoviesEvent event) async* {
    if (event is GetNowPlayingMoviesData) {
      yield NowPlayingMoviesLoading();
      final result = await _nowPlayingMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield NowPlayingMoviesError(failure.message);
        },
        (data) async* {
          yield NowPlayingMoviesHasData(data);
        },
      );
    }
  }
}
