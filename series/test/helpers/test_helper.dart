import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:series/data/datasources/series_remote_data_source.dart';
import 'package:series/domain/repositories/series_repository.dart';

@GenerateMocks([
  SeriesRepository,
  SeriesRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
