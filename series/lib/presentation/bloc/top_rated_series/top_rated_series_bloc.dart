import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';

part 'top_rated_series_event.dart';
part 'top_rated_series_state.dart';

class TopRatedSeriesBloc
    extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  final GetTopRatedSeries _popularSeries;

  TopRatedSeriesBloc(this._popularSeries) : super(TopRatedSeriesEmpty());

  @override
  Stream<TopRatedSeriesState> mapEventToState(
      TopRatedSeriesEvent event) async* {
    if (event is GetTopRatedSeriesData) {
      yield TopRatedSeriesLoading();
      final result = await _popularSeries.execute();

      yield* result.fold(
        (failure) async* {
          yield TopRatedSeriesError(failure.message);
        },
        (data) async* {
          yield TopRatedSeriesHasData(data);
        },
      );
    }
  }
}
