import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foot_news/common/utils/material_colors.dart';
import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';
import 'package:foot_news/features/match_feature/presentation/widget/lineup_placeholder/lineup_placeholder_painter.dart';

class GameDetailsLineupScreen extends StatelessWidget {
  final LineupEmbedded lineup;

  const GameDetailsLineupScreen({Key? key, required this.lineup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      children: [
        if (lineup.lineup?.length == 2 &&
            lineup.lineup?.every((element) => element != null) == true) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: _lineup(lineup.lineup![0]!, true),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: _lineup(lineup.lineup![1]!, false),
          ),
        ],
        if (lineup.bench?.arr?.length == 2 &&
            lineup.bench?.arr?.every((element) =>
                    element?.arr?.every((element) => element != null) == true &&
                    (element?.arr?.length ?? 0) > 0) ==
                true) ...[
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              height: 32,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
                child: const Align(
                  child: Text(
                    'Bench',
                    style:
                        TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _bench(lineup.bench!.arr![0]!.arr!, true)),
                Expanded(child: _bench(lineup.bench!.arr![1]!.arr!, false)),
              ],
            ),
          )
        ],
        if (lineup.naPlayers?.arr?.length == 2 &&
            lineup.naPlayers?.arr?.every((element) =>
                    element?.arr?.every((element) => element != null) == true &&
                    (element?.arr?.length ?? 0) > 0) ==
                true) ...[
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              height: 32,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
                child: const Align(
                  child: Text(
                    'Injured and suspended players',
                    style:
                        TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _injured(lineup.naPlayers!.arr![0]!.arr!, true)),
                Expanded(child: _injured(lineup.naPlayers!.arr![1]!.arr!, false)),
              ],
            ),
          )
        ],
        if (lineup.coaches?.arr?.length == 2 &&
            lineup.coaches?.arr?.every((element) =>
                    element?.arr?.every((element) => element != null) == true &&
                    (element?.arr?.length ?? 0) > 0) ==
                true) ...[
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              height: 32,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
                child: const Align(
                  child: Text(
                    'Coaches',
                    style:
                        TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _coach(lineup.coaches!.arr![0]!.arr!, true)),
                Expanded(child: _coach(lineup.coaches!.arr![1]!.arr!, false)),
              ],
            ),
          )
        ],
      ],
    );
  }

  Widget _lineup(LineupBeanEmbedded lineup, isHome) {
    return LayoutBuilder(
      builder: (_, c) => SizedBox(
        width: c.maxWidth,
        height: lineup.players!.length * 90,
        child: CustomPaint(
          painter: LineupPlaceholderPainter(!isHome),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var players in lineup.players!) ...[
                SizedBox(
                  height: 90,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (var player in players!.arr!) ...[
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 48,
                                width: 48,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                          color:
                                              isHome ? MaterialColors.amberDraw : MaterialColors.blue,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CachedNetworkImage(
                                          placeholder: (context, string) =>
                                              Image.asset('assets/images/placeholder_player.png'),
                                          errorWidget: (context, string, error) =>
                                              Image.asset('assets/images/placeholder_player.png'),
                                          imageUrl: player?.imageUrl ?? "",
                                          height: 40,
                                          width: 40,
                                        ),
                                      ),
                                    ),
                                    if (player?.events?.sub?.subbedOut != null) ...[
                                      const Positioned(
                                        right: -10,
                                        top: 16,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(color: Color.fromRGBO(23, 32, 57, 1.0), shape: BoxShape.circle,boxShadow: [
                                            BoxShadow()
                                          ]),
                                          child: Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: MaterialColors.redLose,
                                            size: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                    if (player?.events?.goal != null) ...[
                                      for(int i = 0; i < player!.events!.goal!; i++)...[
                                        Positioned(
                                          right: -2 - (i * 8),
                                          top: -4,
                                          child: DecoratedBox(
                                            decoration: const BoxDecoration(color: Color.fromRGBO(23, 32, 57, 1.0), shape: BoxShape.circle,boxShadow: [
                                              BoxShadow()
                                            ]),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Image.asset('assets/images/match-goal.png',
                                                  height: 12, width: 12, color: MaterialColors.greenWin),
                                            ),
                                          ),
                                        )
                                      ]
                                    ],
                                    if (player?.events?.assists != null) ...[
                                      for(int i = 0; i < player!.events!.assists!; i++)...[
                                        Positioned(
                                          left: -2 - (i * 8),
                                          top: -4,
                                          child: DecoratedBox(
                                            decoration: const BoxDecoration(color: Color.fromRGBO(23, 32, 57, 1.0), shape: BoxShape.circle,boxShadow: [
                                              BoxShadow()
                                            ]),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Image.asset('assets/images/match-assists.png',
                                                  height: 12, width: 12, color: MaterialColors.greenWin),
                                            ),
                                          ),
                                        )
                                      ]
                                    ],
                                    if (player?.events?.ownGoal != null) ...[
                                      for(int i = 0; i < player!.events!.ownGoal!; i++)...[
                                        Positioned(
                                          right: -2 - (i * 8),
                                          bottom: -4,
                                          child: DecoratedBox(
                                            decoration: const BoxDecoration(color: Color.fromRGBO(23, 32, 57, 1.0), shape: BoxShape.circle,boxShadow: [
                                              BoxShadow()
                                            ]),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Image.asset('assets/images/match-goal.png',
                                                  height: 12, width: 12, color: MaterialColors.redLose),
                                            ),
                                          ),
                                        )
                                      ]
                                    ],
                                    if (player?.events?.yellowCard != null) ...[
                                        Positioned(
                                          left: -10,
                                          top: 16,
                                          child: DecoratedBox(
                                            decoration: const BoxDecoration(color: Color.fromRGBO(23, 32, 57, 1.0), shape: BoxShape.circle,boxShadow: [
                                              BoxShadow()
                                            ]),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Image.asset('assets/images/match-yellow-card.png',
                                                  height: 12, width: 12),
                                            ),
                                          ),
                                        )
                                    ],
                                    if (player?.events?.redCard != null) ...[
                                        Positioned(
                                          left: -10,
                                          top: 16,
                                          child: DecoratedBox(
                                            decoration: const BoxDecoration(color: Color.fromRGBO(23, 32, 57, 1.0), shape: BoxShape.circle,boxShadow: [
                                              BoxShadow()
                                            ]),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Image.asset('assets/images/match-red-card.png',
                                                  height: 12, width: 12),
                                            ),
                                          ),
                                        )
                                    ],
                                    if (player?.events?.yellowRedCard != null) ...[
                                        Positioned(
                                          left: -10,
                                          top: 16,
                                          child: DecoratedBox(
                                            decoration: const BoxDecoration(color: Color.fromRGBO(23, 32, 57, 1.0), shape: BoxShape.circle,boxShadow: [
                                              BoxShadow()
                                            ]),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Image.asset('assets/images/match-yellow-red-card.png',
                                                  height: 12, width: 12),
                                            ),
                                          ),
                                        )
                                    ],
                                  ],
                                ),
                              ),
                              Flexible(
                                  child: Text(
                                player?.name?.lastName ?? 'undefined',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ))
                            ],
                          ),
                        )
                      ]
                    ],
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _bench(List<LineupPlayerEmbedded?> bench, isHome) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var player in bench) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: isHome ? TextDirection.ltr : TextDirection.rtl,
              children: [
                Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                      color: isHome ? MaterialColors.amberDraw : MaterialColors.blue,
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  child: Center(
                    child: Text(
                      player?.shirt?.toString() ?? "-",
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                    child: Text(
                  player?.name?.lastName ?? "undefined",
                  textAlign: isHome ? TextAlign.start : TextAlign.end,
                  style:
                      const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12),
                )),
                const SizedBox(width: 4),
                _event(player?.events, isHome)
              ],
            ),
          )
        ]
      ],
    );
  }

  Widget _injured(List<LineupPlayerEmbedded?> bench, isHome) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var player in bench) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: isHome ? TextDirection.ltr : TextDirection.rtl,
              children: [
                Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                      color: isHome ? MaterialColors.amberDraw : MaterialColors.blue,
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  child: Center(
                    child: Text(
                      player?.shirt?.toString() ?? "-",
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      player?.injuredInfo?.name ?? "undefined",
                      textAlign: isHome ? TextAlign.start : TextAlign.end,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12),
                    ),
                    Text(
                      '(${player?.injuredInfo?.reason ?? "undefined"})',
                      textAlign: isHome ? TextAlign.start : TextAlign.end,
                      style: const TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.normal, fontSize: 12),
                    ),
                  ],
                ))
              ],
            ),
          )
        ]
      ],
    );
  }

  Widget _coach(List<LineupPlayerEmbedded?> bench, isHome) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var player in bench) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: isHome ? TextDirection.ltr : TextDirection.rtl,
              children: [
                Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                      color: isHome ? MaterialColors.amberDraw : MaterialColors.blue,
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  child: Center(
                    child: Text(
                      player?.name?.firstName?[0] ?? "-",
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(
                  '${player?.name?.firstName ?? "undefined"} ${player?.name?.lastName ?? "undefined"}',
                  textAlign: isHome ? TextAlign.start : TextAlign.end,
                  style:
                      const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12),
                )),
              ],
            ),
          )
        ]
      ],
    );
  }

  Widget _event(LineupEventEmbedded? event, bool isHome) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      textDirection: isHome ? TextDirection.ltr : TextDirection.rtl,
      children: [
        if (event?.sub?.subbedIn != null) ...[
          Icon(
            isHome ? Icons.arrow_circle_right_outlined : Icons.arrow_circle_left_outlined,
            color: MaterialColors.greenWin,
            size: 16,
          ),
          const SizedBox(width: 4)
        ],
        if ((event?.goal ?? 0) > 0) ...[
          if (event!.goal! <= 2) ...[
            SizedBox(
              width: event.goal! == 1 ? 16 : 24,
              height: 16,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for (int i = 0; i < event.goal!; i++)
                    Positioned(
                      left: i * 8,
                      right: 0,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(23, 32, 57, 1.0), shape: BoxShape.circle),
                        child: Image.asset('assets/images/match-goal.png',
                            height: 16, width: 16, color: MaterialColors.greenWin),
                      ),
                    ),
                ],
              ),
            )
          ] else ...[
            Image.asset('assets/images/match-goal.png',
                height: 16, width: 16, color: MaterialColors.greenWin),
            const SizedBox(width: 2),
            Text(
              "x${event.goal!}",
              style: const TextStyle(color: MaterialColors.greenWin, fontSize: 12),
            )
          ],
          const SizedBox(width: 4)
        ],
        if ((event?.assists ?? 0) > 0) ...[
          if (event!.assists! <= 2) ...[
            SizedBox(
              width: event.assists! == 1 ? 16 : 24,
              height: 16,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for (int i = 0; i < event.assists!; i++)
                    Positioned(
                      left: i * 8,
                      right: 0,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(23, 32, 57, 1.0), shape: BoxShape.circle),
                        child: Image.asset('assets/images/match-assists.png',
                            height: 16, width: 16, color: MaterialColors.greenWin),
                      ),
                    ),
                ],
              ),
            )
          ] else ...[
            Image.asset('assets/images/match-assists.png',
                height: 16, width: 16, color: MaterialColors.greenWin),
            const SizedBox(width: 2),
            Text(
              "x${event.assists!}",
              style: const TextStyle(color: MaterialColors.greenWin, fontSize: 12),
            )
          ],
          const SizedBox(width: 4)
        ],
        if ((event?.ownGoal ?? 0) > 0) ...[
          if (event!.ownGoal! <= 2) ...[
            SizedBox(
              width: event.ownGoal! == 1 ? 16 : 24,
              height: 16,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for (int i = 0; i < event.ownGoal!; i++)
                    Positioned(
                      left: i * 8,
                      right: 0,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(23, 32, 57, 1.0), shape: BoxShape.circle),
                        child: Image.asset('assets/images/match-goal.png',
                            height: 16, width: 16, color: MaterialColors.redLose),
                      ),
                    ),
                ],
              ),
            )
          ] else ...[
            Image.asset('assets/images/match-goal.png',
                height: 16, width: 16, color: MaterialColors.redLose),
            const SizedBox(width: 2),
            Text(
              "x${event.ownGoal!}",
              style: const TextStyle(color: MaterialColors.redLose, fontSize: 12),
            )
          ],
          const SizedBox(width: 4)
        ],
        if ((event?.yellowCard ?? 0) > 0) ...[
          Image.asset('assets/images/match-yellow-card.png', height: 16, width: 16),
          const SizedBox(width: 4),
        ],
        if ((event?.redCard ?? 0) > 0) ...[
          Image.asset('assets/images/match-red-card.png', height: 16, width: 16),
          const SizedBox(width: 4),
        ],
        if ((event?.yellowRedCard ?? 0) > 0) ...[
          Image.asset('assets/images/match-yellow-red-card.png', height: 16, width: 16),
          const SizedBox(width: 4),
        ],
        if ((event?.savedPenalties ?? 0) > 0) ...[],
        if ((event?.missedPenalty ?? 0) > 0) ...[],
        if (event?.sub?.subbedOut != null) ...[
          Icon(
            !isHome ? Icons.arrow_circle_right_outlined : Icons.arrow_circle_left_outlined,
            color: MaterialColors.redLose,
            size: 16,
          ),
          const SizedBox(width: 4)
        ],
      ],
    );
  }
}
