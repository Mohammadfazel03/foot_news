part of 'fixture_tab_bloc.dart';

@freezed
class FixtureTabEvent with _$FixtureTabEvent {
  const FixtureTabEvent._();

  const factory FixtureTabEvent.updateData() = _UpdateData;
  const factory FixtureTabEvent.updatedData(List<MatchLeague> response) = _UpdatedData;
  const factory FixtureTabEvent.errorShown() = _ErrorShown;


}
