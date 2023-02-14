import 'package:dio/dio.dart';
import 'package:foot_news/config/dio_config.dart';
import 'package:foot_news/features/home_feature/presentation/widgets/bottom_nav/bottom_nav_cubit.dart';
import 'package:foot_news/features/matches_feature/data/local/collections/match_collection.dart';
import 'package:foot_news/features/matches_feature/data/local/collections/match_league_collection.dart';
import 'package:foot_news/features/matches_feature/data/remote/matches_api_service.dart';
import 'package:foot_news/features/matches_feature/data/repository/match_repository.dart';
import 'package:foot_news/features/matches_feature/data/repository/match_repository_impl.dart';
import 'package:foot_news/features/matches_feature/presentation/bloc/fixture_tab_bloc.dart';
import 'package:foot_news/features/matches_feature/presentation/widget/filter_chip/filter_chip_cubit.dart';
import 'package:foot_news/features/matches_feature/presentation/widget/tabbar/tab_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'config/theme/theme_cubit.dart';

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
  getIt.registerSingleton<Dio>(getDioConfiguration());
  getIt.registerSingleton<MatchesApiService>(MatchesApiService(dio: getIt()));

  // register repository
  getIt.registerFactory<MatchRepository>(() => MatchRepositoryImpl(api: getIt(), isar: getIt()));
}
