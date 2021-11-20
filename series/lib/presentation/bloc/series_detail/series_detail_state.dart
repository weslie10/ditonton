part of 'series_detail_bloc.dart';

@immutable
abstract class SeriesDetailState extends Equatable {
  const SeriesDetailState();

  @override
  List<Object> get props => [];
}

class SeriesDetailEmpty extends SeriesDetailState {}

class SeriesDetailLoading extends SeriesDetailState {}

class SeriesDetailError extends SeriesDetailState {
  final String message;

  SeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class SeriesDetailHasData extends SeriesDetailState {
  final SeriesDetail result;
  final bool status;

  SeriesDetailHasData(this.result, this.status);

  @override
  List<Object> get props => [result, status];
}
