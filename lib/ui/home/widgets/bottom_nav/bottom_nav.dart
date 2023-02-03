import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_cubit.dart';
import 'bottom_nav_item.dart';

class BottomNav extends StatelessWidget {
  final PageController _controller;

  const BottomNav({Key? key, required PageController controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius:
              const BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              backgroundColor: Theme.of(context).primaryColorDark,
              selectedItemColor: Theme.of(context).colorScheme.secondary,
              unselectedItemColor: Theme.of(context).unselectedWidgetColor,
              currentIndex: state.index,
              onTap: (index) {
                _controller.animateToPage(index,
                    duration: const Duration(milliseconds: 300), curve: Curves.linear);
                switch (index) {
                  case 0:
                    BlocProvider.of<BottomNavCubit>(context).setIndex(index, BottomNavItem.matches);
                    break;
                  case 1:
                    BlocProvider.of<BottomNavCubit>(context).setIndex(index, BottomNavItem.news);
                    break;
                  case 2:
                    BlocProvider.of<BottomNavCubit>(context)
                        .setIndex(index, BottomNavItem.favorites);
                    break;
                  case 3:
                    BlocProvider.of<BottomNavCubit>(context).setIndex(index, BottomNavItem.setting);
                    break;
                  default:
                    BlocProvider.of<BottomNavCubit>(context).setIndex(0, BottomNavItem.matches);
                    break;
                }
              },
              items: [
                BottomNavigationBarItem(
                    activeIcon: ImageIcon(
                      const AssetImage('assets/images/nav-ball.png'),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    icon: const ImageIcon(AssetImage('assets/images/nav-ball.png')),
                    label: 'Matches'),
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.newspaper,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    icon: const Icon(Icons.newspaper),
                    label: 'News'),
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.star_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    icon: const Icon(Icons.star_outline_rounded),
                    label: 'Favorites'),
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.settings,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    icon: const Icon(Icons.settings),
                    label: 'Settings'),
              ]),
        );
      },
    );
  }
}
