import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _popularMovies;

  PopularMoviesBloc(this._popularMovies) : super(PopularMoviesEmpty());

  @override
  Stream<PopularMoviesState> mapEventToState(PopularMoviesEvent event) async* {
    if (event is GetPopularMoviesData) {
      yield PopularMoviesLoading();
      final result = await _popularMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield PopularMoviesError(failure.message);
        },
        (data) async* {
          yield PopularMoviesHasData(data);
        },
      );
    }
  }
}
