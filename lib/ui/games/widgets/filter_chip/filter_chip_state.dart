part of 'filter_chip_cubit.dart';

@freezed
class FilterChipState with _$FilterChipState{
  const factory FilterChipState({
    required List<int> selectedItems,
  }) = _FilterChipState;
}
