import 'package:foot_news/ui/theme/theme.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState.init());

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState(
        themeApp: (json['theme'] == ThemeApp.LightTheme.name)
            ? ThemeApp.LightTheme
            : ThemeApp.DarkTheme);
  }

  @override
  Map<String, String>? toJson(ThemeState state) {
    return {'theme': state.themeApp.name};
  }
}
