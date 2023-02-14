import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_lineup.freezed.dart';
part 'match_lineup.g.dart';

@freezed
class Lineup with _$Lineup {
  const factory Lineup({
    @JsonKey(name: 'lineup') List<LineupBean?>? lineup,
    @JsonKey(name: 'bench') Bench? bench,
    @JsonKey(name: 'coaches') Coach? coaches,
    @JsonKey(name: 'naPlayers') InjuredPlayer? naPlayers,
    @JsonKey(name: 'teamRatings') TeamRatings? teamRatings,
    @JsonKey(name: 'hasFantasy') bool? hasFantasy,
    @JsonKey(name: 'usingEnetpulseLineup') bool? usingEnetpulseLineup,
    @JsonKey(name: 'usingOptaLineup') bool? usingOptaLineup,
    @JsonKey(name: 'simpleLineup') bool? simpleLineup,
  }) = _Lineup;

  factory Lineup.fromJson(Map<String, Object?> json) => _$LineupFromJson(json);
}

@freezed
class InjuredPlayer with _$InjuredPlayer {
  const factory InjuredPlayer({
    @JsonKey(name: 'sides') List<String>? sides,
    @JsonKey(name: 'naPlayersArr') List<List<LineupPlayer?>?>? naPlayersArr,
  }) = _InjuredPlayer;

  factory InjuredPlayer.fromJson(Map<String, Object?> json) => _$InjuredPlayerFromJson(json);
}

@freezed
class Coach with _$Coach {
  const factory Coach({
    @JsonKey(name: 'sides') List<String>? sides,
    @JsonKey(name: 'coachesArr') List<List<LineupPlayer?>?>? coachesArr,
  }) = _Coach;

  factory Coach.fromJson(Map<String, Object?> json) => _$CoachFromJson(json);
}

@freezed
class Bench with _$Bench {
  const factory Bench({
    @JsonKey(name: 'sides') List<String>? sides,
    @JsonKey(name: 'benchArr') List<List<LineupPlayer?>?>? benchArr,
  }) = _Bench;

  factory Bench.fromJson(Map<String, Object?> json) => _$BenchFromJson(json);
}


@freezed
class LineupBean with _$LineupBean {
  const factory LineupBean({
    @JsonKey(name: 'teamId') int? teamId,
    @JsonKey(name: 'teamName') String? teamName,
    @JsonKey(name: 'bench') List<LineupPlayer?>? bench,
    @JsonKey(name: 'nonAvailablePlayers') List<List<LineupPlayer?>?>? nonAvailablePlayers,
    @JsonKey(name: 'players') List<List<LineupPlayer?>?>? players,
    @JsonKey(name: 'lineup') String? lineup,
  }) = _LineupBean;

  factory LineupBean.fromJson(Map<String, Object?> json) => _$LineupBeanFromJson(json);
}

@freezed
class LineupPlayer with _$LineupPlayer {
  const factory LineupPlayer({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'usingOptaId') bool? usingOptaId,
    @JsonKey(name: 'name') PlayerNameBean? name,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'shirt') int? shirt,
    @JsonKey(name: 'timeSubbedOn') int? timeSubbedOn,
    @JsonKey(name: 'timeSubbedOff') int? timeSubbedOff,
    @JsonKey(name: 'isHomeTeam') bool? isHomeTeam,
    @JsonKey(name: 'isCaptain') bool? isCaptain,
    @JsonKey(name: 'usualPosition') int? usualPosition,
    @JsonKey(name: 'positionRow') int? positionRow,
    @JsonKey(name: 'role') String? role,
    @JsonKey(name: 'positionStringShort') String? positionStringShort,
    @JsonKey(name: 'events') Object? events,
    @JsonKey(name: 'rating') PlayerRating? rating,
    @JsonKey(name: 'minutesPlayed') int? minutesPlayed,
    @JsonKey(name: 'naInfo') InjuredInfo? injuredInfo,
  }) = _LineupPlayer;

  factory LineupPlayer.fromJson(Map<String, Object?> json) {
    if (json['id'] != null && json['id'] is int) {
      json['id'] = json['id'].toString();
    }
    return _$LineupPlayerFromJson(json);
  }

  // factory LineupPlayer.fromJson(Map<String, Object?> json) => _$LineupPlayerFromJson(json);

}

@freezed
class InjuredInfo with _$InjuredInfo {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory InjuredInfo({
  @JsonKey(name: 'id') int? id,
  @JsonKey(name: 'name') String? name,
  @JsonKey(name: 'naReason') String? reason,
  @JsonKey(name: 'expectedReturn') String? expectedReturn,
  @JsonKey(name: 'injury') bool? injury,
  }) = _InjuredInfo;

  factory InjuredInfo.fromJson(Map<String, dynamic> json) =>
      _$InjuredInfoFromJson(json);
}

@freezed
class PlayerRating with _$PlayerRating {
  const factory PlayerRating({
    @JsonKey(name: 'num') String? num,
    @JsonKey(name: 'bgcolor') String? bgcolor,
    @JsonKey(name: 'isTop') IsTopPlayer? isTop,
  }) = _PlayerRating;

  factory PlayerRating.fromJson(Map<String, Object?> json) => _$PlayerRatingFromJson(json);
}

@freezed
class IsTopPlayer with _$IsTopPlayer {
  const factory IsTopPlayer({
    @JsonKey(name: 'isTopRating') bool? isTopRating,
    @JsonKey(name: 'isMatchFinished') bool? isMatchFinished,
  }) = _IsTopPlayer;

  factory IsTopPlayer.fromJson(Map<String, Object?> json) => _$IsTopPlayerFromJson(json);
}

@freezed
class PlayerNameBean with _$PlayerNameBean {
  const factory PlayerNameBean({
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
  }) = _PlayerNameBean;

  factory PlayerNameBean.fromJson(Map<String, Object?> json) => _$PlayerNameBeanFromJson(json);
}


@freezed
class TeamRatings with _$TeamRatings {
  const factory TeamRatings({
    @JsonKey(name: 'home') TeamRatingsBean? home,
    @JsonKey(name: 'away') TeamRatingsBean? away,
  }) = _TeamRatings;

  factory TeamRatings.fromJson(Map<String, Object?> json) => _$TeamRatingsFromJson(json);
}

@freezed
class TeamRatingsBean with _$TeamRatingsBean {
  const factory TeamRatingsBean({
    @JsonKey(name: 'num') double? num,
    @JsonKey(name: 'bgcolor') String? bgcolor,
  }) = _TeamRatingsBean;

  factory TeamRatingsBean.fromJson(Map<String, Object?> json) => _$TeamRatingsBeanFromJson(json);
}