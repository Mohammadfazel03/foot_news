import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foot_news/common/utils/color_parser.dart';
import 'package:foot_news/common/utils/game_tab_details.dart';
import 'package:foot_news/common/utils/material_colors.dart';
import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';
import 'package:foot_news/features/match_feature/presentation/bloc/game_details_bloc.dart';
import 'package:foot_news/features/match_feature/presentation/widget/timer/timer_cubit.dart';
import 'package:foot_news/features/match_feature/presentation/widget/timer/timer_widget.dart';
import 'package:foot_news/features/matches_feature/data/entity/match_entity.dart';
import 'package:foot_news/features/matches_feature/presentation/widget/tabbar/tab_indicator.dart';
import 'package:intl/intl.dart';

class GameDetailsScreen extends StatefulWidget {
  final MatchEntity matchEntity;

  const GameDetailsScreen({Key? key, required this.matchEntity}) : super(key: key);

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  // late TabController _tabController;
  late int _currentCount;
  late int _currentPosition;

  @override
  void initState() {
    context.read<GameDetailsBloc>().add(GameDetailsEventRefreshData(widget.matchEntity.id!));
    context.read<GameDetailsBloc>().add(GameDetailsEventGetData(widget.matchEntity.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldMessenger(
        child: Scaffold(
          body: BlocConsumer<GameDetailsBloc, GameDetailsState>(
            listener: (context, state) {
              if (state.response?.header?.status?.liveTime?.long?.contains(':') == true) {
                var temp = (state.response?.header?.status?.liveTime?.long ?? '0:0').split(':');
                var initCounter = int.parse(temp[0]) * 60 + int.parse(temp[1]);
                context.read<TimerCubit>().setSeconds(initCounter);
              }
              if (state.response != null && state.errors.isNotEmpty) {
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
                        context.read<GameDetailsBloc>().add(GameDetailsEventErrorShown());
                        context
                            .read<GameDetailsBloc>()
                            .add(GameDetailsEventRefreshData(widget.matchEntity.id!));
                      }),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              Widget bodyWidget = Center(
                  child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary));
              if (state.response != null) {
                bodyWidget = TabBarView(children: _getTabsScreen(state.response));
              } else if (state.isLoading == false &&
                  state.response == null &&
                  state.errors.isNotEmpty) {
                bodyWidget = Center(
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
                                  context.read<GameDetailsBloc>()
                                    ..add(GameDetailsEventErrorShown())
                                    ..add(GameDetailsEventRefreshData(widget.matchEntity.id!));
                                }))
                      ],
                    ),
                  ),
                );
              } else if (state.isLoading == false &&
                  state.response == null &&
                  state.errors.isEmpty) {
                bodyWidget = Center(
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
                      const Flexible(child: Text('No Inform about this Match'))
                    ],
                  ),
                ));
              }
              return DefaultTabController(
                length: _getTabs(state.response).length,
                child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                          SliverPersistentHeader(
                            delegate: GameDetailsHeader(
                                matchEntity: widget.matchEntity, matchCollection: state.response),
                            pinned: true,
                          ),
                          if (state.response != null)
                            SliverPersistentHeader(
                              delegate: GameDetailsTabBar(
                                  tabBar: TabBar(
                                unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
                                labelColor: Theme.of(context).colorScheme.secondary,
                                indicator: CustomTabIndicator(
                                    color: Theme.of(context).colorScheme.secondary,
                                    indicatorHeight: 3,
                                    radius: 4),
                                isScrollable: true,
                                tabs: _getTabs(state.response!),
                              )),
                              pinned: true,
                            ),
                        ],
                    body: bodyWidget),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _getTabs(MatchDetailsCollection? matchCollection) {
    List<Widget> tabs = [];
    for (var nav in matchCollection?.nav ?? []) {
      if (nav != 'liveticker' &&
          nav != 'knockout' &&
          nav != null &&
          nav != 'table' &&
          nav != 'playoff' &&
          nav != 'buzz') {
        if (nav == 'head to head') {
          tabs.add(Tab(text: TabDetailsType.values.byName('h2h').getName()));
          continue;
        }
        tabs.add(Tab(text: TabDetailsType.values.byName(nav).getName()));
      }
    }
    return tabs;
  }

  List<Widget> _getTabsScreen(MatchDetailsCollection? matchCollection) {
    List<Widget> tabs = [];
    for (var nav in matchCollection?.nav ?? []) {
      if (nav != 'liveticker' &&
          nav != 'knockout' &&
          nav != null &&
          nav != 'table' &&
          nav != 'playoff' &&
          nav != 'buzz') {
        if (nav == 'head to head') {
          tabs.add(Center(
            child: Text(TabDetailsType.values.byName('h2h').getName()),
          ));
          continue;
        }
        tabs.add(Center(
          child: Text(TabDetailsType.values.byName(nav).getName()),
        ));
      }
    }
    return tabs;
  }
}

class GameDetailsHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double collapseHeight;
  final MatchEntity matchEntity;
  final MatchDetailsCollection? matchCollection;

  GameDetailsHeader(
      {this.expandedHeight = 158,
      this.collapseHeight = 56,
      required this.matchEntity,
      this.matchCollection});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border(bottom: BorderSide(color: Colors.white54, width: 0.5))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 88,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: collapseHeight >= shrinkOffset
                        ? 12 + 15 * (1 - shrinkOffset / collapseHeight)
                        : 12),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: EdgeInsets.all(collapseHeight >= shrinkOffset
                      ? 4 + 4 * (1 - shrinkOffset / collapseHeight)
                      : 4),
                  decoration: BoxDecoration(
                    color:
                        HexColor.fromHex(matchCollection?.general?.teamColors?.home ?? '#ffffff'),
                    borderRadius: BorderRadius.all(Radius.circular(collapseHeight >= shrinkOffset
                        ? 4 + 4 * (1 - shrinkOffset / collapseHeight)
                        : 4)),
                  ),
                  child: CachedNetworkImage(
                    placeholder: (context, string) =>
                        Image.asset('assets/images/team_placeholder.png'),
                    errorWidget: (context, string, error) =>
                        Image.asset('assets/images/team_placeholder.png'),
                    imageUrl:
                        'https://images.fotmob.com/image_resources/logo/teamlogo/${matchEntity.home?.id}.png',
                    height: collapseHeight >= shrinkOffset
                        ? 24 + 32 * (1 - shrinkOffset / collapseHeight)
                        : 24,
                    width: collapseHeight >= shrinkOffset
                        ? 24 + 32 * (1 - shrinkOffset / collapseHeight)
                        : 24,
                  ),
                ),
                Expanded(
                  child: Opacity(
                    opacity:
                        collapseHeight >= shrinkOffset ? (1 - shrinkOffset / collapseHeight) : 0,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Wrap(
                          clipBehavior: Clip.hardEdge,
                          direction: Axis.horizontal,
                          spacing: 2,
                          alignment: WrapAlignment.center,
                          children: [
                            if (matchCollection
                                    ?.content?.matchFacts?.teamForm?[0]?.teamForm?.isNotEmpty ??
                                false) ...[
                              if (matchCollection!
                                      .content!.matchFacts!.teamForm![0]!.teamForm!.length <
                                  6) ...[
                                for (var team in matchCollection!
                                    .content!.matchFacts!.teamForm![0]!.teamForm!) ...[
                                  Icon(
                                    Icons.circle_rounded,
                                    color: (team!.result! == 1)
                                        ? MaterialColors.greenWin
                                        : (team.result! == 0)
                                            ? MaterialColors.amberDraw
                                            : MaterialColors.redLose,
                                    size: 8,
                                  ),
                                ]
                              ] else ...[
                                for (int i = 0; i <= 5; i++) ...[
                                  Icon(
                                    Icons.circle_rounded,
                                    color: (matchCollection!.content!.matchFacts!.teamForm![0]!
                                                .teamForm![i]!.result! ==
                                            1)
                                        ? MaterialColors.greenWin
                                        : (matchCollection!.content!.matchFacts!.teamForm![0]!
                                                    .teamForm![i]!.result! ==
                                                0)
                                            ? MaterialColors.amberDraw
                                            : MaterialColors.redLose,
                                    size: 8,
                                  ),
                                ]
                              ],
                              const SizedBox(height: 8),
                            ],
                          ],
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(),
                            clipBehavior: Clip.hardEdge,
                            child: Text(
                              '${matchEntity.home!.name}',
                              maxLines: 2,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: 8)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                SizedBox(
                    height: collapseHeight >= shrinkOffset
                        ? 12 + 15 * (1 - shrinkOffset / collapseHeight)
                        : 12),
                Container(
                  constraints: BoxConstraints(
                      maxHeight: collapseHeight >= shrinkOffset
                          ? 32 * (1 - shrinkOffset / collapseHeight)
                          : 0),
                  child: Opacity(
                      opacity:
                          collapseHeight >= shrinkOffset ? (1 - shrinkOffset / collapseHeight) : 0,
                      child: Text(
                        matchEntity.time != null
                            ? DateFormat('dd MMMM yyyy, HH:mm').format(matchEntity.time!)
                            : 'undefined time',
                        style:
                            TextStyle(color: Theme.of(context).unselectedWidgetColor, fontSize: 12),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      )),
                ),
                SizedBox(
                    height: collapseHeight >= shrinkOffset
                        ? 8 * (1 - shrinkOffset / collapseHeight)
                        : 0),
                if (matchCollection?.header?.status?.started == true) ...[
                  Container(
                    constraints: const BoxConstraints(maxHeight: 28),
                    child: Text(
                      (matchCollection?.header?.teams?[0]?.score != null &&
                              matchCollection?.header?.teams?[1]?.score != null)
                          ? '${matchCollection?.header?.teams?[0]?.score}  -  ${matchCollection?.header?.teams?[1]?.score}'
                          : 'undefined',
                      style:
                          TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  SizedBox(
                      height: collapseHeight >= shrinkOffset
                          ? 8 * (1 - shrinkOffset / collapseHeight)
                          : 0),
                  if (matchCollection?.header?.status?.finished == true ||
                      matchCollection?.header?.status?.cancelled == true ||
                      matchCollection?.header?.status?.liveTime?.short?.contains('’') == false) ...[
                    Container(
                        constraints: const BoxConstraints(maxHeight: 15),
                        child: Text(
                          (matchCollection?.header?.status?.reason?.long != null)
                              ? '${matchCollection?.header?.status?.reason?.long}'
                              : (matchCollection?.header?.status?.liveTime?.long != null)
                                  ? '${matchCollection?.header?.status?.liveTime?.long}'
                                  : 'undefined',
                          style: const TextStyle(
                              color: MaterialColors.redTimer,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                        )),
                  ] else ...[
                    Container(
                        constraints: const BoxConstraints(maxHeight: 15),
                        child: TimerWidget(
                          style: const TextStyle(
                              color: MaterialColors.redTimer,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                        )),
                  ]
                ]
              ])),
          SizedBox(
            width: 88,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: collapseHeight >= shrinkOffset
                        ? 12 + 15 * (1 - shrinkOffset / collapseHeight)
                        : 12),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: EdgeInsets.all(collapseHeight >= shrinkOffset
                      ? 4 + 4 * (1 - shrinkOffset / collapseHeight)
                      : 4),
                  decoration: BoxDecoration(
                    color:
                        HexColor.fromHex(matchCollection?.general?.teamColors?.away ?? '#ffffff'),
                    borderRadius: BorderRadius.all(Radius.circular(collapseHeight >= shrinkOffset
                        ? 4 + 4 * (1 - shrinkOffset / collapseHeight)
                        : 4)),
                  ),
                  child: CachedNetworkImage(
                    placeholder: (context, string) =>
                        Image.asset('assets/images/team_placeholder.png'),
                    errorWidget: (context, string, error) =>
                        Image.asset('assets/images/team_placeholder.png'),
                    imageUrl:
                        'https://images.fotmob.com/image_resources/logo/teamlogo/${matchEntity.away?.id}.png',
                    height: collapseHeight >= shrinkOffset
                        ? 24 + 32 * (1 - shrinkOffset / collapseHeight)
                        : 24,
                    width: collapseHeight >= shrinkOffset
                        ? 24 + 32 * (1 - shrinkOffset / collapseHeight)
                        : 24,
                  ),
                ),
                Expanded(
                  child: Opacity(
                    opacity:
                        collapseHeight >= shrinkOffset ? (1 - shrinkOffset / collapseHeight) : 0,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Wrap(
                          clipBehavior: Clip.hardEdge,
                          direction: Axis.horizontal,
                          spacing: 2,
                          alignment: WrapAlignment.center,
                          children: [
                            if (matchCollection
                                    ?.content?.matchFacts?.teamForm?[1]?.teamForm?.isNotEmpty ??
                                false) ...[
                              if (matchCollection!
                                      .content!.matchFacts!.teamForm![1]!.teamForm!.length <
                                  6) ...[
                                for (var team in matchCollection!
                                    .content!.matchFacts!.teamForm![1]!.teamForm!) ...[
                                  Icon(
                                    Icons.circle_rounded,
                                    color: (team!.result! == 1)
                                        ? MaterialColors.greenWin
                                        : (team.result! == 0)
                                            ? MaterialColors.amberDraw
                                            : MaterialColors.redLose,
                                    size: 8,
                                  ),
                                ]
                              ] else ...[
                                for (int i = 0; i <= 5; i++) ...[
                                  Icon(
                                    Icons.circle_rounded,
                                    color: (matchCollection!.content!.matchFacts!.teamForm![1]!
                                                .teamForm![i]!.result! ==
                                            1)
                                        ? MaterialColors.greenWin
                                        : (matchCollection!.content!.matchFacts!.teamForm![1]!
                                                    .teamForm![i]!.result! ==
                                                0)
                                            ? MaterialColors.amberDraw
                                            : MaterialColors.redLose,
                                    size: 8,
                                  ),
                                ]
                              ],
                              const SizedBox(height: 8),
                            ],
                          ],
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(),
                            clipBehavior: Clip.hardEdge,
                            child: Text(
                              '${matchEntity.away!.name}',
                              maxLines: 2,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: 8)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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

class GameDetailsTabBar extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  GameDetailsTabBar({required TabBar tabBar}) : _tabBar = tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white54, width: 0.5))),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(GameDetailsTabBar oldDelegate) => false;
}
