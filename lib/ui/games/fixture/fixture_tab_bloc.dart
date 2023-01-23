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
      : super(
            FixtureTabState(isLoading: true, response: null, errors: Queue())) {
    matchRepository.getStreamMatches(dateTime).listen((event) {
      add(FixtureTabEvent.updatedData(event));
    });
    on<FixtureTabEvent>((event, emit) async {
      if (event is _UpdateData) {
        DataResponse<MatchResponse> response = await matchRepository
            .getMatches(DateFormat('yyyyMMdd').format(dateTime));
        if (response is DataSuccess) {
          try {
            await matchRepository.insertMatches(response.data!);
          } catch (e) {
            state.addError('Error When update Data');
            emit(state);
          }
        } else {
          state.addError(response.error!);
          emit(state);
        }
      } else if (event is _UpdatedData) {
        emit(state.copyWith(isLoading: false, response: event.response));
      } else if (event is _ErrorShown) {
        state.errorShown();
        emit(state);
      } else if (event is _RefreshData) {
        emit(state.copyWith(isLoading: true));
      }
    });
  }
}
