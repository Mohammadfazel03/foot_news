import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_chip_cubit.freezed.dart';

part 'filter_chip_state.dart';

class FilterChipCubit extends Cubit<FilterChipState> {
  FilterChipCubit() : super(const FilterChipState(selectedItems: []));

  selectItem(int index) {
    List<int> list = [];
    list.addAll(state.selectedItems);
    list.add(index);
    emit(state.copyWith(selectedItems: list));
  }

  unSelectItem(int index) {
    List<int> list = [];
    list.addAll(state.selectedItems);
    list.remove(index);
    emit(state.copyWith(selectedItems: list));
  }
}
