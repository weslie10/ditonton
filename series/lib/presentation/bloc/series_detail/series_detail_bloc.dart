import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/get_watchlist_status_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/domain/usecases/get_series_detail.dart';

part 'series_detail_event.dart';
part 'series_detail_state.dart';

class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  final GetSeriesDetail _seriesDetail;
  final GetWatchListStatus _watchListStatus;

  SeriesDetailBloc(this._seriesDetail, this._watchListStatus)
      : super(SeriesDetailEmpty());

  @override
  Stream<SeriesDetailState> mapEventToState(SeriesDetailEvent event) async* {
    if (event is SeriesDetailIdEvent) {
      final id = event.id;
      yield SeriesDetailLoading();
      final result = await _seriesDetail.execute(id);
      final status = await _watchListStatus.execute(id, "movie");

      yield* result.fold(
        (failure) async* {
          yield SeriesDetailError(failure.message);
        },
        (data) async* {
          yield SeriesDetailHasData(data, status);
        },
      );
    }
  }
}
