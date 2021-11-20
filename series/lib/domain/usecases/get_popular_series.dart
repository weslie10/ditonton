import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetPopularSeries {
  final SeriesRepository repository;

  GetPopularSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getPopularSeries();
  }
}
