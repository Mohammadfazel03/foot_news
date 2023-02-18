import 'package:flutter/foundation.dart';
import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';
import 'package:foot_news/features/matches_feature/data/remote/model/status_match.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_header.freezed.dart';
part 'match_header.g.dart';

@freezed
class HeaderBean with _$HeaderBean {
  const factory HeaderBean({
    @JsonKey(name: 'teams') List<TeamsBean?>? teams,
    @JsonKey(name: 'status') StatusMatch? status,
  }) = _HeaderBean;

  factory HeaderBean.fromJson(Map<String, Object?> json) => _$HeaderBeanFromJson(json);

  const HeaderBean._();

  MatchHeaderEmbedded get toCollection => MatchHeaderEmbedded()
    ..status = status?.toCollection
    ..teams = teams?.map((e) => e?.toCollection).toList();
}

@freezed
class TeamsBean with _$TeamsBean {
  const factory TeamsBean({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'score') int? score,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'pageUrl') String? pageUrl,
  }) = _TeamsBean;

  factory TeamsBean.fromJson(Map<String, Object?> json) {
    if (json['id'] != null && json['id'] is String) {
      json['id'] = int.parse(json['id']!.toString());
    }
    return _$TeamsBeanFromJson(json);
  }

  // factory TeamsBean.fromJson(Map<String, Object?> json) => _$TeamsBeanFromJson(json);

  const TeamsBean._();

  TeamsBeanEmbedded get toCollection => TeamsBeanEmbedded()
    ..id = id
    ..name = name
    ..score = score
    ..imageUrl = imageUrl
    ..pageUrl = pageUrl;
}
