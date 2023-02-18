import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:foot_news/common/utils/data_response.dart';
import 'package:foot_news/features/matches_feature/data/entity/match_entity.dart';
import 'package:foot_news/features/matches_feature/data/entity/match_league_entity.dart';
import 'package:foot_news/features/matches_feature/data/remote/model/match_response.dart';
import 'package:foot_news/features/matches_feature/data/repository/match_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'fixture_tab_bloc.freezed.dart';
part 'fixture_tab_event.dart';
part 'fixture_tab_state.dart';

class FixtureTabBloc extends Bloc<FixtureTabEvent, FixtureTabState> {
  MatchRepository matchRepository;
  DateTime dateTime;

  FixtureTabBloc({required this.matchRepository, required this.dateTime})
      : super(
            FixtureTabState(isLoading: true, response: null, errors: Queue(), isAllResult: true)) {
    on<FixtureTabEventUpdateData>((event, emit) async {
      DataResponse<MatchResponse> response =
          await matchRepository.getMatches(DateFormat('yyyyMMdd').format(dateTime));
      if (response is DataSuccess) {
        try {
          await matchRepository.insertMatches(response.data!);
          emit(state.copyWith(isLoading: false));
        } catch (e) {
          var errors = state.addError('Error When update Data');
          emit(state.copyWith(errors: errors, isLoading: false));
        }
      } else {
        var errors = state.addError(response.error!);
        emit(state.copyWith(errors: errors, isLoading: false));
      }
    });

    on<FixtureTabEventErrorShown>((event, emit) async {
      var errors = state.errorShown();
      emit(state.copyWith(errors: errors));
    });

    on<FixtureTabEventRefreshData>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      DataResponse<MatchResponse> response =
          await matchRepository.getMatches(DateFormat('yyyyMMdd').format(dateTime));
      if (response is DataSuccess) {
        try {
          await matchRepository.insertMatches(response.data!);
          emit(state.copyWith(isLoading: false));
        } catch (e) {
          var errors = state.addError('Error When update Data');
          emit(state.copyWith(errors: errors, isLoading: false));
        }
      } else {
        var errors = state.addError(response.error!);
        emit(state.copyWith(errors: errors, isLoading: false));
      }
    });

    on<FixtureTabEventGetData>((event, emit) async {
      await emit.forEach(
          matchRepository
              .getStreamMatches(
                  date: dateTime,
                  byFavourite: event.byFavourite,
                  byOngoing: event.byOngoing,
                  byTime: event.byTime)
              .map((event) => event
                  .expand((element) => [
                        FixtureTabItem(
                            type: FixtureType.league, league: element.copyWith(matches: null)),
                        ...?element.matches
                            ?.map((e) => FixtureTabItem(type: FixtureType.match, match: e))
                      ])
                  .toList()),
          onData: (entity) => state.copyWith(
              response: entity,
              isAllResult: !event.byOngoing && !event.byTime && !event.byFavourite));
    }, transformer: restartable());

    on<FixtureTabEventToggleFavorite>((event, emit) async {
      await matchRepository.toggleFavorite(event.matchEntity);
    });
  }
}
