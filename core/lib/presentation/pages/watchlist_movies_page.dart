import 'package:core/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<WatchListBloc>().add(GetWatchListData()),
    );
    // Provider.of<WatchlistMovieNotifier>(context, listen: false)
    //     .fetchWatchlistMovies());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchListBloc>().add(GetWatchListData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchListBloc, WatchListState>(
          builder: (context, state) {
            if (state is WatchListLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchListHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final watch = state.result[index];
                  return watch.type == "movie"
                      ? MovieCard(
                          Movie.watchlist(
                            id: watch.id,
                            title: watch.title,
                            posterPath: watch.posterPath,
                            overview: watch.overview,
                          ),
                          "watchlist",
                        )
                      : SeriesCard(
                          Series.watchlist(
                            id: watch.id,
                            name: watch.title,
                            posterPath: watch.posterPath,
                            overview: watch.overview,
                          ),
                          "watchlist",
                        );
                },
                itemCount: state.result.length,
              );
            } else if (state is WatchListError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text("No Data"),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
