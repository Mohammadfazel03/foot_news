part of 'fixture_tab_bloc.dart';

@freezed
class FixtureTabState with _$FixtureTabState {
  const FixtureTabState._();

  const factory FixtureTabState(
      {required bool isLoading,
      required List<FixtureTabItem>? response,
      required Queue<String> errors,
      required bool isAllResult}) = _FixtureTabState;

  Queue<String> errorShown() {
    Queue<String> queue = Queue<String>();
    queue.addAll(errors);
    queue.removeFirst();
    return queue;
  }

  Queue<String> addError(String error) {
    Queue<String> queue = Queue<String>();
    queue.addAll(errors);
    queue.add(error);
    return queue;
  }
}

@freezed
class FixtureTabItem with _$FixtureTabItem {
  const FixtureTabItem._();

  const factory FixtureTabItem(
      {required FixtureType type, MatchEntity? match, MatchLeagueEntity? league}) = _FixtureTabItem;
}

enum FixtureType { league, match }
