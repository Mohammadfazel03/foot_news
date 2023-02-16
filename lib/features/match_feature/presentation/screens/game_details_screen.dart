import 'package:flutter/material.dart';
import 'package:foot_news/features/match_feature/data/repository/match_details_repository.dart';
import 'package:foot_news/features/matches_feature/data/entity/match_entity.dart';

class GameDetailsScreen extends StatefulWidget {
  final MatchEntity matchEntity;

  const GameDetailsScreen({Key? key, required this.matchEntity}) : super(key: key);

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double collapseHeight;

  MySliverAppBar({required this.expandedHeight, required this.collapseHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.cyan),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 24,
                height:
                collapseHeight >= shrinkOffset ? 200 * (1 - shrinkOffset / collapseHeight) : 0,
                child: Opacity(
                  opacity: collapseHeight >= shrinkOffset ? (1 - shrinkOffset / collapseHeight) : 0,
                  child: Icon(
                    Icons.star,
                  ),
                ),
                decoration: BoxDecoration(),
                clipBehavior: Clip.hardEdge),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: collapseHeight >= shrinkOffset
                      ? 12 + 52 * (1 - shrinkOffset / collapseHeight)
                      : 12,
                ),
                Image.asset(
                  "assets/images/a.jpg",
                  height: collapseHeight >= shrinkOffset
                      ? 32 + 24 * (1 - shrinkOffset / collapseHeight)
                      : 32,
                  width: collapseHeight >= shrinkOffset
                      ? 32 + 24 * (1 - shrinkOffset / collapseHeight)
                      : 32,
                ),
                Expanded(
                  child: Opacity(
                    opacity: collapseHeight >= shrinkOffset ? (1 - shrinkOffset / collapseHeight) : 0,
                    child: Column(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              clipBehavior: Clip.hardEdge,
                              direction: Axis.horizontal,
                              spacing: 2,
                              children: [
                                Icon(
                                  Icons.circle_rounded,
                                  color: Colors.green,
                                  size: 8,
                                ),
                                Icon(
                                  Icons.circle_rounded,
                                  color: Colors.green,
                                  size: 8,
                                ),
                                Icon(
                                  Icons.circle_rounded,
                                  color: Colors.green,
                                  size: 8,
                                ),
                                Icon(
                                  Icons.circle_rounded,
                                  color: Colors.green,
                                  size: 8,
                                ),
                                Icon(
                                  Icons.circle_rounded,
                                  color: Colors.green,
                                  size: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(color: Colors.blueGrey),
                            clipBehavior: Clip.hardEdge,
                            child: Text(
                              'ss',
                              maxLines: 2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapseHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
