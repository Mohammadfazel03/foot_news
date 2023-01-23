part of 'fixture_tab_bloc.dart';

@freezed
class FixtureTabState with _$FixtureTabState {
  const FixtureTabState._();

  const factory FixtureTabState(
      {required bool isLoading,
      required List<MatchLeague>? response,
      required Queue<String> errors}) = _FixtureTabState;

  errorShown() {
    errors.removeFirst();
  }

  addError(String error) {
    errors.addFirst(error);
  }
}
