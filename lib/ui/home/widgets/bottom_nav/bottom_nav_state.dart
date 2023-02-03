part of 'bottom_nav_cubit.dart';

@freezed
class BottomNavState with _$BottomNavState {
  const factory BottomNavState({required int index, required BottomNavItem navItem}) =
      _BottomNavState;
}
