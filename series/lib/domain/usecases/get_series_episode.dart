import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:series/domain/entities/episode_enitity.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetSeriesEpisode {
  final SeriesRepository repository;

  GetSeriesEpisode(this.repository);

  Future<Either<Failure, EpisodeEntity>> execute(int id, int season) {
    return repository.getSeriesEpisode(id, season);
  }
}
