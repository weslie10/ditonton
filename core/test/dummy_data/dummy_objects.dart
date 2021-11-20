//flutter test --coverage
//flutter pub run build_runner build --delete-conflicting-outputs

import 'package:core/data/models/movie_table.dart';

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: 'movie',
);

final testWatchlist = [testMovieTable];

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'type': 'movie',
};
