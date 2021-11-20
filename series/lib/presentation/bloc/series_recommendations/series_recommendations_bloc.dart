import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';

part 'series_recommendations_event.dart';
part 'series_recommendations_state.dart';

class SeriesRecommendationsBloc
    extends Bloc<SeriesRecommendationsEvent, SeriesRecommendationsState> {
  final GetSeriesRecommendations _movieRecommendations;

  SeriesRecommendationsBloc(this._movieRecommendations)
      : super(SeriesRecommendationsEmpty());

  @override
  Stream<SeriesRecommendationsState> mapEventToState(
      SeriesRecommendationsEvent event) async* {
    if (event is SeriesRecommendationsIdEvent) {
      final id = event.id;
      yield SeriesRecommendationsLoading();
      final result = await _movieRecommendations.execute(id);

      yield* result.fold(
        (failure) async* {
          yield SeriesRecommendationsError(failure.message);
        },
        (data) async* {
          yield SeriesRecommendationsHasData(data);
        },
      );
    }
  }
}
