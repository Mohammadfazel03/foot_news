import 'package:foot_news/data/local/collections/match_collection.dart';
import 'package:foot_news/data/remote/model/against_team_match.dart';
import 'package:foot_news/data/remote/model/status_match.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match.freezed.dart';

part 'match.g.dart';

@freezed
class Match with _$Match {
  const Match._();

  const factory Match({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'leagueId') int? leagueId,
    @JsonKey(name: 'time') String? time,
    @JsonKey(name: 'home') AgainstTeamMatch? home,
    @JsonKey(name: 'away') AgainstTeamMatch? away,
    @JsonKey(name: 'statusId') int? statusId,
    @JsonKey(name: 'tournamentStage') String? tournamentStage,
    @JsonKey(name: 'status') StatusMatch? status,
    @JsonKey(name: 'timeTS') int? timeTS,
  }) = _Match;

  factory Match.fromJson(Map<String, Object?> json) => _$MatchFromJson(json);

  MatchCollection get toCollection => MatchCollection()
    ..away = away!.toCollection
    ..home = home!.toCollection
    ..matchId = id!
    ..status = status?.toCollection
    ..statusId = statusId
    ..time = DateTime.parse(status!.utcTime!)
    ..timeTs = timeTS
    ..tournamentStage = tournamentStage;
}
