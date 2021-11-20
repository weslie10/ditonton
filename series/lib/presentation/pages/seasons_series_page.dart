import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/presentation/pages/episode_series_page.dart';
import 'package:series/presentation/widgets/seasons_card_list.dart';

class SeasonsSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/seasons-series';

  SeriesDetail series;

  SeasonsSeriesPage({required this.series});

  @override
  _SeasonsSeriesPageState createState() => _SeasonsSeriesPageState();
}

class _SeasonsSeriesPageState extends State<SeasonsSeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seasons of ${widget.series.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            final series = widget.series.seasons[index];
            return InkWell(
              child: SeasonsCard(series),
              onTap: () => Navigator.pushNamed(
                context,
                SeriesEpisodePage.ROUTE_NAME,
                arguments: [
                  widget.series.id,
                  series.seasonNumber,
                ],
              ),
            );
          },
          itemCount: widget.series.seasons.length,
        ),
      ),
    );
  }
}
