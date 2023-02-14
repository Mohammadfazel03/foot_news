import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_fact.freezed.dart';
part 'match_fact.g.dart';

@freezed
class MatchFacts with _$MatchFacts {
  const factory MatchFacts({
    @JsonKey(name: 'matchId') int? matchId,
    @JsonKey(name: 'events') Events? events,
    @JsonKey(name: 'infoBox') InfoBoxBean? infoBox,
    @JsonKey(name: 'teamForm') List<List<TeamFormBean>>? teamForm,
  }) = _MatchFacts;

  factory MatchFacts.fromJson(Map<String, Object?> json) => _$MatchFactsFromJson(json);
}


@freezed
class Events with _$Events {
  const factory Events({
    @JsonKey(name: 'ongoing') bool? ongoing,
    @JsonKey(name: 'events') List<EventsBean>? events,
  }) = _Events;

  factory Events.fromJson(Map<String, Object?> json) => _$EventsFromJson(json);
}

@freezed
class EventsBean with _$EventsBean {

  const EventsBean._();

  const factory EventsBean({
    @JsonKey(name: 'reactKey') String? reactKey,
    @JsonKey(name: 'timeStr') int? timeStr,
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
    @JsonKey(name: 'swap') List<PlayerBean>? swap,
    @JsonKey(name: 'player') PlayerBean? player,
    @JsonKey(name: 'VAR') VideoAssistantReferee? videoAssistantReferee,
  }) = _EventsBean;

  factory EventsBean.fromJson(Map<String, Object?> json) {
    if (json['overloadTime'] == null || json['overloadTime'] == 0) {
      json['overloadTimeStr'] = null;
    }
    return _$EventsBeanFromJson(json);
  }
// factory EventsBean.fromJson(Map<String, dynamic> json) => _$EventsBeanFromJson(json);
}

@freezed
class VideoAssistantReferee with _$VideoAssistantReferee {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory VideoAssistantReferee({
    @JsonKey(name: 'pendingDecision') bool? pendingDecision,
    @JsonKey(name: 'decision') String? decision,
  }) = _VideoAssistantReferee;

  factory VideoAssistantReferee.fromJson(Map<String, dynamic> json) =>
      _$VideoAssistantRefereeFromJson(json);
}

@freezed
class PlayerBean with _$PlayerBean {
  const factory PlayerBean({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'profileUrl') String? profileUrl,
  }) = _PlayerBean;

  factory PlayerBean.fromJson(Map<String, Object?> json) => _$PlayerBeanFromJson(json);
}


@freezed
class InfoBoxBean with _$InfoBoxBean {
  const factory InfoBoxBean({
    @JsonKey(name: 'Tournament') TournamentBean? Tournament,
    @JsonKey(name: 'Stadium') StadiumBean? Stadium,
    @JsonKey(name: 'Referee') RefereeBean? Referee,
    @JsonKey(name: 'Attendance') int? Attendance,
  }) = _InfoBoxBean;

  factory InfoBoxBean.fromJson(Map<String, Object?> json) => _$InfoBoxBeanFromJson(json);
}

@freezed
class RefereeBean with _$RefereeBean {
  const factory RefereeBean({
    @JsonKey(name: 'imgUrl') String? imgUrl,
    @JsonKey(name: 'text') String? text,
    @JsonKey(name: 'country') String? country,
  }) = _RefereeBean;

  factory RefereeBean.fromJson(Map<String, Object?> json) => _$RefereeBeanFromJson(json);
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
}


@freezed
class TeamFormBean with _$TeamFormBean {
  const factory TeamFormBean({
    @JsonKey(name: 'result') int? result,
    @JsonKey(name: 'resultString') String? resultString,
    @JsonKey(name: 'score') String? score,
  }) = _TeamFormBean;

  factory TeamFormBean.fromJson(Map<String, Object?> json) => _$TeamFormBeanFromJson(json);
}
