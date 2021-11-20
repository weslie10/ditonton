import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:series/domain/entities/episode_enitity.dart';
import 'package:series/domain/usecases/get_series_episode.dart';

part 'series_episode_event.dart';
part 'series_episode_state.dart';

class SeriesEpisodeBloc extends Bloc<SeriesEpisodeEvent, SeriesEpisodeState> {
  final GetSeriesEpisode _seriesEpisode;

  SeriesEpisodeBloc(this._seriesEpisode) : super(SeriesEpisodeEmpty());

  @override
  Stream<SeriesEpisodeState> mapEventToState(SeriesEpisodeEvent event) async* {
    if (event is SeriesEpisodeIdEvent) {
      final id = event.id;
      final seasons = event.seasons;
      yield SeriesEpisodeLoading();
      final result = await _seriesEpisode.execute(id, seasons);

      yield* result.fold(
        (failure) async* {
          yield SeriesEpisodeError(failure.message);
        },
        (data) async* {
          yield SeriesEpisodeHasData(data);
        },
      );
    }
  }
}
