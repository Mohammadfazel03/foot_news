import 'package:flutter/foundation.dart';
import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_general.freezed.dart';
part 'match_general.g.dart';

@freezed
class MatchGeneral with _$MatchGeneral {
  const factory MatchGeneral({
    @JsonKey(name: 'matchId') String? matchId,
    @JsonKey(name: 'matchName') String? matchName,
    @JsonKey(name: 'matchRound') String? matchRound,
    @JsonKey(name: 'teamColors') TeamColorsBean? teamColors,
    @JsonKey(name: 'leagueId') int? leagueId,
    @JsonKey(name: 'leagueName') String? leagueName,
    @JsonKey(name: 'leagueRoundName') String? leagueRoundName,
    @JsonKey(name: 'parentLeagueId') int? parentLeagueId,
    @JsonKey(name: 'countryCode') String? countryCode,
    @JsonKey(name: 'parentLeagueName') String? parentLeagueName,
    @JsonKey(name: 'parentLeagueSeason') String? parentLeagueSeason,
    @JsonKey(name: 'matchTimeUTC') String? matchTimeUTC,
    @JsonKey(name: 'matchTimeUTCDate') String? matchTimeUTCDate,
    @JsonKey(name: 'started') bool? started,
    @JsonKey(name: 'finished') bool? finished,
  }) = _MatchGeneral;

  factory MatchGeneral.fromJson(Map<String, Object?> json) => _$MatchGeneralFromJson(json);

  const MatchGeneral._();

  MatchGeneralEmbedded get toCollection => MatchGeneralEmbedded()
    ..matchId = matchId
    ..leagueName = leagueName
    ..started = started
    ..finished = finished
    ..leagueId = leagueId
    ..countryCode = countryCode
    ..leagueRoundName = leagueRoundName
    ..matchName = matchName
    ..matchRound = matchRound
    ..matchTimeUTC = matchTimeUTC
    ..matchTimeUTCDate = matchTimeUTCDate
    ..parentLeagueId = parentLeagueId
    ..parentLeagueName = parentLeagueName
    ..parentLeagueSeason = parentLeagueSeason
    ..teamColors = teamColors?.toCollection;
}

@freezed
class TeamColorsBean with _$TeamColorsBean {
  const factory TeamColorsBean({
    @JsonKey(name: 'home') String? home,
    @JsonKey(name: 'away') String? away,
  }) = _TeamColorsBean;

  factory TeamColorsBean.fromJson(Map<String, Object?> json) => _$TeamColorsBeanFromJson(json);

  const TeamColorsBean._();

  TeamColorsBeanEmbedded get toCollection => TeamColorsBeanEmbedded()
    ..home = home
    ..away = away;
}
