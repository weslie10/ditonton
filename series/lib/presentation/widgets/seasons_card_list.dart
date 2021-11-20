import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:series/domain/entities/seasons.dart';

class SeasonsCard extends StatelessWidget {
  final Seasons seasons;

  SeasonsCard(this.seasons);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Card(
            child: Container(
              margin: const EdgeInsets.only(
                left: 16 + 80 + 16,
                bottom: 8,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    seasons.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "${seasons.episodeCount} ${seasons.episodeCount > 1 ? 'Episodes' : 'Episode'}",
                    maxLines: 1,
                  ),
                  SizedBox(height: 16),
                  Text(
                    seasons.overview != ""
                        ? seasons.overview
                        : "No Overview for this seasons",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              bottom: 16,
            ),
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL${seasons.posterPath}',
                width: 80,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(Icons.error),
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
