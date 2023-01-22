import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:foot_news/data/repository/match_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/remote/model/match_league.dart';

part 'fixture_tab_event.dart';

part 'fixture_tab_state.dart';

part 'fixture_tab_bloc.freezed.dart';

class FixtureTabBloc extends Bloc<FixtureTabEvent, FixtureTabState> {
  FixtureTabBloc() : super(FixtureTabState.noGame(true, Queue())) {
    on<FixtureTabEvent>((event, emit) {
      event.when(
          updateData: () => {},
          updatedData: (response) => {},
          errorShown: () => {});
    });
  }
}
