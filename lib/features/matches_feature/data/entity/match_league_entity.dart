import 'package:foot_news/features/matches_feature/data/entity/match_entity.dart';
import 'package:foot_news/features/matches_feature/data/local/collections/match_league_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_league_entity.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class MatchLeagueEntity with _$MatchLeagueEntity {
  const MatchLeagueEntity._();

  const factory MatchLeagueEntity({
    String? ccode,
    int? id,
    int? primaryId,
    String? name,
    List<MatchEntity>? matches,
    int? internalRank,
    int? liveRank,
    bool? simpleLeague,
  }) = _MatchLeagueEntity;

  factory MatchLeagueEntity.fromCollection(MatchLeagueCollection collection) => MatchLeagueEntity(
      ccode: collection.ccode,
      id: collection.leagueId,
      primaryId: collection.primaryId,
      name: collection.name,
      matches: collection.matches.map((e) => MatchEntity.fromCollection(e)).toList(),
      internalRank: collection.internalRank,
      liveRank: collection.liveRank,
      simpleLeague: collection.simpleLeague);
}
