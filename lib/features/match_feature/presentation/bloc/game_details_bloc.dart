import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:foot_news/common/utils/data_response.dart';
import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';
import 'package:foot_news/features/match_feature/data/remote/model/match_result.dart';
import 'package:foot_news/features/match_feature/data/repository/match_details_repository.dart';
import 'package:meta/meta.dart';

part 'game_details_event.dart';
part 'game_details_state.dart';

class GameDetailsBloc extends Bloc<GameDetailsEvent, GameDetailsState> {
  final MatchDetailsRepository repository;

  GameDetailsBloc({required this.repository}) : super(GameDetailsState.init()) {
    on<GameDetailsEvent>((event, emit) {});

    on<GameDetailsEventGetData>((event, emit) async {
      await emit.forEach(repository.getStreamMatch(event.matchId),
          onData: (data) => state.copyWith(response: data));
    }, transformer: restartable());

    on<GameDetailsEventErrorShown>((event, emit) {
      var errors = state.errorShown();
      emit(state.copyWith(errors: errors));
    }, transformer: restartable());

    on<GameDetailsEventRefreshData>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      DataResponse<MatchResult> response = await repository.getMatch(event.matchId);
      if (response is DataSuccess) {
        try {
          var res = await repository.insertMatch(response.data!);
          if (res > 0) {
            emit(state.copyWith(isLoading: false));
          } else {
            var errors = state.addError('Error When update Data');
            emit(state.copyWith(errors: errors, isLoading: false));
          }
        } catch (e) {
          var errors = state.addError('Error When update Data');
          emit(state.copyWith(errors: errors, isLoading: false));
        }
      } else {
        var errors = state.addError(response.error!);
        emit(state.copyWith(errors: errors, isLoading: false));
      }
    }, transformer: restartable());

    on<GameDetailsEventUpdateData>((event, emit) async {
      DataResponse<MatchResult> response = await repository.getMatch(event.matchId);
      if (response is DataSuccess) {
        try {
          await repository.insertMatch(response.data!);
          emit(state.copyWith(isLoading: false));
        } catch (e) {
          var errors = state.addError('Error When update Data');
          emit(state.copyWith(errors: errors, isLoading: false));
        }
      } else {
        var errors = state.addError(response.error!);
        emit(state.copyWith(errors: errors, isLoading: false));
      }
    }, transformer: restartable());
  }
}
