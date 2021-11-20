import 'package:core/data/models/movie_table.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, List<MovieTable>>> getWatchlist();
  Future<Either<Failure, String>> saveWatchlist(MovieTable movie);
  Future<Either<Failure, String>> removeWatchlist(MovieTable movie);
  Future<bool> isAddedToWatchlist(int id, String type);
}
