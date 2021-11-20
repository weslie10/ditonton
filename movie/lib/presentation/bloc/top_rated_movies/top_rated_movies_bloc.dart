import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies _popularMovies;

  TopRatedMoviesBloc(this._popularMovies) : super(TopRatedMoviesEmpty());

  @override
  Stream<TopRatedMoviesState> mapEventToState(
      TopRatedMoviesEvent event) async* {
    if (event is GetTopRatedMoviesData) {
      yield TopRatedMoviesLoading();
      final result = await _popularMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield TopRatedMoviesError(failure.message);
        },
        (data) async* {
          yield TopRatedMoviesHasData(data);
        },
      );
    }
  }
}
