part of 'fixture_tab_bloc.dart';


@freezed
class FixtureTabState with _$FixtureTabState {

  const FixtureTabState._();

  const factory FixtureTabState.noGame(bool isLoading, Queue<String> errors) = _NoGame;
  const factory FixtureTabState.hasGame(bool isLoading, List<MatchLeague> response, Queue<String> errors) = _HasGame;

  errorShown() {
    errors.removeFirst();
  }

  addError(String error) {
    errors.addFirst(error);
  }
}
