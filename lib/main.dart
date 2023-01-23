import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foot_news/di.dart';
import 'package:foot_news/ui/home/home_screen.dart';
import 'package:foot_news/ui/theme/theme.dart';
import 'package:foot_news/ui/theme/theme_cubit.dart';
import 'package:foot_news/ui/widgets/tabbar/tab_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => getIt<ThemeCubit>()),
      BlocProvider(create: (context) => getIt<TabBloc>()),
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