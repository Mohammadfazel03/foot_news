import 'package:foot_news/features/matches_feature/data/local/collections/match_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_match.freezed.dart';

part 'status_match.g.dart';

@freezed
class StatusMatch with _$StatusMatch {
  const StatusMatch._();

  const factory StatusMatch(
      {@JsonKey(name: 'utcTime') String? utcTime,
      @JsonKey(name: 'started') bool? started,
      @JsonKey(name: 'cancelled') bool? cancelled,
      @JsonKey(name: 'finished') bool? finished,
      @JsonKey(name: 'ongoing') bool? ongoing,
      @JsonKey(name: 'scoreStr') String? scoreStr,
      @JsonKey(name: 'liveTime') LiveTimeStatus? liveTime,
      @JsonKey(name: 'reason') LiveTimeStatus? reason}) = _StatusMatch;

  factory StatusMatch.fromJson(Map<String, Object?> json) => _$StatusMatchFromJson(json);

  factory StatusMatch.fromCollection(StatusMatchEmbedded collection) => StatusMatch(
      utcTime: collection.utcTime,
      started: collection.started,
      cancelled: collection.cancelled,
      finished: collection.finished,
      ongoing: collection.ongoing,
      liveTime: LiveTimeStatus.fromCollection(collection.liveTime ?? LiveTimeStatusEmbedded()),
      reason: LiveTimeStatus.fromCollection(collection.reason ?? LiveTimeStatusEmbedded()));

  StatusMatchEmbedded get toCollection => StatusMatchEmbedded()
    ..cancelled = cancelled
    ..finished = finished
    ..started = started
    ..utcTime = utcTime
    ..ongoing = ongoing
    ..liveTime = liveTime?.toCollection
    ..reason = reason?.toCollection;
}

@freezed
class LiveTimeStatus with _$LiveTimeStatus {
  const LiveTimeStatus._();

  const factory LiveTimeStatus(
      {@JsonKey(name: 'short') String? short,
      @JsonKey(name: 'long') String? long}) = _LiveTimeStatus;

  factory LiveTimeStatus.fromCollection(LiveTimeStatusEmbedded collection) =>
      LiveTimeStatus(short: collection.short, long: collection.long);

  LiveTimeStatusEmbedded get toCollection => LiveTimeStatusEmbedded()
    ..long = long
    ..short = short;

  factory LiveTimeStatus.fromJson(Map<String, dynamic> json) => _$LiveTimeStatusFromJson(json);
}
