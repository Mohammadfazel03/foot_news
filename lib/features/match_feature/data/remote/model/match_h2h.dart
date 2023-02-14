import 'package:flutter/foundation.dart';
import 'package:foot_news/features/matches_feature/data/remote/model/against_team_match.dart';
import 'package:foot_news/features/matches_feature/data/remote/model/match_league.dart';
import 'package:foot_news/features/matches_feature/data/remote/model/status_match.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_h2h.freezed.dart';

part 'match_h2h.g.dart';

@freezed
class H2hBean with _$H2hBean {
  const factory H2hBean({
    @JsonKey(name: 'summary') List<int>? summary,
    @JsonKey(name: 'matches') List<MatchesBean>? matches,
  }) = _H2hBean;

  factory H2hBean.fromJson(Map<String, Object?> json) => _$H2hBeanFromJson(json);
}

@freezed
class MatchesBean with _$MatchesBean {
  const factory MatchesBean({
    @JsonKey(name: 'matchUrl') String? matchUrl,
    @JsonKey(name: 'league') MatchLeague? league,
    @JsonKey(name: 'home') AgainstTeamMatch? home,
    @JsonKey(name: 'status') StatusMatch? status,
    @JsonKey(name: 'finished') bool? finished,
    @JsonKey(name: 'away') AgainstTeamMatch? away,
  }) = _MatchesBean;

  factory MatchesBean.fromJson(Map<String, Object?> json) {
    if (json['status'] != null && json['status'] is Map) {
      if ((json['status']! as Map<String, Object?>)['scoreStr'] != null) {
        final temp = (json['status']! as Map<String, Object?>)['scoreStr'].toString().split(' ');
        if(json['home'] != null && json['home'] is Map && json['away'] != null && json['away'] is Map) {
          (json['home']! as Map<String, Object?>)['score'] = int.parse(temp[0]);
          (json['away']! as Map<String, Object?>)['score'] = int.parse(temp[2]);
        }
      }
    }
    return _$MatchesBeanFromJson(json);
  }
//
// factory MatchesBean.fromJson(Map<String, dynamic> json) => _$MatchesBeanFromJson(json);


}
