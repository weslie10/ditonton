part of 'series_episode_bloc.dart';

@immutable
abstract class SeriesEpisodeEvent extends Equatable {
  const SeriesEpisodeEvent();

  @override
  List<Object> get props => [];
}

class SeriesEpisodeIdEvent extends SeriesEpisodeEvent {
  final int id;
  final int seasons;

  SeriesEpisodeIdEvent(this.id, this.seasons);

  @override
  List<Object> get props => [id, seasons];
}
