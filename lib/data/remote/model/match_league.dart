import 'package:foot_news/data/local/collections/match_league_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'match.dart';

part 'match_league.freezed.dart';

part 'match_league.g.dart';

@freezed
class MatchLeague with _$MatchLeague {
  const MatchLeague._();

  const factory MatchLeague({
    @JsonKey(name: 'ccode') String? ccode,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'primaryId') int? primaryId,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'matches') List<Match>? matches,
    @JsonKey(name: 'internalRank') int? internalRank,
    @JsonKey(name: 'liveRank') int? liveRank,
    @JsonKey(name: 'simpleLeague') bool? simpleLeague,
  }) = _MatchLeague;

  factory MatchLeague.fromJson(Map<String, Object?> json) =>
      _$MatchLeagueFromJson(json);

  factory MatchLeague.fromCollection(MatchLeagueCollection collection) =>
      MatchLeague(
          ccode: collection.ccode,
          id: collection.leagueId,
          primaryId: collection.primaryId,
          name: collection.name,
          matches:
              collection.matches.map((e) => Match.fromCollection(e)).toList(),
          internalRank: collection.internalRank,
          liveRank: collection.liveRank,
          simpleLeague: collection.simpleLeague);

  MatchLeagueCollection get toCollection => MatchLeagueCollection()
    ..leagueId = id
    ..internalRank = internalRank
    ..liveRank = liveRank
    ..name = name
    ..primaryId = primaryId
    ..simpleLeague = simpleLeague
    ..matches.addAll(matches?.map((e) => e.toCollection) ?? [])
    ..ccode = ccode;
}
