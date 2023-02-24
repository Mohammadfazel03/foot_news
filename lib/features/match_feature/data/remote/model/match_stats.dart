import 'package:flutter/foundation.dart';
import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';
import 'package:foot_news/features/match_feature/data/remote/model/match_general.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_stats.freezed.dart';
part 'match_stats.g.dart';

@freezed
class Stats with _$Stats {
  const factory Stats({
    @JsonKey(name: 'stats') List<StatsBean?>? stats,
    @JsonKey(name: 'teamColors') TeamColorsBean? teamColors,
  }) = _Stats;

  factory Stats.fromJson(Map<String, Object?> json) => _$StatsFromJson(json);

  const Stats._();

  StatsEmbedded get toCollection => StatsEmbedded()
    ..teamColors = teamColors?.toCollection
    ..stats = stats?.map((e) => e?.toCollection).toList();
}

@freezed
class StatsBean with _$StatsBean {
  const factory StatsBean({
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'stats') List<Object?>? stats,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'highlighted') String? highlighted,
  }) = _StatsBean;

  factory StatsBean.fromJson(Map<String, Object?> json) => _$StatsBeanFromJson(json);

  const StatsBean._();

  StatsBeanEmbedded get toCollection {
    if (stats != null) {
      if (stats!.isNotEmpty) {
        if (stats!.first is Map<String, Object?>) {
          List<StatsBeanEmbedded?> temp = stats!.map((e) {
            if (e != null) {
              var temp = (StatsBean.fromJson(e as Map<String, Object?>));
              return temp.toCollection;
            }
          }).toList();
          return StatsBeanEmbedded()
            ..type = type
            ..highlighted = highlighted
            ..title = title
            ..stats = temp;
        } else {
          var temp = stats!.map((e) => e?.toString()).toList();
          return StatsBeanEmbedded()
            ..type = type
            ..highlighted = highlighted
            ..title = title
            ..statsString = temp;
        }
      }
    }
    return StatsBeanEmbedded()
      ..type = type
      ..highlighted = highlighted
      ..title = title;
  }
}
