import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';
import 'package:foot_news/features/match_feature/data/remote/model/match_general.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'match_fact.dart';
import 'match_h2h.dart';
import 'match_header.dart';
import 'match_lineup.dart';
import 'match_stats.dart';

part 'match_result.freezed.dart';
part 'match_result.g.dart';

@freezed
class MatchResult with _$MatchResult {
  const factory MatchResult({
    @JsonKey(name: 'general') MatchGeneral? general,
    @JsonKey(name: 'header') HeaderBean? header,
    @JsonKey(name: 'nav') List<String?>? nav,
    @JsonKey(name: 'ongoing') bool? ongoing,
    @JsonKey(name: 'content') ContentBean? content,
  }) = _MatchResult;

  factory MatchResult.fromJson(Map<String, Object?> json) {
    if (json['general'] != null && json['general'] is bool) {
      json['general'] = null;
    }
    if (json['header'] != null && json['header'] is bool) {
      json['header'] = null;
    }
    if (json['content'] != null && json['content'] is bool) {
      json['content'] = null;
    }
    return _$MatchResultFromJson(json);
  }

  // factory MatchResult.fromJson(Map<String, dynamic> json) => _$MatchResultFromJson(json);

  const MatchResult._();

  MatchDetailsCollection get toCollection => MatchDetailsCollection()
    ..matchId = int.parse(general!.matchId!)
    ..nav = nav
    ..general = general?.toCollection
    ..ongoing = ongoing
    ..content = content?.toCollection
    ..header = header?.toCollection;
}

@freezed
class ContentBean with _$ContentBean {
  const factory ContentBean({
    @JsonKey(name: 'matchFacts') MatchFacts? matchFacts,
    @JsonKey(name: 'stats') Stats? stats,
    @JsonKey(name: 'lineup') Lineup? lineup,
    @JsonKey(name: 'h2h') H2hBean? h2h,
  }) = _ContentBean;

  factory ContentBean.fromJson(Map<String, Object?> json) {
    if (json['matchFacts'] != null && json['matchFacts'] is bool) {
      json['matchFacts'] = null;
    }
    if (json['stats'] != null && json['stats'] is bool) {
      json['stats'] = null;
    }
    if (json['lineup'] != null && json['lineup'] is bool) {
      json['lineup'] = null;
    }
    if (json['h2h'] != null && json['h2h'] is bool) {
      json['h2h'] = null;
    }
    return _$ContentBeanFromJson(json);
  }

  // factory ContentBean.fromJson(Map<String, dynamic> json) => _$ContentBeanFromJson(json);

  const ContentBean._();

  MatchContentEmbedded get toCollection => MatchContentEmbedded()
    ..stats = stats?.toCollection
    ..lineup = lineup?.toCollection
    ..h2h = h2h?.toCollection
    ..matchFacts = matchFacts?.toCollection;
}
