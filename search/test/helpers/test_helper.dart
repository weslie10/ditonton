import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/local/local_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:series/domain/repositories/series_repository.dart';

@GenerateMocks([
  MovieRepository,
  SeriesRepository,
  LocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
