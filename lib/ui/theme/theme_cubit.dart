import 'package:foot_news/ui/theme/theme.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';
part 'theme_cubit.freezed.dart';
part 'theme_cubit.g.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(themeApp: ThemeApp.lightTheme));

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return state.toJson();
  }
}
