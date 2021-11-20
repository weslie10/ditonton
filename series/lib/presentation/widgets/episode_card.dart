import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:series/domain/entities/episode.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  EpisodeCard(this.episode);

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
                    episode.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6,
                  ),
                  SizedBox(height: 16),
                  Text(
                    episode.overview != ""
                        ? episode.overview
                        : "No Overview for this episode",
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
                imageUrl: '$BASE_IMAGE_URL${episode.stillPath}',
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
