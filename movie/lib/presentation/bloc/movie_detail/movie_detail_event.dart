part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class MovieDetailIdEvent extends MovieDetailEvent {
  final int id;

  MovieDetailIdEvent(this.id);

  @override
  List<Object> get props => [id];
}
