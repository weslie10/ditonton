import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/domain/repositories/watchlist_repository.dart';

class SaveWatchlist {
  final WatchlistRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieTable movie) {
    return repository.saveWatchlist(movie);
  }
}
