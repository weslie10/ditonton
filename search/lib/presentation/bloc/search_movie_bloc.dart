import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(SearchMovieEmpty());

  @override
  Stream<SearchMovieState> mapEventToState(SearchMovieEvent event) async* {
    if (event is OnQueryChanged) {
      final query = event.query;

      yield SearchMovieLoading();
      final result = await _searchMovies.execute(query);

      yield* result.fold(
        (failure) async* {
          yield SearchMovieError(failure.message);
        },
        (data) async* {
          if (data.length > 0) {
            yield SearchMovieHasData(data);
          }
          else {
            yield SearchMovieEmpty();
          }
        },
      );
    }
  }

  @override
  Stream<Transition<SearchMovieEvent, SearchMovieState>> transformEvents(
    Stream<SearchMovieEvent> events,
    TransitionFunction<SearchMovieEvent, SearchMovieState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }
}
