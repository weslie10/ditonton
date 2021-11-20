part of 'series_detail_bloc.dart';

@immutable
abstract class SeriesDetailEvent extends Equatable {
  const SeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class SeriesDetailIdEvent extends SeriesDetailEvent {
  final int id;

  SeriesDetailIdEvent(this.id);

  @override
  List<Object> get props => [id];
}
