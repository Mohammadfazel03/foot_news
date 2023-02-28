import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foot_news/di.dart';
import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';
import 'package:foot_news/features/match_feature/presentation/bloc/game_details_bloc.dart';
import 'package:foot_news/features/match_feature/presentation/screens/game_details_screen.dart';
import 'package:foot_news/features/match_feature/presentation/widget/timer/timer_cubit.dart';
import 'package:foot_news/features/matches_feature/data/entity/match_entity.dart';
import 'package:intl/intl.dart';

class GameDetailsH2HScreen extends StatelessWidget {
  final H2hBeanEmbedded h2h;

  const GameDetailsH2HScreen({Key? key, required this.h2h}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        if (h2h.summary?.isNotEmpty == true &&
            h2h.summary?.every((element) => element != null) == true) ...[
          DecoratedBox(
            decoration: const BoxDecoration(
                border: Border(
                    // top: BorderSide(color: Colors.white54),
                    bottom: BorderSide(color: Colors.white54, width: 0.5))),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "${h2h.summary![0]}",
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        border: Border(
                            right: BorderSide(color: Colors.white54),
                            left: BorderSide(color: Colors.white54))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Text(
                        "${h2h.summary![1]}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "${h2h.summary![2]}",
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
        for (int i = 0; i < (h2h.matches?.length ?? 0); i++) ...[
          GestureDetector(
            child: _horizontall_match_item(h2h.matches![i]),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(create: (context) => getIt<GameDetailsBloc>()),
                            BlocProvider(create: (context) => getIt<TimerCubit>()),
                          ],
                          child: GameDetailsScreen(
                              matchEntity: MatchEntity.fromEmbedded(h2h.matches![i]!)))));
            },
          )
        ]
      ],
    );
  }

  _horizontall_match_item(MatchesBeanEmbedded? match) {
    return DecoratedBox(
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.white54))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (match?.status?.utcTime != null)
                    Expanded(
                      child: Text(
                        DateFormat('EEE, MMM dd, yyyy')
                            .format(DateTime.parse(match!.status!.utcTime!)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ),
                  if (match?.league?.name != null)
                    Expanded(
                        child: Text(match!.league!.name!,
                            maxLines: 1,
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70, fontSize: 12))),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  match?.home?.name ?? 'undefined',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                )),
                CachedNetworkImage(
                    placeholder: (context, string) =>
                        Image.asset('assets/images/team_placeholder.png'),
                    errorWidget: (context, string, error) =>
                        Image.asset('assets/images/team_placeholder.png'),
                    imageUrl:
                        'https://images.fotmob.com/image_resources/logo/teamlogo/${match?.home?.id}_xsmall.png',
                    height: 24,
                    width: 24),
                if (match?.status?.finished == true && match?.status?.cancelled == false)
                  Flexible(
                      child: Text(
                    '${match?.home?.score ?? 0} - ${match?.away?.score ?? 0}',
                    maxLines: 1,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  )),
                if (match?.status?.cancelled == true)
                  Flexible(
                      child: Text(
                    DateFormat('HH:mm').format(DateTime.parse(match!.status!.utcTime!)),
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
                if (match?.status?.started == false && match?.status?.cancelled == false)
                  Flexible(
                      child: Text(
                    DateFormat('HH:mm').format(DateTime.parse(match!.status!.utcTime!)),
                    maxLines: 1,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  )),
                CachedNetworkImage(
                    placeholder: (context, string) =>
                        Image.asset('assets/images/team_placeholder.png'),
                    errorWidget: (context, string, error) =>
                        Image.asset('assets/images/team_placeholder.png'),
                    imageUrl:
                        'https://images.fotmob.com/image_resources/logo/teamlogo/${match?.away?.id}_xsmall.png',
                    height: 24,
                    width: 24),
                Expanded(
                    child: Text(
                  match?.away?.name ?? 'undefined',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
