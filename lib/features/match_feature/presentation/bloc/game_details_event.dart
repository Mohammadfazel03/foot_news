part of 'game_details_bloc.dart';

@immutable
abstract class GameDetailsEvent {}

class GameDetailsEventGetData extends GameDetailsEvent {
  final int matchId;

  GameDetailsEventGetData(this.matchId);
}

class GameDetailsEventRefreshData extends GameDetailsEvent {
  final int matchId;

  GameDetailsEventRefreshData(this.matchId);
}

class GameDetailsEventUpdateData extends GameDetailsEvent {
  final int matchId;

  GameDetailsEventUpdateData(this.matchId);
}

class GameDetailsEventErrorShown extends GameDetailsEvent {
  GameDetailsEventErrorShown();
}
