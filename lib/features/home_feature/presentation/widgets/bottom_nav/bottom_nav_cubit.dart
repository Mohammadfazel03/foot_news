import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'bottom_nav_item.dart';

part 'bottom_nav_cubit.freezed.dart';
part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState(index: 0, navItem: BottomNavItem.matches));

  setIndex(int index, BottomNavItem navItem) {
    emit(BottomNavState(index: index, navItem: navItem));
  }
}
