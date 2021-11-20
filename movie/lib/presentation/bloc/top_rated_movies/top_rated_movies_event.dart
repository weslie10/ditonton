part of 'top_rated_movies_bloc.dart';

@immutable
abstract class TopRatedMoviesEvent extends Equatable {
  const TopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetTopRatedMoviesData extends TopRatedMoviesEvent {}
