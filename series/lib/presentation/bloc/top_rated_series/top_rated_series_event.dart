part of 'top_rated_series_bloc.dart';

@immutable
abstract class TopRatedSeriesEvent extends Equatable {
  const TopRatedSeriesEvent();

  @override
  List<Object> get props => [];
}

class GetTopRatedSeriesData extends TopRatedSeriesEvent {}
