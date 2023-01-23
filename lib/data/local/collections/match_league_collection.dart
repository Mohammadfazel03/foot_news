import 'package:foot_news/data/local/collections/match_collection.dart';
import 'package:isar/isar.dart';

part 'match_league_collection.g.dart';

@collection
@Name('match_league')
class MatchLeagueCollection {
  Id id = Isar.autoIncrement;
  @Index(composite: [CompositeIndex('leagueId')], unique: true, replace: true)
  int? primaryId;
  @Name('leagueId')
  int? leagueId;
  String? name;
  int? internalRank;
  int? liveRank;
  bool? simpleLeague;
  String? ccode;

  @Backlink(to: 'league')
  final matches = IsarLinks<MatchCollection>();
}