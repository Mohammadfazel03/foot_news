import 'package:foot_news/features/matches_feature/data/local/collections/match_league_collection.dart';
import 'package:isar/isar.dart';

part 'match_collection.g.dart';

@collection
@Name('match')
class MatchCollection {
  Id? id;
  @Index(unique: true, replace: true)
  late int matchId;
  late DateTime time;
  late TeamMatchEmbedded home;
  late TeamMatchEmbedded away;
  int? statusId;
  String? tournamentStage;
  StatusMatchEmbedded? status;
  int? timeTs;
  bool isFavourite = false;

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
  bool? ongoing;
  LiveTimeStatusEmbedded? liveTime;
  LiveTimeStatusEmbedded? reason;
}

@embedded
class LiveTimeStatusEmbedded {
  String? short;
  String? long;
}
