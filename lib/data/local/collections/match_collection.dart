import 'package:foot_news/data/local/collections/match_league_collection.dart';
import 'package:isar/isar.dart';

@collection
@Name('match')
class MatchCollection {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late int matchId;
  late DateTime time;
  late TeamMatchEmbedded home;
  late TeamMatchEmbedded away;
  int? statusId;
  String? tournamentStage;
  StatusMatchEmbedded? status;
  int? timeTs;

  final league = IsarLink<MatchLeagueCollection>();
}

@embedded
class TeamMatchEmbedded {
  late int id;
  int? score;
  String? name;
  String? longName;
}

@embedded
class StatusMatchEmbedded {
  String? utcTime;
  bool? started;
  bool? cancelled;
  bool? finished;
}