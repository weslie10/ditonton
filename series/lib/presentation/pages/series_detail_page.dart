import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/presentation/bloc/series_detail/series_detail_bloc.dart';
import 'package:series/presentation/bloc/series_recommendations/series_recommendations_bloc.dart';
import 'package:series/presentation/pages/episode_series_page.dart';
import 'package:series/presentation/pages/seasons_series_page.dart';

class SeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-series';

  final int id;
  final String type = "series";
  SeriesDetailPage({required this.id});

  @override
  _SeriesDetailPageState createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeriesDetailBloc>().add(SeriesDetailIdEvent(widget.id));
      context
          .read<SeriesRecommendationsBloc>()
          .add(SeriesRecommendationsIdEvent(widget.id));
      // Provider.of<SeriesDetailNotifier>(context, listen: false)
      //     .fetchSeriesDetail(widget.id);
      // Provider.of<SeriesDetailNotifier>(context, listen: false)
      //     .loadWatchlistStatus(widget.id, widget.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SeriesDetailBloc, SeriesDetailState>(
        builder: (context, state) {
          if (state is SeriesDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeriesDetailHasData) {
            return SafeArea(
              child: DetailContent(
                state.result,
                state.status,
              ),
            );
          } else if (state is SeriesDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: Text('No Data'),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final SeriesDetail series;
  final bool isAddedWatchlist;

  DetailContent(this.series, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${series.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              series.name,
                              style: kHeading5,
                            ),
                            WatchListSeriesButton(series, isAddedWatchlist),
                            Text(
                              _showGenres(series.genres),
                            ),
                            Text(
                              _showDuration(series.episodeRunTime.length > 0
                                  ? series.episodeRunTime[0]
                                  : 0),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: series.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${series.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              series.overview,
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Seasons',
                                  style: kHeading6,
                                ),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    SeasonsSeriesPage.ROUTE_NAME,
                                    arguments: series,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text('See More'),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final seasons = series.seasons[index];
                                  return InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${seasons.posterPath}',
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      print("id: ${series.id}");
                                      print("season: ${seasons.seasonNumber}");
                                      Navigator.pushNamed(
                                        context,
                                        SeriesEpisodePage.ROUTE_NAME,
                                        arguments: [
                                          series.id,
                                          seasons.seasonNumber
                                        ],
                                      );
                                    },
                                  );
                                },
                                itemCount: series.seasons.length,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<SeriesRecommendationsBloc,
                                SeriesRecommendationsState>(
                              builder: (context, state) {
                                if (state is SeriesRecommendationsLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is SeriesRecommendationsError) {
                                  return Text(state.message);
                                } else if (state
                                    is SeriesRecommendationsHasData) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final series = state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                SeriesDetailPage.ROUTE_NAME,
                                                arguments: series.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${series.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.result.length,
                                    ),
                                  );
                                } else {
                                  return Center(child: Text('No Data'));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

class WatchListSeriesButton extends StatefulWidget {
  final SeriesDetail series;
  final bool isAddedWatchlist;

  WatchListSeriesButton(this.series, this.isAddedWatchlist);

  @override
  _WatchListSeriesButtonState createState() => _WatchListSeriesButtonState();
}

class _WatchListSeriesButtonState extends State<WatchListSeriesButton> {
  bool status = false;
  @override
  void initState() {
    super.initState();
    status = widget.isAddedWatchlist;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (!status) {
          context.read<WatchListBloc>().add(
                SaveWatchListData(
                  MovieTable(
                    id: widget.series.id,
                    title: widget.series.name,
                    overview: widget.series.overview,
                    posterPath: widget.series.posterPath,
                    type: "series",
                  ),
                ),
              );
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Added to Watchlist")));
          setState(() {
            status = !status;
          });
        } else {
          context.read<WatchListBloc>().add(
                RemoveWatchListData(
                  MovieTable(
                    id: widget.series.id,
                    title: widget.series.name,
                    overview: widget.series.overview,
                    posterPath: widget.series.posterPath,
                    type: "series",
                  ),
                ),
              );
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Removed from Watchlist")));
          setState(() {
            status = !status;
          });
        }
        print(status);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          status ? Icon(Icons.check) : Icon(Icons.add),
          Text('Watchlist'),
        ],
      ),
    );
  }
}
