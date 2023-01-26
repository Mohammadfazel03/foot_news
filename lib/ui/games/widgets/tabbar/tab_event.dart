part of 'tab_bloc.dart';

@freezed
class TabEvent with _$TabEvent {
  const factory TabEvent(
      {required bool addToEnd, required int currentPosition}) = _TabEvent;
}
