import 'package:core/domain/repositories/watchlist_repository.dart';

class GetWatchListStatus {
  final WatchlistRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id, String type) async {
    return repository.isAddedToWatchlist(id, type);
  }
}
