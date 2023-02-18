import 'package:flutter/foundation.dart';
import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';
import 'package:foot_news/features/match_feature/data/remote/model/match_header.dart';
import 'package:foot_news/features/matches_feature/data/remote/model/against_team_match.dart';
import 'package:foot_news/features/matches_feature/data/remote/model/status_match.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_h2h.freezed.dart';
part 'match_h2h.g.dart';

@freezed
class H2hBean with _$H2hBean {
  const factory H2hBean({
    @JsonKey(name: 'summary') List<int?>? summary,
    @JsonKey(name: 'matches') List<MatchesBean?>? matches,
  }) = _H2hBean;

  factory H2hBean.fromJson(Map<String, Object?> json) => _$H2hBeanFromJson(json);

  const H2hBean._();

  H2hBeanEmbedded get toCollection => H2hBeanEmbedded()
    ..summary = summary
    ..matches = matches?.map((e) => e?.toCollection).toList();
}

@freezed
class MatchesBean with _$MatchesBean {
  const factory MatchesBean({
    @JsonKey(name: 'matchUrl') String? matchUrl,
    @JsonKey(name: 'league') TeamsBean? league,
    @JsonKey(name: 'home') AgainstTeamMatch? home,
    @JsonKey(name: 'status') StatusMatch? status,
    @JsonKey(name: 'finished') bool? finished,
    @JsonKey(name: 'away') AgainstTeamMatch? away,
  }) = _MatchesBean;

  factory MatchesBean.fromJson(Map<String, Object?> json) {
    int? homeScore;
    int? awayScore;
    if (json['status'] != null && json['status'] is Map) {
      if ((json['status']! as Map<String, Object?>)['scoreStr'] != null) {
        final temp = (json['status']! as Map<String, Object?>)['scoreStr'].toString().split(' ');
        homeScore = int.parse(temp[0]);
        awayScore = int.parse(temp[2]);
      }
    }
    if (json['home'] != null &&
        json['home'] is Map &&
        json['away'] != null &&
        json['away'] is Map) {
      (json['home']! as Map<String, Object?>)['score'] = homeScore;
      (json['away']! as Map<String, Object?>)['score'] = awayScore;
      (json['home']! as Map<String, Object?>)['id'] =
          int.parse((json['home']! as Map<String, Object?>)['id'].toString());
      (json['away']! as Map<String, Object?>)['id'] =
          int.parse((json['away']! as Map<String, Object?>)['id'].toString());
    }

    if (json['league'] != null && json['league'] is Map) {
      (json['league'] as Map)['id'] = int.parse((json['league'] as Map)['id']);
    }
    return _$MatchesBeanFromJson(json);
  }

  //
  // factory MatchesBean.fromJson(Map<String, dynamic> json) => _$MatchesBeanFromJson(json);

  const MatchesBean._();

  MatchesBeanEmbedded get toCollection => MatchesBeanEmbedded()
    ..away = away?.toCollection
    ..home = home?.toCollection
    ..finished = finished
    ..league = league?.toCollection
    ..status = status?.toCollection
    ..matchUrl = matchUrl;
}
