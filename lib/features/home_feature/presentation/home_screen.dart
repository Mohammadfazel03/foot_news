import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foot_news/di.dart';
import 'package:foot_news/features/favorite_feature/presentation/favorites_screen.dart';
import 'package:foot_news/features/home_feature/presentation/widgets/bottom_nav/bottom_nav.dart';
import 'package:foot_news/features/home_feature/presentation/widgets/bottom_nav/bottom_nav_cubit.dart';
import 'package:foot_news/features/matches_feature/presentation/screens/games_screen.dart';
import 'package:foot_news/features/news_feature/presentation/news_screen.dart';
import 'package:foot_news/features/setting_feature/presentation/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocProvider(
        create: (context) => getIt<BottomNavCubit>(),
        child: BottomNav(
          controller: _controller,
        ),
      ),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: _getBottomNavScreen(),
      ),
    );
  }

  List<Widget> _getBottomNavScreen() => [
        const GamesScreen(),
        const NewsScreen(),
        const FavoritesScreen(),
        const SettingScreen(),
      ];
}
