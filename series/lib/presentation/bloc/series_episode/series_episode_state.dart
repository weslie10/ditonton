part of 'series_episode_bloc.dart';

@immutable
abstract class SeriesEpisodeState extends Equatable {
  const SeriesEpisodeState();

  @override
  List<Object> get props => [];
}

class SeriesEpisodeEmpty extends SeriesEpisodeState {}

class SeriesEpisodeLoading extends SeriesEpisodeState {}

class SeriesEpisodeError extends SeriesEpisodeState {
  final String message;

  SeriesEpisodeError(this.message);

  @override
  List<Object> get props => [message];
}

class SeriesEpisodeHasData extends SeriesEpisodeState {
  final EpisodeEntity result;

  SeriesEpisodeHasData(this.result);

  @override
  List<Object> get props => [result];
}
