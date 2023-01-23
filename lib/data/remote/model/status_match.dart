import 'package:foot_news/data/local/collections/match_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_match.freezed.dart';

part 'status_match.g.dart';

@freezed
class StatusMatch with _$StatusMatch {
  const StatusMatch._();

  const factory StatusMatch({
    @JsonKey(name: 'utcTime') String? utcTime,
    @JsonKey(name: 'started') bool? started,
    @JsonKey(name: 'cancelled') bool? cancelled,
    @JsonKey(name: 'finished') bool? finished,
  }) = _StatusMatch;

  factory StatusMatch.fromJson(Map<String, Object?> json) =>
      _$StatusMatchFromJson(json);

  factory StatusMatch.fromCollection(StatusMatchEmbedded collection) =>
      StatusMatch(
          utcTime: collection.utcTime,
          started: collection.started,
          cancelled: collection.cancelled,
          finished: collection.finished);

  StatusMatchEmbedded get toCollection => StatusMatchEmbedded()
    ..cancelled = cancelled
    ..finished = finished
    ..started = started
    ..utcTime = utcTime;
}
