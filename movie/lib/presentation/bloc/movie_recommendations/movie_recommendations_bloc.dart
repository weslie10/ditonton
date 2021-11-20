import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations _movieRecommendations;

  MovieRecommendationsBloc(this._movieRecommendations)
      : super(MovieRecommendationsEmpty());

  @override
  Stream<MovieRecommendationsState> mapEventToState(
      MovieRecommendationsEvent event) async* {
    if (event is MovieRecommendationsIdEvent) {
      final id = event.id;
      yield MovieRecommendationsLoading();
      final result = await _movieRecommendations.execute(id);

      yield* result.fold(
        (failure) async* {
          yield MovieRecommendationsError(failure.message);
        },
        (data) async* {
          yield MovieRecommendationsHasData(data);
        },
      );
    }
  }
}
