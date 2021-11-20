import 'package:core/core.dart';
import 'package:core/data/datasources/local/local_data_source.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/domain/repositories/watchlist_repository.dart';
import 'package:dartz/dartz.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final LocalDataSource localDataSource;

  WatchlistRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<bool> isAddedToWatchlist(int id, String type) async {
    final result = await localDataSource.getMovieById(id, type);
    print(result);
    return result != null;
  }

  @override
  Future<Either<Failure, List<MovieTable>>> getWatchlist() async {
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.toList());
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(MovieTable movie) async {
    try {
      final result = await localDataSource.removeWatchlistMovie(movie);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(MovieTable movie) async {
    try {
      final result = await localDataSource.insertWatchlistMovie(movie);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }
}
