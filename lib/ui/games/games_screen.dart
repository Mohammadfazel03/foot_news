import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foot_news/data/repository/match_repository_impl.dart';
import 'package:foot_news/ui/games/fixture/fixture_tab_bloc.dart';
import 'package:foot_news/ui/games/fixture/fixture_tab_screen.dart';
import 'package:foot_news/ui/widgets/tabbar/tab_indicator.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../data/remote/api_service.dart';
import '../widgets/tabbar/tab_bloc.dart' as tab_bloc;

class GamesScreen extends StatefulWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  late int _currentCount;
  late int _currentPosition;

  @override
  void initState() {
    _currentPosition =
        BlocProvider.of<tab_bloc.TabBloc>(context).state.tab.position;
    _currentCount = BlocProvider.of<tab_bloc.TabBloc>(context).state.tab.count;
    _tabController = TabController(
        length: _currentCount, vsync: this, initialIndex: _currentPosition);

    _tabController.addListener(onPositionChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<tab_bloc.TabBloc, tab_bloc.TabState>(
      listener: (context, state) {
        if (_tabController.length != state.tab.count) {
          _tabController.removeListener(onPositionChange);
          _tabController.dispose();

          _currentPosition = state.tab.position;

          if (_currentPosition > state.tab.count - 1) {
            _currentPosition = state.tab.count - 1;
            _currentPosition = _currentPosition < 0 ? 0 : _currentPosition;
          }

          _currentCount = state.tab.count;
          _tabController = TabController(
            length: state.tab.count,
            vsync: this,
            initialIndex: _currentPosition,
          );
          _tabController.addListener(onPositionChange);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: SizedBox(
              height: kToolbarHeight,
              width: double.infinity,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 18,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(41, 109, 180, 1.0),
                                Color.fromRGBO(2, 160, 83, 1.0),
                                Color.fromRGBO(255, 208, 2, 1.0),
                              ],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(3),
                              topRight: Radius.circular(3))),
                      height: 3,
                      width: (320 * 18 / 56),
                    ),
                  )
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 48),
              child: SizedBox(
                height: 48,
                width: double.infinity,
                child: Material(
                    color: Theme.of(context).primaryColorLight,
                    child: TabBar(
                        unselectedLabelColor:
                            Theme.of(context).unselectedWidgetColor,
                        labelColor: Theme.of(context).colorScheme.secondary,
                        indicator: CustomTabIndicator(
                            color: Theme.of(context).colorScheme.secondary,
                            indicatorHeight: 3,
                            radius: 4),
                        isScrollable: true,
                        tabs: _getTabs(state.tab.items),
                        controller: _tabController)),
              ),
            ),
            backgroundColor: Theme.of(context).primaryColorDark,
          ),
          body: Column(children: <Widget>[
            Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: getWidgets(state.tab.items)),
            ),
          ]),
        );
      },
    );
  }

  List<Widget> _getTabs(Map<DateTime, String> items) {
    List<Widget> tabs = [];
    items.forEach((key, value) {
      tabs.add(Tab(text: value));
    });
    return tabs;
  }

  List<Widget> getWidgets(Map<DateTime, String> items) {
    List<Widget> screens = [];
    items.forEach((key, value) {
      screens.add(BlocProvider(
          create: (context) => FixtureTabBloc(
              matchRepository: MatchRepositoryImpl(
                  api: ApiService(), isar: Isar.openSync([])),
              dateTime: key),
          key: Key(DateFormat('yyyyMMdd').format(key)),
          child: const FixtureTabScreen()));
    });
    return screens;
  }

  onPositionChange() {
    if (!_tabController.indexIsChanging) {
      _currentPosition = _tabController.index;
      if (_tabController.index == _tabController.length - 1) {
        BlocProvider.of<tab_bloc.TabBloc>(context).add(tab_bloc.TabEvent(
            addToEnd: true, currentPosition: _tabController.index));
      } else if (_tabController.index == 0) {
        BlocProvider.of<tab_bloc.TabBloc>(context).add(tab_bloc.TabEvent(
            addToEnd: false, currentPosition: _tabController.index));
      }
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
