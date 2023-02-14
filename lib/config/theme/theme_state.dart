part of 'theme_cubit.dart';

@freezed
class ThemeState with _$ThemeState {
  const ThemeState._();

  const factory ThemeState({@JsonKey(name: 'theme') required ThemeApp themeApp}) = _ThemeState;

  factory ThemeState.fromJson(Map<String, Object?> json) => _$ThemeStateFromJson(json);
}
