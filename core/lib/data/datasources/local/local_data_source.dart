import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/utils/exception.dart';

abstract class LocalDataSource {
  Future<List<MovieTable>> getWatchlistMovies();
  Future<String> insertWatchlistMovie(MovieTable movie);
  Future<String> removeWatchlistMovie(MovieTable movie);
  Future<MovieTable?> getMovieById(int id, String type);
}

class LocalDataSourceImpl implements LocalDataSource {
  final DatabaseHelper databaseHelper;

  LocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistMovie(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlistMovie(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistMovie(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlistMovie(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id, String type) async {
    final result = await databaseHelper.getDataById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }
}
