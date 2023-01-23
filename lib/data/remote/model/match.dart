import 'package:foot_news/data/local/collections/match_collection.dart';
import 'package:foot_news/data/remote/model/away_team_match.dart';
import 'package:foot_news/data/remote/model/home_team_match.dart';
import 'package:foot_news/data/remote/model/status_match.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'match.freezed.dart';

part 'match.g.dart';

@freezed
class Match with _$Match {
  const Match._();

  const factory Match({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'leagueId') int? leagueId,
    @JsonKey(name: 'time') String? time,
    @JsonKey(name: 'home') HomeTeamMatch? home,
    @JsonKey(name: 'away') AwayTeamMatch? away,
    @JsonKey(name: 'statusId') int? statusId,
    @JsonKey(name: 'tournamentStage') String? tournamentStage,
    @JsonKey(name: 'status') StatusMatch? status,
    @JsonKey(name: 'timeTS') int? timeTS,
  }) = _Match;

  factory Match.fromJson(Map<String, Object?> json) => _$MatchFromJson(json);

  factory Match.fromCollection(MatchCollection match) =>
      Match(
          id: match.matchId,
          leagueId: match.league.value?.leagueId,
          time: DateFormat('dd.MM.yyyy HH:mm').format(match.time),
          home: HomeTeamMatch.fromCollection(match.home),
          away: AwayTeamMatch.fromCollection(match.away),
          statusId: match.statusId,
          tournamentStage: match.tournamentStage,
          status: StatusMatch.fromCollection(match.status!),
          timeTS: match.timeTs
      );

  MatchCollection get toCollection =>
      MatchCollection()
        ..away = away!.toCollection
        ..home = home!.toCollection
        ..matchId = id!
        ..status = status?.toCollection
        ..statusId = statusId
        ..time = DateTime.parse('dd.MM.yyyy HH:mm')
        ..timeTs = timeTS
        ..tournamentStage = tournamentStage;
}
