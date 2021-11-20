part of 'series_recommendations_bloc.dart';

@immutable
abstract class SeriesRecommendationsState extends Equatable {
  const SeriesRecommendationsState();

  @override
  List<Object> get props => [];
}

class SeriesRecommendationsEmpty extends SeriesRecommendationsState {}

class SeriesRecommendationsLoading extends SeriesRecommendationsState {}

class SeriesRecommendationsError extends SeriesRecommendationsState {
  final String message;

  SeriesRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class SeriesRecommendationsHasData extends SeriesRecommendationsState {
  final List<Series> result;

  SeriesRecommendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}
