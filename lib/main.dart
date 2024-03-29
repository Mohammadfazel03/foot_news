import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foot_news/di.dart';
import 'package:foot_news/features/home_feature/presentation/home_screen.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'config/theme/theme.dart';
import 'config/theme/theme_cubit.dart';
import 'features/matches_feature/presentation/widget/filter_chip/filter_chip_cubit.dart';
import 'features/matches_feature/presentation/widget/tabbar/tab_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );
  await setup();
  await getIt.allReady();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => getIt<ThemeCubit>()),
      BlocProvider(create: (context) => getIt<TabBloc>()),
      BlocProvider(create: (context) => getIt<FilterChipCubit>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeApp[state.themeApp],
          home: const HomeScreen(),
        );
      },
    );
  }
}
