part of 'fixture_tab_bloc.dart';

abstract class FixtureTabEvent {}

class FixtureTabEventUpdateData extends FixtureTabEvent {
  FixtureTabEventUpdateData();
}

class FixtureTabEventRefreshData extends FixtureTabEvent {
  FixtureTabEventRefreshData();
}

class FixtureTabEventErrorShown extends FixtureTabEvent {
  FixtureTabEventErrorShown();
}

class FixtureTabEventToggleFavorite extends FixtureTabEvent {
  MatchEntity matchEntity;

  FixtureTabEventToggleFavorite({required this.matchEntity});
}

class FixtureTabEventGetData extends FixtureTabEvent {
  bool byTime;
  bool byOngoing;
  bool byFavourite;

  FixtureTabEventGetData({this.byTime = false, this.byOngoing = false, this.byFavourite = false});
}
