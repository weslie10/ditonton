import 'package:about/about_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/pages/search_series_page.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/bloc/now_playing_series/now_playing_series_bloc.dart';
import 'package:series/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:series/presentation/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:series/presentation/pages/popular_series_page.dart';
import 'package:series/presentation/pages/series_detail_page.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';

class HomeSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-series';
  @override
  _HomeSeriesPageState createState() => _HomeSeriesPageState();
}

class _HomeSeriesPageState extends State<HomeSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingSeriesBloc>().add(GetNowPlayingSeriesData());
      context.read<PopularSeriesBloc>().add(GetPopularSeriesData());
      context.read<TopRatedSeriesBloc>().add(GetTopRatedSeriesData());
    });
    // Future.microtask(
    //     () => Provider.of<SeriesListNotifier>(context, listen: false)
    //       ..fetchNowPlayingSeries()
    //       ..fetchPopularSeries()
    //       ..fetchTopRatedSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('core@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton (Tv Show)'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchSeriesPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingSeriesBloc, NowPlayingSeriesState>(
                  builder: (context, state) {
                if (state is NowPlayingSeriesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingSeriesHasData) {
                  return SeriesList(state.result);
                } else if (state is NowPlayingSeriesError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Center(
                    child: Text("No Data"),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
                  builder: (context, state) {
                if (state is PopularSeriesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularSeriesHasData) {
                  return SeriesList(state.result);
                } else if (state is PopularSeriesError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Center(
                    child: Text("No Data"),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
                builder: (context, state) {
                  if (state is TopRatedSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedSeriesHasData) {
                    return SeriesList(state.result);
                  } else if (state is TopRatedSeriesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Center(
                      child: Text("No Data"),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class SeriesList extends StatelessWidget {
  final List<Series> listSeries;

  SeriesList(this.listSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = listSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SeriesDetailPage.ROUTE_NAME,
                  arguments: series.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: listSeries.length,
      ),
    );
  }
}
