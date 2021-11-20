import 'package:bloc/bloc.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/remove_watchlist_movies.dart';
import 'package:core/domain/usecases/save_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  final GetWatchlist _watchlist;
  final RemoveWatchlist _removeWatchlist;
  final SaveWatchlist _saveWatchlist;

  WatchListBloc(
    this._watchlist,
    this._removeWatchlist,
    this._saveWatchlist,
  ) : super(WatchListEmpty());

  @override
  Stream<WatchListState> mapEventToState(WatchListEvent event) async* {
    if (event is GetWatchListData) {
      yield WatchListLoading();
      final result = await _watchlist.execute();

      yield* result.fold(
        (failure) async* {
          yield WatchListError(failure.message);
        },
        (data) async* {
          if (data.length > 0) {
            yield WatchListHasData(data);
          } else {
            yield WatchListEmpty();
          }
        },
      );
    } else if (event is RemoveWatchListData) {
      final movie = event.movie;
      await _removeWatchlist.execute(movie);
    } else if (event is SaveWatchListData) {
      final movie = event.movie;
      await _saveWatchlist.execute(movie);
    }
  }
}
