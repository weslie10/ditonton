import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/bloc/series_episode/series_episode_bloc.dart';
import 'package:series/presentation/widgets/episode_card.dart';

class SeriesEpisodePage extends StatefulWidget {
  static const ROUTE_NAME = '/episode-series';
  final List<int> info;

  SeriesEpisodePage({required this.info});

  @override
  _SeriesEpisodePageState createState() => _SeriesEpisodePageState();
}

class _SeriesEpisodePageState extends State<SeriesEpisodePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<SeriesEpisodeBloc>()
          .add(SeriesEpisodeIdEvent(widget.info[0], widget.info[1]));
    });

    // Future.microtask(() =>
    //     Provider.of<SeriesEpisodeNotifier>(context, listen: false)
    //         .fetchSeriesEpisode(widget.info[0], widget.info[1]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episode'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SeriesEpisodeBloc, SeriesEpisodeState>(
          builder: (context, state) {
            if (state is SeriesEpisodeLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeriesEpisodeHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final episode = state.result.episodes[index];
                  return EpisodeCard(episode);
                },
                itemCount: state.result.episodes.length,
              );
            } else if (state is SeriesEpisodeError) {
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
}
