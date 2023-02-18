import 'package:flutter/foundation.dart';
import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_fact.freezed.dart';
part 'match_fact.g.dart';

@freezed
class MatchFacts with _$MatchFacts {
  const factory MatchFacts({
    @JsonKey(name: 'matchId') int? matchId,
    @JsonKey(name: 'events') Events? events,
    @JsonKey(name: 'infoBox') InfoBoxBean? infoBox,
    @JsonKey(name: 'teamForm') List<List<TeamFormBean?>?>? teamForm,
  }) = _MatchFacts;

  factory MatchFacts.fromJson(Map<String, Object?> json) => _$MatchFactsFromJson(json);

  const MatchFacts._();

  MatchFactsEmbedded get toCollection => MatchFactsEmbedded()
    ..events = events?.toCollection
    ..matchId = matchId
    ..infoBox = infoBox?.toCollection
    ..teamForm = teamForm?.map((e) => _parseNestedList(e)).toList();

  NestedListTeamFormEmbedded _parseNestedList(List<TeamFormBean?>? list) =>
      NestedListTeamFormEmbedded()..teamForm = list?.map((e) => e?.toCollection).toList();
}

@freezed
class Events with _$Events {
  const factory Events({
    @JsonKey(name: 'ongoing') bool? ongoing,
    @JsonKey(name: 'events') List<EventsBean?>? events,
  }) = _Events;

  factory Events.fromJson(Map<String, Object?> json) => _$EventsFromJson(json);

  const Events._();

  EventsEmbedded get toCollection => EventsEmbedded()
    ..ongoing = ongoing
    ..events = events?.map((e) => e?.toCollection).toList();
}

@freezed
class EventsBean with _$EventsBean {
  const EventsBean._();

  const factory EventsBean({
    @JsonKey(name: 'reactKey') String? reactKey,
    @JsonKey(name: 'timeStr') String? timeStr,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'time') int? time,
    @JsonKey(name: 'overloadTime') int? overloadTime,
    @JsonKey(name: 'eventId') int? eventId,
    @JsonKey(name: 'profileUrl') String? profileUrl,
    @JsonKey(name: 'overloadTimeStr') String? overloadTimeStr,
    @JsonKey(name: 'isHome') bool? isHome,
    @JsonKey(name: 'ownGoal') bool? ownGoal,
    @JsonKey(name: 'injuredPlayerOut') bool? injuredPlayerOut,
    @JsonKey(name: 'isPenaltyShootoutEvent') bool? isPenaltyShootoutEvent,
    @JsonKey(name: 'nameStr') String? nameStr,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'playerId') int? playerId,
    @JsonKey(name: 'penShootoutScore') String? penShootoutScore,
    @JsonKey(name: 'card') String? card,
    @JsonKey(name: 'assistStr') String? assistStr,
    @JsonKey(name: 'assistProfileUrl') String? assistProfileUrl,
    @JsonKey(name: 'suffix') String? suffix,
    @JsonKey(name: 'goalDescription') String? goalDescription,
    @JsonKey(name: 'minutesAddedStr') String? minutesAddedStr,
    @JsonKey(name: 'halfStrShort') String? halfStrShort,
    @JsonKey(name: 'missedPenaltyStr') String? missedPenaltyStr,
    @JsonKey(name: 'assistPlayerId') int? assistPlayerId,
    @JsonKey(name: 'swap') List<PlayerBean?>? swap,
    @JsonKey(name: 'player') PlayerBean? player,
    @JsonKey(name: 'VAR') VideoAssistantReferee? videoAssistantReferee,
  }) = _EventsBean;

  factory EventsBean.fromJson(Map<String, Object?> json) {
    if (json['overloadTime'] == null || json['overloadTime'] == 0) {
      json['overloadTimeStr'] = null;
    }

    if (json['timeStr'] != null || json['timeStr'] is int) {
      json['timeStr'] = json['timeStr'].toString();
    }

    return _$EventsBeanFromJson(json);
  }

  // factory EventsBean.fromJson(Map<String, dynamic> json) => _$EventsBeanFromJson(json);

  EventsBeanEmbedded get toCollection => EventsBeanEmbedded()
    ..type = type
    ..time = time
    ..assistPlayerId = assistPlayerId
    ..assistProfileUrl = assistProfileUrl
    ..assistStr = assistStr
    ..card = card
    ..eventId = eventId
    ..firstName = firstName
    ..goalDescription = goalDescription
    ..halfStrShort = halfStrShort
    ..injuredPlayerOut = injuredPlayerOut
    ..isHome = isHome
    ..isPenaltyShootoutEvent = isPenaltyShootoutEvent
    ..lastName = lastName
    ..minutesAddedStr = minutesAddedStr
    ..missedPenaltyStr = missedPenaltyStr
    ..nameStr = nameStr
    ..overloadTime = overloadTime
    ..overloadTimeStr = overloadTimeStr
    ..ownGoal = ownGoal
    ..penShootoutScore = penShootoutScore
    ..player = player?.toCollection
    ..playerId = playerId
    ..profileUrl = profileUrl
    ..reactKey = reactKey
    ..suffix = suffix
    ..swap = swap?.map((e) => e?.toCollection).toList()
    ..timeStr = timeStr
    ..videoAssistantReferee = videoAssistantReferee?.toCollection;
}

@freezed
class VideoAssistantReferee with _$VideoAssistantReferee {
  const factory VideoAssistantReferee({
    @JsonKey(name: 'pendingDecision') bool? pendingDecision,
    @JsonKey(name: 'decision') String? decision,
  }) = _VideoAssistantReferee;

  factory VideoAssistantReferee.fromJson(Map<String, dynamic> json) =>
      _$VideoAssistantRefereeFromJson(json);

  const VideoAssistantReferee._();

  VideoAssistantRefereeEmbedded get toCollection => VideoAssistantRefereeEmbedded()
    ..decision = decision
    ..pendingDecision = pendingDecision;
}

@freezed
class PlayerBean with _$PlayerBean {
  const factory PlayerBean({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
  }) = _PlayerBean;

  // factory PlayerBean.fromJson(Map<String, Object?> json) => _$PlayerBeanFromJson(json);

  factory PlayerBean.fromJson(Map<String, Object?> json) {
    if (json['id'] != null && json['id'] is String) {
      json['id'] = int.parse(json['id'] as String);
    }
    return _$PlayerBeanFromJson(json);
  }

  const PlayerBean._();

  PlayerBeanEmbedded get toCollection => PlayerBeanEmbedded()
    ..name = name
    ..id = id;
}

@freezed
class InfoBoxBean with _$InfoBoxBean {
  const factory InfoBoxBean({
    @JsonKey(name: 'Tournament') TournamentBean? tournament,
    @JsonKey(name: 'Stadium') StadiumBean? stadium,
    @JsonKey(name: 'Referee') RefereeBean? referee,
    @JsonKey(name: 'Attendance') int? attendance,
  }) = _InfoBoxBean;

  factory InfoBoxBean.fromJson(Map<String, Object?> json) => _$InfoBoxBeanFromJson(json);

  const InfoBoxBean._();

  InfoBoxEmbedded get toCollection => InfoBoxEmbedded()
    ..attendance = attendance
    ..referee = referee?.toCollection
    ..stadium = stadium?.toCollection
    ..tournament = tournament?.toCollection;
}

@freezed
class RefereeBean with _$RefereeBean {
  const factory RefereeBean({
    @JsonKey(name: 'imgUrl') String? imgUrl,
    @JsonKey(name: 'text') String? text,
    @JsonKey(name: 'country') String? country,
  }) = _RefereeBean;

  factory RefereeBean.fromJson(Map<String, Object?> json) => _$RefereeBeanFromJson(json);

  const RefereeBean._();

  RefereeEmbedded get toCollection => RefereeEmbedded()
    ..country = country
    ..text = text
    ..imgUrl = imgUrl;
}

@freezed
class StadiumBean with _$StadiumBean {
  const factory StadiumBean({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'city') String? city,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'lat') double? lat,
    @JsonKey(name: 'long') double? long,
  }) = _StadiumBean;

  factory StadiumBean.fromJson(Map<String, Object?> json) => _$StadiumBeanFromJson(json);

  const StadiumBean._();

  StadiumEmbedded get toCollection => StadiumEmbedded()
    ..name = name
    ..long = long
    ..city = city
    ..lat = lat
    ..country = country;
}

@freezed
class TournamentBean with _$TournamentBean {
  const factory TournamentBean({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'link') String? link,
    @JsonKey(name: 'leagueName') String? leagueName,
    @JsonKey(name: 'round') String? round,
  }) = _TournamentBean;

  factory TournamentBean.fromJson(Map<String, Object?> json) => _$TournamentBeanFromJson(json);

  const TournamentBean._();

  TournamentEmbedded get toCollection => TournamentEmbedded()
    ..id = id
    ..leagueName = leagueName
    ..link = link
    ..round = round;
}

@freezed
class TeamFormBean with _$TeamFormBean {
  const factory TeamFormBean({
    @JsonKey(name: 'result') int? result,
    @JsonKey(name: 'resultString') String? resultString,
    @JsonKey(name: 'score') String? score,
  }) = _TeamFormBean;

  factory TeamFormBean.fromJson(Map<String, Object?> json) => _$TeamFormBeanFromJson(json);

  const TeamFormBean._();

  TeamFormEmbedded get toCollection => TeamFormEmbedded()
    ..score = score
    ..result = result
    ..resultString = resultString;
}
