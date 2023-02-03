import 'package:foot_news/data/local/collections/match_collection.dart';
import 'package:foot_news/data/local/collections/match_league_collection.dart';
import 'package:foot_news/data/remote/api_service.dart';
import 'package:foot_news/data/repository/match_repository.dart';
import 'package:foot_news/data/repository/match_repository_impl.dart';
import 'package:foot_news/ui/games/fixture/fixture_tab_bloc.dart';
import 'package:foot_news/ui/games/widgets/filter_chip/filter_chip_cubit.dart';
import 'package:foot_news/ui/games/widgets/tabbar/tab_bloc.dart';
import 'package:foot_news/ui/home/widgets/bottom_nav/bottom_nav_cubit.dart';
import 'package:foot_news/ui/theme/theme_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // register bloc
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  getIt.registerLazySingleton<TabBloc>(() => TabBloc());
  getIt.registerFactoryParam<FixtureTabBloc, DateTime, void>(
      (dateTime, _) => FixtureTabBloc(matchRepository: getIt(), dateTime: dateTime));
  getIt.registerLazySingleton<BottomNavCubit>(() => BottomNavCubit());
  getIt.registerLazySingleton<FilterChipCubit>(() => FilterChipCubit());

  // register local data
  getIt.registerSingleton<Isar>(
      await Isar.open([MatchCollectionSchema, MatchLeagueCollectionSchema]));
  // register remote data
  getIt.registerSingleton<ApiService>(ApiService());

  // register repository
  getIt.registerFactory<MatchRepository>(() => MatchRepositoryImpl(api: getIt(), isar: getIt()));
}
