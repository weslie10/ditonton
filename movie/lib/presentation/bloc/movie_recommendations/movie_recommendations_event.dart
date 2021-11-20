part of 'movie_recommendations_bloc.dart';

@immutable
abstract class MovieRecommendationsEvent extends Equatable {
  const MovieRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class MovieRecommendationsIdEvent extends MovieRecommendationsEvent {
  final int id;

  MovieRecommendationsIdEvent(this.id);

  @override
  List<Object> get props => [id];
}
