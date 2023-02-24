import 'package:flutter/material.dart';
import 'package:foot_news/common/utils/color_parser.dart';
import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';

class GameDetailsStatsScreen extends StatelessWidget {
  final StatsEmbedded statsEmbedded;

  const GameDetailsStatsScreen({Key? key, required this.statsEmbedded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        for (StatsBeanEmbedded? stats in (statsEmbedded.stats ?? [])) ...[
          _statsHandler(stats, statsEmbedded.teamColors)
        ]
      ],
    );
  }

  Widget _statsHandler(StatsBeanEmbedded? statsEmbedded, TeamColorsBeanEmbedded? teamColors) {
    if (statsEmbedded?.stats != null && statsEmbedded!.stats!.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              statsEmbedded.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          )),
          for (var stats in statsEmbedded.stats!) ...[_statsHandler(stats, teamColors)]
        ],
      );
    } else if (statsEmbedded?.statsString != null &&
        statsEmbedded!.statsString!.length == 2 &&
        statsEmbedded.statsString!.every((element) => element != null)) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4, top: 4),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                child: DecoratedBox(
              decoration: BoxDecoration(
                  color: statsEmbedded.highlighted == "home"
                      ? (HexColor.fromHex(teamColors?.home ?? "#00000000").withAlpha(85))
                      : Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  statsEmbedded.statsString![0]!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12),
                ),
              ),
            )),
            Expanded(
                child: Text(
              statsEmbedded.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 14),
            )),
            Flexible(
                child: DecoratedBox(
              decoration: BoxDecoration(
                  color: statsEmbedded.highlighted == "away"
                      ? (HexColor.fromHex(teamColors?.away ?? "#00000000").withAlpha(85))
                      : Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  statsEmbedded.statsString![1]!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12),
                ),
              ),
            ))
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
