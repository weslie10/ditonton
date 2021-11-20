import 'package:dartz/dartz.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/domain/repositories/watchlist_repository.dart';
import 'package:core/utils/failure.dart';

class GetWatchlist {
  final WatchlistRepository _repository;

  GetWatchlist(this._repository);

  Future<Either<Failure, List<MovieTable>>> execute() {
    return _repository.getWatchlist();
  }
}
