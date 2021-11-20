import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/episode_enitity.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/seasons.dart';
import 'package:ditonton/domain/entities/series_detail.dart';

//flutter test --coverage
//flutter pub run build_runner build --delete-conflicting-outputs

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testSeriesDetail = SeriesDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  originalLanguage: 'en',
  originCountry: ['us'],
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'releaseDate',
  name: 'title',
  voteAverage: 1,
  voteCount: 1,
  seasons: [
    Seasons(
      id: 1,
      name: "name",
      airDate: "2000-01-01",
      episodeCount: 1,
      overview: "overview",
      posterPath: "posterPath",
      seasonNumber: 1,
    )
  ],
  episodeRunTime: [10],
);

final testSeriesEpisode = EpisodeEntity(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'title',
  airDate: "2020-01-01",
  episodes: [
    Episode(
      airDate: "2020-01-01",
      seasonNumber: 1,
      stillPath: "stillPath",
      overview: "overview",
      name: "name",
      id: 1,
      voteAverage: 1,
      voteCount: 1,
      episodeNumber: 1,
    )
  ],
  seasonNumber: 1,
);

final testSeasons = [
  Seasons(
    id: 1,
    name: "name",
    airDate: "2000-01-01",
    episodeCount: 1,
    overview: "bla bla",
    posterPath: "posterPath",
    seasonNumber: 1,
  )
];

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = [testMovieTable];

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: 'movie',
);

final testSeriesTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: 'series',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'type': 'movie',
};

final testSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'type': 'series',
};
