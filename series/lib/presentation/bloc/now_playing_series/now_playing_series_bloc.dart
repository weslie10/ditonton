import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';

part 'now_playing_series_event.dart';
part 'now_playing_series_state.dart';

class NowPlayingSeriesBloc
    extends Bloc<NowPlayingSeriesEvent, NowPlayingSeriesState> {
  final GetNowPlayingSeries _nowPlayingSeries;

  NowPlayingSeriesBloc(this._nowPlayingSeries) : super(NowPlayingSeriesEmpty());

  @override
  Stream<NowPlayingSeriesState> mapEventToState(
      NowPlayingSeriesEvent event) async* {
    if (event is GetNowPlayingSeriesData) {
      yield NowPlayingSeriesLoading();
      final result = await _nowPlayingSeries.execute();

      yield* result.fold(
        (failure) async* {
          yield NowPlayingSeriesError(failure.message);
        },
        (data) async* {
          yield NowPlayingSeriesHasData(data);
        },
      );
    }
  }
}
