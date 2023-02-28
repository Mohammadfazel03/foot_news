import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';
import 'package:foot_news/features/matches_feature/data/local/collections/match_collection.dart';
import 'package:foot_news/features/matches_feature/data/remote/model/against_team_match.dart';
import 'package:foot_news/features/matches_feature/data/remote/model/status_match.dart';
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

  factory MatchEntity.fromEmbedded(MatchesBeanEmbedded match) => MatchEntity(
      id: int.tryParse(match.matchUrl!.split('/')[2]),
      leagueId: match.league?.id,
      time: DateTime.tryParse(match.status!.utcTime!),
      home: AgainstTeamMatch.fromCollection(match.home!),
      away: AgainstTeamMatch.fromCollection(match.away!),
      statusId: null,
      tournamentStage: null,
      status: StatusMatch.fromCollection(match.status!),
      timeTS: null,
      isFavourite: false);

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
