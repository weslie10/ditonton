import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search/domain/usecases/search_series.dart';
import 'package:rxdart/rxdart.dart';
import 'package:series/domain/entities/series.dart';

part 'search_series_event.dart';
part 'search_series_state.dart';

class SearchSeriesBloc extends Bloc<SearchSeriesEvent, SearchSeriesState> {
  final SearchSeries _searchSeries;

  SearchSeriesBloc(this._searchSeries) : super(SearchSeriesEmpty());

  @override
  Stream<SearchSeriesState> mapEventToState(SearchSeriesEvent event) async* {
    if (event is OnQueryChanged) {
      final query = event.query;

      yield SearchSeriesLoading();
      final result = await _searchSeries.execute(query);

      yield* result.fold(
        (failure) async* {
          yield SearchSeriesError(failure.message);
        },
        (data) async* {
          if (data.length > 0) {
            yield SearchSeriesHasData(data);
          } else {
            yield SearchSeriesEmpty();
          }
        },
      );
    }
  }

  @override
  Stream<Transition<SearchSeriesEvent, SearchSeriesState>> transformEvents(
    Stream<SearchSeriesEvent> events,
    TransitionFunction<SearchSeriesEvent, SearchSeriesState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }
}
