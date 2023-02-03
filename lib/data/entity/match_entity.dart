import 'package:foot_news/data/local/collections/match_collection.dart';
import 'package:foot_news/data/remote/model/against_team_match.dart';
import 'package:foot_news/data/remote/model/status_match.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_entity.freezed.dart';

@freezed
class MatchEntity with _$MatchEntity {
  const MatchEntity._();

  const factory MatchEntity(
      {int? id,
      int? leagueId,
      DateTime? time,
      AgainstTeamMatch? home,
      AgainstTeamMatch? away,
      int? statusId,
      String? tournamentStage,
      StatusMatch? status,
      int? timeTS,
      @Default(false) bool isFavourite}) = _MatchEntity;

  factory MatchEntity.fromCollection(MatchCollection match) => MatchEntity(
      id: match.matchId,
      leagueId: match.league.value?.leagueId,
      time: match.time,
      home: AgainstTeamMatch.fromCollection(match.home),
      away: AgainstTeamMatch.fromCollection(match.away),
      statusId: match.statusId,
      tournamentStage: match.tournamentStage,
      status: StatusMatch.fromCollection(match.status!),
      timeTS: match.timeTs,
      isFavourite: match.isFavourite);

  MatchCollection get toCollection => MatchCollection()
    ..away = away!.toCollection
    ..home = home!.toCollection
    ..matchId = id!
    ..status = status?.toCollection
    ..statusId = statusId
    ..time = time!
    ..timeTs = timeTS
    ..tournamentStage = tournamentStage
    ..isFavourite = isFavourite;
}
