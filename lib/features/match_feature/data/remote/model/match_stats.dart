import 'package:flutter/foundation.dart';
import 'package:foot_news/features/match_feature/data/remote/model/match_general.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_stats.freezed.dart';
part 'match_stats.g.dart';

@freezed
class Stats with _$Stats {
  const factory Stats({
    @JsonKey(name: 'stats') List<StatsBean>? stats,
    @JsonKey(name: 'teamColors') TeamColorsBean? teamColors,
  }) = _Stats;

  factory Stats.fromJson(Map<String, Object?> json) => _$StatsFromJson(json);
}

@freezed
class StatsBean with _$StatsBean {
  const factory StatsBean({
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'stats') List<Object>? stats,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'highlighted') String? highlighted,
  }) = _StatsBean;

  factory StatsBean.fromJson(Map<String, Object?> json) => _$StatsBeanFromJson(json);
}
