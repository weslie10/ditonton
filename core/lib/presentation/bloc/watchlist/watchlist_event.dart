part of 'watchlist_bloc.dart';

@immutable
abstract class WatchListEvent extends Equatable {
  const WatchListEvent();

  @override
  List<Object> get props => [];
}

class GetWatchListData extends WatchListEvent {}

class RemoveWatchListData extends WatchListEvent {
  final MovieTable movie;

  RemoveWatchListData(this.movie);

  @override
  List<Object> get props => [movie];
}

class SaveWatchListData extends WatchListEvent {
  final MovieTable movie;

  SaveWatchListData(this.movie);

  @override
  List<Object> get props => [movie];
}
