import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/local/local_data_source.dart';
import 'package:core/domain/repositories/watchlist_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  WatchlistRepository,
  LocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
