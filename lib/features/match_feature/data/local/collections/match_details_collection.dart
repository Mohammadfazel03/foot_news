import 'package:foot_news/features/matches_feature/data/local/collections/match_collection.dart';
import 'package:isar/isar.dart';

part 'match_details_collection.g.dart';

@collection
class MatchDetailsCollection {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  int? matchId;
  MatchGeneralEmbedded? general;
  MatchHeaderEmbedded? header;
  List<String?>? nav;
  bool? ongoing;
  MatchContentEmbedded? content;
}

@embedded
class MatchGeneralEmbedded {
  String? matchId;
  int? leagueId;
  String? matchName;
  String? matchRound;
  TeamColorsBeanEmbedded? teamColors;
  String? leagueName;
  String? countryCode;
  String? matchTimeUTC;
  String? leagueRoundName;
  int? parentLeagueId;
  String? parentLeagueName;
  String? parentLeagueSeason;
  String? matchTimeUTCDate;
  bool? started;
  bool? finished;
}

@embedded
class TeamColorsBeanEmbedded {
  String? home;
  String? away;
}

@embedded
class MatchHeaderEmbedded {
  List<TeamsBeanEmbedded?>? teams;
  StatusMatchEmbedded? status;
}

@embedded
class TeamsBeanEmbedded {
  String? name;
  int? id;
  int? score;
  String? imageUrl;
  String? pageUrl;
}

@embedded
class MatchContentEmbedded {
  MatchFactsEmbedded? matchFacts;
  StatsEmbedded? stats;
  LineupEmbedded? lineup;
  H2hBeanEmbedded? h2h;
}

@embedded
class MatchFactsEmbedded {
  int? matchId;
  EventsEmbedded? events;
  InfoBoxEmbedded? infoBox;
  List<NestedListTeamFormEmbedded?>? teamForm;
}

@embedded
class NestedListTeamFormEmbedded {
  List<TeamFormEmbedded?>? teamForm;
}

@embedded
class EventsEmbedded {
  bool? ongoing;
  List<EventsBeanEmbedded?>? events;
}

@embedded
class EventsBeanEmbedded {
  String? reactKey;
  String? timeStr;
  String? type;
  int? time;
  int? overloadTime;
  int? eventId;
  String? profileUrl;
  String? overloadTimeStr;
  bool? isHome;
  bool? ownGoal;
  bool? injuredPlayerOut;
  bool? isPenaltyShootoutEvent;
  String? nameStr;
  String? firstName;
  String? lastName;
  int? playerId;
  String? penShootoutScore;
  String? card;
  String? assistStr;
  String? assistProfileUrl;
  String? suffix;
  String? goalDescription;
  String? minutesAddedStr;
  String? missedPenaltyStr;
  String? halfStrShort;
  int? assistPlayerId;
  List<PlayerBeanEmbedded?>? swap;
  PlayerBeanEmbedded? player;
  VideoAssistantRefereeEmbedded? videoAssistantReferee;
}

@embedded
class VideoAssistantRefereeEmbedded {
  bool? pendingDecision;
  String? decision;
}

@embedded
class PlayerBeanEmbedded {
  int? id;
  String? name;
}

@embedded
class InfoBoxEmbedded {
  TournamentEmbedded? tournament;
  StadiumEmbedded? stadium;
  RefereeEmbedded? referee;
  int? attendance;
}

@embedded
class RefereeEmbedded {
  String? imgUrl;
  String? text;
  String? country;
}

@embedded
class StadiumEmbedded {
  String? name;
  String? city;
  String? country;
  double? lat;
  double? long;
}

@embedded
class TournamentEmbedded {
  int? id;
  String? link;
  String? leagueName;
  String? round;
}

@embedded
class TeamFormEmbedded {
  int? result;
  String? resultString;
  String? score;
}

@embedded
class LineupEmbedded {
  List<LineupBeanEmbedded?>? lineup;
  ParentLineupEmbedded? bench;
  ParentLineupEmbedded? coaches;
  ParentLineupEmbedded? naPlayers;
  TeamRatingsEmbedded? teamRatings;
  bool? hasFantasy;
  bool? usingEnetpulseLineup;
  bool? usingOptaLineup;
  bool? simpleLineup;
}

@embedded
class ParentLineupEmbedded {
  List<String?>? sides;
  List<NestedListLineupPlayerEmbedded?>? arr;
}

@embedded
class NestedListLineupPlayerEmbedded {
  List<LineupPlayerEmbedded?>? arr;
}

@embedded
class LineupBeanEmbedded {
  int? teamId;
  String? teamName;
  List<LineupPlayerEmbedded?>? bench;
  List<NestedListLineupPlayerEmbedded?>? players;
  String? lineup;
  List<NestedListLineupPlayerEmbedded?>? nonAvailablePlayers;
}

@embedded
class LineupPlayerEmbedded {
  String? id;
  bool? usingOptaId;
  PlayerNameEmbedded? name;
  String? imageUrl;
  int? shirt;
  int? timeSubbedOn;
  int? timeSubbedOff;
  bool? isHomeTeam;
  bool? isCaptain;
  int? usualPosition;
  int? positionRow;
  String? role;
  String? positionStringShort;
  LineupEventEmbedded? events;
  PlayerRatingEmbedded? rating;
  int? minutesPlayed;
  InjuredInfoEmbedded? injuredInfo;
}

@embedded
class InjuredInfoEmbedded {
  int? id;
  String? name;
  String? reason;
  String? expectedReturn;
  bool? injury;
}

@embedded
class PlayerRatingEmbedded {
  String? num;
  String? bgcolor;
  IsTopPlayerEmbedded? isTop;
}

@embedded
class IsTopPlayerEmbedded {
  bool? isTopRating;
  bool? isMatchFinished;
}

@embedded
class PlayerNameEmbedded {
  String? firstName;
  String? lastName;
}

@embedded
class TeamRatingsEmbedded {
  TeamRatingsBeanEmbedded? home;
  TeamRatingsBeanEmbedded? away;
}

@embedded
class TeamRatingsBeanEmbedded {
  double? num;
  String? bgcolor;
}

@embedded
class LineupEventEmbedded {
  int? missedPenalty;
  int? savedPenalties;
  int? yellowCard;
  int? redCard;
  int? assists;
  int? goal;
  int? ownGoal;
  int? yellowRedCard;
  LineupSubEmbedded? sub;
}

@embedded
class LineupSubEmbedded {
  int? subbedIn;
  int? subbedOut;
}

@embedded
class H2hBeanEmbedded {
  List<int?>? summary;
  List<MatchesBeanEmbedded?>? matches;
}

@embedded
class MatchesBeanEmbedded {
  String? matchUrl;
  TeamsBeanEmbedded? league;
  TeamMatchEmbedded? home;
  StatusMatchEmbedded? status;
  bool? finished;
  TeamMatchEmbedded? away;
}

@embedded
class StatsEmbedded {
  List<StatsBeanEmbedded?>? stats;
  TeamColorsBeanEmbedded? teamColors;
}

@embedded
class StatsBeanEmbedded {
  String? title;
  List<StatsBeanEmbedded?>? stats;
  List<String?>? statsString;
  String? type;
  String? highlighted;
}
