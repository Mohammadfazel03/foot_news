import 'package:bloc/bloc.dart';

import 'bottom_nav_item.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavState.init());

  setIndex(int index, BottomNavItem navItem) {
    emit(BottomNavState(index: index, navItem: navItem));
  }
}
