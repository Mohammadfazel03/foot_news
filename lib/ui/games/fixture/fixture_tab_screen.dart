import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foot_news/data/entity/match_entity.dart';
import 'package:foot_news/data/entity/match_league_entity.dart';
import 'package:foot_news/ui/games/fixture/fixture_tab_bloc.dart';
import 'package:foot_news/ui/games/widgets/filter_chip/filter_chip.dart' as widget;
import 'package:foot_news/ui/games/widgets/filter_chip/filter_chip_cubit.dart';
import 'package:intl/intl.dart';

class FixtureTabScreen extends StatefulWidget {
  const FixtureTabScreen({Key? key}) : super(key: key);

  @override
  State<FixtureTabScreen> createState() => _FixtureTabScreenState();
}

class _FixtureTabScreenState extends State<FixtureTabScreen> with AutomaticKeepAliveClientMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  late final Timer timer;

  @override
  void initState() {
    BlocProvider.of<FixtureTabBloc>(context).add(FixtureTabEventUpdateData());

    BlocProvider.of<FixtureTabBloc>(context).add(FixtureTabEventGetData(
        byTime: BlocProvider.of<FilterChipCubit>(context).state.byTime,
        byFavourite: BlocProvider.of<FilterChipCubit>(context).state.byFavourite,
        byOngoing: BlocProvider.of<FilterChipCubit>(context).state.byOngoing));

    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      context.read<FixtureTabBloc>().add(FixtureTabEventUpdateData());
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScaffoldMessenger(
      child: Scaffold(
        body: Container(
          color: Theme.of(context).primaryColor,
          child: MultiBlocListener(
            listeners: [
              BlocListener<FixtureTabBloc, FixtureTabState>(listener: (context, state) {
                if (state.errors.isNotEmpty && (state.response?.isNotEmpty ?? false)) {
                  final snackBar = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(state.errors.first,
                        style: const TextStyle(fontSize: 12, color: Colors.white)),
                    backgroundColor: Theme.of(context).primaryColorDark,
                    duration: const Duration(days: 365),
                    action: SnackBarAction(
                        textColor: Theme.of(context).colorScheme.secondary,
                        label: 'Ok',
                        onPressed: () {
                          context.read<FixtureTabBloc>().add(FixtureTabEventErrorShown());
                          _refreshIndicatorKey.currentState?.show();
                        }),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }),
              BlocListener<FilterChipCubit, FilterChipState>(listener: (context, state) {
                BlocProvider.of<FixtureTabBloc>(context).add(FixtureTabEventGetData(
                    byTime: state.byTime,
                    byOngoing: state.byOngoing,
                    byFavourite: state.byFavourite));
              }),
            ],
            child: BlocBuilder<FixtureTabBloc, FixtureTabState>(
              builder: (context, state) {
                if ((state.response?.isEmpty ?? true) &&
                    state.isLoading == true &&
                    state.isAllResult == true) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  );
                } else if ((state.response?.isEmpty ?? true) &&
                    state.isLoading == false &&
                    state.errors.isNotEmpty &&
                    state.isAllResult == true) {
                  return Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/network-error.jpg',
                            height: MediaQuery.of(context).size.width / 4,
                            width: MediaQuery.of(context).size.width / 4,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          Flexible(
                              child: GestureDetector(
                                  child: Text('${state.errors.first} \n try Again'),
                                  onTap: () {
                                    context.read<FixtureTabBloc>()
                                      ..add(FixtureTabEventErrorShown())
                                      ..add(FixtureTabEventRefreshData());
                                  }))
                        ],
                      ),
                    ),
                  );
                } else if ((state.response?.isEmpty ?? true) &&
                    state.isLoading == false &&
                    state.errors.isEmpty &&
                    state.isAllResult == true) {
                  return Center(
                      child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/stadium.png',
                          height: MediaQuery.of(context).size.width / 4,
                          width: MediaQuery.of(context).size.width / 4,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        Flexible(
                            child: GestureDetector(
                                child: const Text('No Matches Scheduled'),
                                onTap: () {
                                  context.read<FixtureTabBloc>().add(FixtureTabEventErrorShown());
                                }))
                      ],
                    ),
                  ));
                }
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  color: Theme.of(context).colorScheme.secondary,
                  onRefresh: () {
                    final bloc = BlocProvider.of<FixtureTabBloc>(context);
                    bloc.add(FixtureTabEventRefreshData());
                    return bloc.stream.firstWhere((element) => element.isLoading == false);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: widget.FilterChip(),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: state.response?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            if (state.response![index].type == FixtureType.match) {
                              return _matchItem(state.response![index].match!);
                            } else {
                              return _leagueItem(state.response![index].league!);
                            }
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            if (state.response!.length > index + 1) {
                              if (state.response![index].type == FixtureType.match &&
                                  state.response![index + 1].type == FixtureType.match) {
                                return const Divider(
                                  thickness: 0.5,
                                  height: 0.5,
                                  color: Colors.white54,
                                );
                              }
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _leagueItem(MatchLeagueEntity leagueEntity) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: const Border(
              top: BorderSide(color: Colors.white30), bottom: BorderSide(color: Colors.white30)),
          color: Theme.of(context).primaryColorDark),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 8,
            ),
            if (leagueEntity.ccode != null) ...[
              CachedNetworkImage(
                  placeholder: (context, string) =>
                      Image.asset('assets/images/team_placeholder.png'),
                  errorWidget: (context, string, error) =>
                      Image.asset('assets/images/team_placeholder.png'),
                  imageUrl:
                      'https://images.fotmob.com/image_resources/logo/teamlogo/${leagueEntity.ccode!.toLowerCase()}.png',
                  height: 16,
                  width: 16),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                  child: Text(
                "${leagueEntity.name}",
                style: const TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ))
            ] else ...[
              Icon(
                Icons.access_time_rounded,
                color: Theme.of(context).colorScheme.secondary,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              const Flexible(
                  child: Text(
                "By Time",
                style: TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ))
            ],
          ],
        ),
      ),
    );
  }

  Widget _matchItem(MatchEntity matchEntity) {
    return Container(
      height: 48,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(matchEntity.isFavourite ? Icons.star : Icons.star_outline),
                  color: matchEntity.isFavourite
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).unselectedWidgetColor,
                  onPressed: () {
                    context
                        .read<FixtureTabBloc>()
                        .add(FixtureTabEventToggleFavorite(matchEntity: matchEntity));
                  },
                ),
                const SizedBox(width: 8),
                Flexible(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                              placeholder: (context, string) =>
                                  Image.asset('assets/images/team_placeholder.png'),
                              errorWidget: (context, string, error) =>
                                  Image.asset('assets/images/team_placeholder.png'),
                              imageUrl:
                                  'https://images.fotmob.com/image_resources/logo/teamlogo/${matchEntity.home?.id}_xsmall.png',
                              height: 16,
                              width: 16),
                          const SizedBox(width: 8),
                          Flexible(
                              child: Text(
                            "${matchEntity.home?.name}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(fontSize: 12, color: Colors.white),
                          ))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                              placeholder: (context, string) =>
                                  Image.asset('assets/images/team_placeholder.png'),
                              errorWidget: (context, string, error) =>
                                  Image.asset('assets/images/team_placeholder.png'),
                              imageUrl:
                                  'https://images.fotmob.com/image_resources/logo/teamlogo/${matchEntity.away?.id}_xsmall.png',
                              height: 16,
                              width: 16),
                          const SizedBox(width: 8),
                          Flexible(
                              child: Text(
                            "${matchEntity.away?.name}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(fontSize: 12, color: Colors.white),
                          ))
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (matchEntity.status?.started == true) ...[
                    // SizedBox(width: 8),
                    Text(
                      "${matchEntity.status?.liveTime?.short ?? matchEntity.status?.reason?.short}",
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                    ),
                    // SizedBox(width: 8),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            "${matchEntity.home?.score}",
                            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            "${matchEntity.away?.score}",
                            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    )),
                    // SizedBox(width: 8),
                  ] else if (matchEntity.status?.started == false &&
                      matchEntity.status?.cancelled == false) ...[
                    Text(
                      DateFormat(DateFormat.HOUR24_MINUTE).format(matchEntity.time!.toLocal()),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ] else if (matchEntity.status?.cancelled == true) ...[
                    Text(
                      DateFormat(DateFormat.HOUR24_MINUTE).format(matchEntity.time!.toLocal()),
                      style: const TextStyle(
                          color: Colors.white, decoration: TextDecoration.lineThrough),
                    ),
                  ]
                ]),
          )
        ],
      ),
    );
  }
}
