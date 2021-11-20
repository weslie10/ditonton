part of 'series_recommendations_bloc.dart';

@immutable
abstract class SeriesRecommendationsEvent extends Equatable {
  const SeriesRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class SeriesRecommendationsIdEvent extends SeriesRecommendationsEvent {
  final int id;

  SeriesRecommendationsIdEvent(this.id);

  @override
  List<Object> get props => [id];
}
