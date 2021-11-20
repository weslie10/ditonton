import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';

class SeriesTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? type;

  SeriesTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.type,
  });

  factory SeriesTable.fromEntity(SeriesDetail series) => SeriesTable(
        id: series.id,
        title: series.name,
        posterPath: series.posterPath,
        overview: series.overview,
        type: "series",
      );

  factory SeriesTable.fromMap(Map<String, dynamic> map) => SeriesTable(
        id: map['id'],
        title: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        type: map['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'type': type,
      };

  Series toEntity() => Series.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: title,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
