import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';

part 'popular_series_event.dart';
part 'popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final GetPopularSeries _popularSeries;

  PopularSeriesBloc(this._popularSeries) : super(PopularSeriesEmpty());

  @override
  Stream<PopularSeriesState> mapEventToState(PopularSeriesEvent event) async* {
    if (event is GetPopularSeriesData) {
      yield PopularSeriesLoading();
      final result = await _popularSeries.execute();

      yield* result.fold(
        (failure) async* {
          yield PopularSeriesError(failure.message);
        },
        (data) async* {
          yield PopularSeriesHasData(data);
        },
      );
    }
  }
}
