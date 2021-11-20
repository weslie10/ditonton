part of 'watchlist_bloc.dart';

@immutable
abstract class WatchListState extends Equatable {
  const WatchListState();

  @override
  List<Object> get props => [];
}

class WatchListEmpty extends WatchListState {}

class WatchListLoading extends WatchListState {}

class WatchListError extends WatchListState {
  final String message;

  WatchListError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchListHasData extends WatchListState {
  final List<MovieTable> result;

  WatchListHasData(this.result);

  @override
  List<Object> get props => [result];
}