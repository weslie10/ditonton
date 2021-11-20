//flutter test --coverage
//flutter pub run build_runner build --delete-conflicting-outputs

import 'package:core/data/models/movie_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:series/domain/entities/episode.dart';
import 'package:series/domain/entities/episode_enitity.dart';
import 'package:series/domain/entities/seasons.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';

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

final testSeries = Series(
  backdropPath: "/9OYu6oDLIidSOocW3JTGtd2Oyqy.jpg",
  genreIds: [18],
  id: 90462,
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "The Good Doctor",
  overview:
      "Shaun Murphy, a young surgeon with autism and savant syndrome, relocates from a quiet country life to join a prestigious hospital's surgical unit. Unable to personally connect with those around him, Shaun uses his extraordinary medical gifts to save lives and challenge the skepticism of his colleagues.",
  popularity: 966.331,
  posterPath: "/cXUqtadGsIcZDWUTrfnbDjAy8eN.jpg",
  firstAirDate: "2017-09-25",
  name: "The Good Doctor",
  voteAverage: 8.6,
  voteCount: 9693,
);

final testListSeries = [testSeries];

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

final testSeriesTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: 'series',
);

final testSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'type': 'series',
};
