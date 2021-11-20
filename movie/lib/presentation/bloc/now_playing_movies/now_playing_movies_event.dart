part of 'now_playing_movies_bloc.dart';

@immutable
abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingMoviesData extends NowPlayingMoviesEvent {}
