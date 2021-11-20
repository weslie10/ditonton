part of 'now_playing_series_bloc.dart';

@immutable
abstract class NowPlayingSeriesEvent extends Equatable {
  const NowPlayingSeriesEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingSeriesData extends NowPlayingSeriesEvent {}
