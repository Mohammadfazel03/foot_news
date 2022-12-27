part of 'bottom_nav_cubit.dart';


class BottomNavState {
  late final int index;
  late final BottomNavItem navItem;

  BottomNavState({required this.index, required this.navItem});

  BottomNavState.init() {
    index = 0;
    navItem = BottomNavItem.matches;
  }

}