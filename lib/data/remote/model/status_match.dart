import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_match.freezed.dart';
part 'status_match.g.dart';

@freezed
class StatusMatch with _$StatusMatch {
  const factory StatusMatch({
    @JsonKey(name: 'utcTime') String? utcTime,
    @JsonKey(name: 'started') bool? started,
    @JsonKey(name: 'cancelled') bool? cancelled,
    @JsonKey(name: 'finished') bool? finished,
  }) = _StatusMatch;

  factory StatusMatch.fromJson(Map<String, Object?> json) => _$StatusMatchFromJson(json);
}
