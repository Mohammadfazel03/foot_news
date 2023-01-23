import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:foot_news/data/remote/model/match_response.dart';
import 'package:foot_news/data/repository/match_repository.dart';
import 'package:foot_news/utils/data_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../data/remote/model/match_league.dart';

part 'fixture_tab_event.dart';

part 'fixture_tab_state.dart';

part 'fixture_tab_bloc.freezed.dart';

class FixtureTabBloc extends Bloc<FixtureTabEvent, FixtureTabState> {
  MatchRepository matchRepository;
  DateTime dateTime;

  FixtureTabBloc({required this.matchRepository, required this.dateTime})
      : super(FixtureTabState.noGame(true, Queue())) {
    matchRepository.getStreamMatches(dateTime).listen((event) {
      add(FixtureTabEvent.updatedData(event));
    });

    on<FixtureTabEvent>((event, emit) {
      event.when(updatedData: (List<MatchLeague> response) {
        emit(FixtureTabState.hasGame(false, response, state.errors));
      }, updateData: () async {
        DataResponse<MatchResponse> response = await matchRepository
            .getMatches(DateFormat('yyyyMMdd').format(dateTime));

        if (response is DataSuccess) {
          int id = await matchRepository.insertMatches(response.data!);
          if (id <= 0) {
            state.addError("Error Whene Updated Data");
          }
        } else {
          state.addError(response.error!);
        }
      }, errorShown: () {
        state.errorShown();
      });
    });
  }
}
