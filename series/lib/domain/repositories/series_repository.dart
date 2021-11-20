import 'package:core/core.dart';
import 'package:series/domain/entities/episode_enitity.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:dartz/dartz.dart';

abstract class SeriesRepository {
  Future<Either<Failure, List<Series>>> getNowPlayingSeries();
  Future<Either<Failure, List<Series>>> getPopularSeries();
  Future<Either<Failure, List<Series>>> getTopRatedSeries();
  Future<Either<Failure, SeriesDetail>> getSeriesDetail(int id);
  Future<Either<Failure, EpisodeEntity>> getSeriesEpisode(int id, int season);
  Future<Either<Failure, List<Series>>> getSeriesRecommendations(int id);
  Future<Either<Failure, List<Series>>> searchSeries(String query);
}
